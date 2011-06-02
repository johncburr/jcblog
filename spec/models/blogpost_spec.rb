require 'spec_helper'

describe Blogpost do
  it { should belong_to(:user) }
  it { should validate_presence_of(:title) }
  it { should ensure_length_of(:title).is_at_most(255)  }
  it { should validate_presence_of(:entry_text) }
  it { should validate_presence_of(:user_id) }
  it { should_not be_valid }
end