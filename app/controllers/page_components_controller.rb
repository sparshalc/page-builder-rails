# app/controllers/page_components_controller.rb
class PageComponentsController < ApplicationController
  before_action :set_page
  before_action :set_page_component, only: [ :update, :destroy, :move, :properties ]

  def create
    @component = Component.find(params[:component_id])
    position = params[:position] || (@page.page_components.maximum(:position) || 0) + 1

    @page_component = @page.page_components.build(
      component: @component,
      position: position
    )

    # Shift existing components down if inserting in middle
    if position <= @page.page_components.maximum(:position).to_i
      @page.page_components.where("position >= ?", position).update_all("position = position + 1")
    end

    if @page_component.save
      render turbo_stream: [
        turbo_stream.append("page-components", partial: "page_components/component", locals: { page_component: @page_component }),
        turbo_stream.replace("component-count-#{@component.id}", partial: "components/usage_count", locals: { component: @component })
      ]
    else
      render turbo_stream: turbo_stream.replace("notices", partial: "shared/error", locals: { message: @page_component.errors.full_messages.join(", ") })
    end
  end

  def update
    if @page_component.update(page_component_params)
      respond_to do |format|
        format.html { redirect_to edit_page_path(@page) }
        format.json { render json: { status: "success" } }
        format.turbo_stream {
          render turbo_stream: turbo_stream.replace(@page_component, partial: "page_components/component", locals: { page_component: @page_component })
        }
      end
    else
      respond_to do |format|
        format.html { render :edit }
        format.json { render json: { errors: @page_component.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @page_component.destroy
    render turbo_stream: turbo_stream.remove(@page_component)
  end

  def move
    new_position = params[:position].to_i

    ActiveRecord::Base.transaction do
      # Get current position
      old_position = @page_component.position

      if new_position != old_position
        # Moving down
        if new_position > old_position
          @page.page_components
            .where(position: (old_position + 1)..new_position)
            .update_all("position = position - 1")
        # Moving up
        else
          @page.page_components
            .where(position: new_position..(old_position - 1))
            .update_all("position = position + 1")
        end

        @page_component.update!(position: new_position)
      end
    end

    head :ok
  end

  def properties
    respond_to do |format|
      format.html { render partial: "page_components/properties", locals: { page_component: @page_component, page: @page } }
      format.turbo_stream {
        render turbo_stream: turbo_stream.update("component-properties",
          partial: "page_components/properties",
          locals: { page_component: @page_component, page: @page }
        )
      }
    end
  end

  private

  def set_page
    @page = Page.find_by!(slug: params[:page_id])
  end

  def set_page_component
    @page_component = @page.page_components.find(params[:id])
  end

  def page_component_params
    params.require(:page_component).permit(custom_properties: {})
  end
end
