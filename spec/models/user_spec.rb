require 'spec_helper'

describe User do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should ensure_length_of(:name).is_at_most(48).with_short_message(/48 character or less/) }
  it { should validate_format_of(:email).with(/\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i) }
  it { should_not be_valid }
  it { should have_many(:blogposts) }
end