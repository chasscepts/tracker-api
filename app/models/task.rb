class Task < ApplicationRecord
  belongs_to :group

  validates :title, presence: true
end
