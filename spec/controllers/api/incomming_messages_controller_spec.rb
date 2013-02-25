require 'spec_helper'

describe Api::IncommingMessagesController do
  context "POST create" do
    User.create fullname: "Roy", email: "roy@nvyuzhe.com", password: "poipoi"
    post :create, sender: "roy@nvyuzhe.com", "stripped-text" => "text"
    User.first.issues.count.should == 1
  end
end
