# frozen_string_literal: true

class Favorite
  include Mongoid::Document
  include Mongoid::Timestamps

  STATES = ['NY'].freeze
  CATEGORIES = %w[NIGHTLIFE FRIENDS FAMILY WORK STORES OTHER].freeze
  DEFAULT_ICON_COLOR = 'DEFAULT_ICON_COLOR'

  class << self
    def get_param_inclusion_message(valid_param_types)
      "must be one of: #{valid_param_types.join(', ')}"
    end
  end

  validates_presence_of  :user_id, :name, :street_address, :zip_code, :state
  validates_inclusion_of :state, in: STATES, message: get_param_inclusion_message(STATES)
  validates_inclusion_of :category, in: CATEGORIES, message: get_param_inclusion_message(CATEGORIES)
  validates_uniqueness_of :street_address, scope: %i[user_id zip_code], case_sensitive: false, message: 'favorite with this address already exists'

  field :user_id, type: String
  field :name, type: String
  field :street_address, type: String
  field :zip_code, type: Integer
  field :state, type: String
  field :icon_color, type: String, default: DEFAULT_ICON_COLOR
  field :category, type: String
end
