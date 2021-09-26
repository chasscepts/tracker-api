require 'rails_helper'

RSpec.describe DefaultTask, type: :model do
  it { should belong_to(:group) }
  it { should validate_presence_of(:title) }
end
