class Event < ApplicationRecord
    has_many :appointments, dependent: :destroy
    has_many :participants, through: :appointments
end
