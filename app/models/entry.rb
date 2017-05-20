class Entry < ApplicationRecord
  belongs_to :profile

  validates_presence_of :content
end
