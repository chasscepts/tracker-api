class Group < ApplicationRecord
  has_many :tasks, dependent: :destroy
  has_many :default_tasks, dependent: :destroy

  validates :title, presence: true
end
