class Appointment < ApplicationRecord
  belongs_to :participant
  belongs_to :event
end
