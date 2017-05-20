class Profile < ApplicationRecord
  has_many :entries, dependent: :destroy

  validates_presence_of :firstname, :lastname
end
