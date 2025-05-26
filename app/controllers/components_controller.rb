# app/controllers/components_controller.rb
class ComponentsController < ApplicationController
  before_action :set_component, only: [ :show, :edit, :update, :destroy ]

  def index
    @components = Component.all.group_by(&:component_type)
  end

  def new
    @component = Component.new(component_type: params[:component_type])
  end

  def create
    @component = Component.new(component_params)

    if @component.save
      redirect_to components_path, notice: "Component created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @component.update(component_params)
      redirect_to components_path, notice: "Component updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @component.destroy
    redirect_to components_path, notice: "Component deleted successfully."
  end

  private

  def set_component
    @component = Component.find(params[:id])
  end

  def component_params
    params.require(:component).permit(:name, :component_type, :html_content, :reusable, properties: {}, images: [])
  end
end
