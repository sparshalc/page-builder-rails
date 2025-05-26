class Page < ApplicationRecord
  has_many :page_components, -> { order(:position) }, dependent: :destroy
  has_many :components, through: :page_components

  validates :title, presence: true
  validates :slug, presence: true, uniqueness: true

  before_validation :generate_slug, on: :create

  def to_param
    slug
  end

  private

  def generate_slug
    self.slug = title.parameterize if title.present? && slug.blank?
  end
end
