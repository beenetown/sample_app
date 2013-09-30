require 'spec_helper'

describe Message do
  let(:user) { FactoryGirl.create(:user) }
  let(:recipient) { FactoryGirl.create(:user) }

  before { @message = user.messages.build(from_id: user.id,
                                          to_id: recipient.id,
                                          content: "Lorem ipsum") }         

  subject { @message }

  it { should respond_to(:content) }
  it { should respond_to(:from_id) }
  it { should respond_to(:to_id) }
  its(:user) { should eq user }
    
  it { should be_valid }
end
