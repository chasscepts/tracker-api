class Task < ApplicationRecord
  belongs_to :group
  belongs_to :user
  has_many :entries, dependent: :destroy

  validates :title, presence: true
end
