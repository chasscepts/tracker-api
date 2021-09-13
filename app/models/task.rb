class Task < ApplicationRecord
  belongs_to :group
  has_many :entries

  validates :title, presence: true
end
