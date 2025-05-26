# app/controllers/pages_controller.rb
class PagesController < ApplicationController
  before_action :set_page, only: [ :show, :edit, :update, :destroy, :preview ]

  def index
    @pages = Page.all
  end

  def show
    render layout: "public_page"
  end

  def new
    @page = Page.new
  end

  def create
    @page = Page.new(page_params)

    if @page.save
      redirect_to edit_page_path(@page), notice: "Page created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @components = Component.all.group_by(&:component_type)
    @page_components = @page.page_components.includes(:component)
  end

  def update
    if @page.update(page_params)
      redirect_to edit_page_path(@page), notice: "Page updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @page.destroy
    redirect_to pages_path, notice: "Page deleted successfully."
  end

  def preview
    render :show, layout: "public_page"
  end

  private

  def set_page
    @page = Page.find_by!(slug: params[:id])
  end

  def page_params
    params.require(:page).permit(:title, :slug, :published)
  end
end
