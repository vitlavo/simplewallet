# frozen_string_literal: true

module CommonValidation
  extend ActiveSupport::Concern

  included do
    validates :name, presence: true
  end
end
