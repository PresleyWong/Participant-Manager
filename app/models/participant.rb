class Participant < ApplicationRecord
    has_many :appointments
    has_many :events, through: :appointments
end
