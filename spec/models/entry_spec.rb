require 'rails_helper'

RSpec.describe Entry, type: :model do
  it { should belong_to(:task) }
  it { should validate_presence_of(:entry_date) }
end
