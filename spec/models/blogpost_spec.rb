require 'spec_helper'

describe Blogpost do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:entry_text) }
  it { should validate_presence_of(:user_id) }
  it { should ensure_length_of(:entry_text).is_at_most(255)  }
  
  it { should_not be_valid }
end