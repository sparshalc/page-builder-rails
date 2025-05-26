class Component < ApplicationRecord
  has_many :page_components, dependent: :destroy
  has_many :pages, through: :page_components
  has_many_attached :images

  validates :name, presence: true
  validates :component_type, presence: true
  validates :html_content, presence: true

  TYPES = %w[header hero text image gallery footer card button].freeze

  validates :component_type, inclusion: { in: TYPES }
  validate :properties_are_valid_json

  before_save :sanitize_html_content

  def sanitize_html_content
    self.html_content = ActionController::Base.helpers.sanitize(
      html_content,
      tags: %w[div span p h1 h2 h3 h4 h5 h6 a img section article header footer nav ul li ol table tr td th strong em br hr],
      attributes: %w[class id style href src alt title data-*]
    )
  end

  def properties_are_valid_json
    JSON.parse(properties.to_json)
  rescue JSON::ParserError
    errors.add(:properties, "must be valid JSON")
  end

  def render_html(custom_properties = {})
    merged_properties = properties.merge(custom_properties)
    html = html_content.dup

    merged_properties.each do |key, value|
      html.gsub!("{{#{key}}}", value.to_s)
    end

    html.html_safe
  end
end
