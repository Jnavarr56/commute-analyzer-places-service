# frozen_string_literal: true

class Apartment
  include Mongoid::Document
  include Mongoid::Timestamps

  STATES = ['NY'].freeze
  TYPES = %w[STANDARD ROOM STUDIO].freeze
  STATUSES = ['CONSIDERING', 'VISIT SCHEDULED', 'VISITED', 'APPLIED', 'SIGNED'].freeze
  DEFAULT_ICON_COLOR = 'DEFAULT_ICON_COLOR'

  class << self
    def get_param_inclusion_message(valid_param_types)
      "must be one of: #{valid_param_types.join(', ')}"
    end
  end

  validates_presence_of :user_id, :name, :street_address, :zip_code, :state, :bedrooms, :bathrooms, :price
  validates_uniqueness_of :street_address, scope: %i[user_id zip_code], case_sensitive: false, message: 'apartment with this address already exists'
  validates_inclusion_of :state, in: STATES, message: get_param_inclusion_message(STATES)
  validates_inclusion_of :type, in: TYPES, message: get_param_inclusion_message(TYPES)
  validates_inclusion_of :status, in: STATUSES, message: get_param_inclusion_message(STATUSES)
  validates_numericality_of :price, greater_than: 0
  validates_numericality_of :bedrooms, :bathrooms, greater_than_or_equal_to: 0

  field :user_id, type: String
  field :name, type: String
  field :street_address, type: String
  field :zip_code, type: Integer
  field :state, type: String
  field :icon_color, type: String, default: DEFAULT_ICON_COLOR
  field :type, type: String, default: TYPES[0]
  field :bedrooms, type: Integer
  field :bathrooms, type: Integer
  field :price, type: Integer
  field :status, type: String, default: STATUSES[0]
end
