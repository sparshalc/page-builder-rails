class PageComponent < ApplicationRecord
  belongs_to :page
  belongs_to :component

  validates :position, presence: true, uniqueness: { scope: :page_id }

  before_validation :set_position, on: :create

  def render_html
    component.render_html(custom_properties)
  end

  private

  def set_position
    self.position ||= (page.page_components.maximum(:position) || 0) + 1
  end
end
