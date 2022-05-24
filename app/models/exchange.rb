class Exchange < ApplicationRecord
  validates_presence_of :name, :amount

  belongs_to :author, class_name: 'User'
  validates_presence_of :author
end
