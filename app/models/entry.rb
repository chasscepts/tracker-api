class Entry < ApplicationRecord
  belongs_to :task

  validates :entry_date, presence: true
end
