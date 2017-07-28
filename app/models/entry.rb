class Entry < ApplicationRecord
  belongs_to :user

  validates_presence_of :content, #:linked_user_id
end
