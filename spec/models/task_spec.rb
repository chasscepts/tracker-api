require 'rails_helper'

RSpec.describe Task, type: :model do
  it { should have_many(:entries).dependent(:destroy) }
  it { should belong_to(:group) }
  it { should belong_to(:user) }
  it { should validate_presence_of(:title) }
end
