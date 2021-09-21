require 'rails_helper'

RSpec.describe Group, type: :model do
  it { should have_many(:tasks).dependent(:destroy) }
  it { should have_many(:default_tasks).dependent(:destroy) }
  it { should validate_presence_of(:title) }
end
