require 'spec_helper'

describe "UserPages" do
  subject { page }
  
  describe "signup page" do
    before { visit signup_path }
    
    it { should have_selector('h1', text: 'Sign up') }
    it { should have_selector('title', text: full_title('Sign up')) }
  end
  
  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }
    
    it { should have_selector('h1', text: user.name) }
    it { should have_selector('title', text: user.name) }
  end
  
  describe "signup" do
    before { visit signup_path }
    let(:submit) { "Create account" }
    
    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count) 
      end
    end
    
    describe "with valid information" do
      before do
        fill_in "Name",             with: "Example"
        fill_in "Email",            with: "test@example.com"
        fill_in "Password",         with: "foobar"
        fill_in "Confirmation",     with: "foobar"
      end
      
      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
    end
  end
  
  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit edit_user_path(user)
    end
    
    describe "page" do
      it { should have_selector('h1', text: "Update your data!") }
      it { should have_selector('title', text: "Edit user")  }
    end
    
    describe "with invalid information" do
      before { click_button "Save changes" }
      
      it { should have_content('error') }
    end
    
    describe "with valid information" do
      let(:new_name) { "New Name" }
      let(:new_email) { "new@example.com" }
      
      before do
        fill_in "Name",             with: new_name
        fill_in "Email",            with: new_email
        fill_in "Password",         with: user.password
        fill_in "Confirmation",     with: user.password
        click_button "Save changes"
      end
      
      it { should have_content(' successfully updated') }
      it { should have_selector('h1', text: new_name.downcase)  }
      it { should have_link('Sign out', href: signout_path) }
      
      specify { user.reload.name.should == new_name.downcase }
      specify { user.reload.email.should == new_email }
    end
  end
end