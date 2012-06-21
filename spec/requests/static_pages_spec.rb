require 'spec_helper'

describe "Static pages" do
  let(:base_title) { "SWP-Beispiel" }
  
  describe "Home page" do
      before { visit '/static_pages/home' }
      it { page.should have_selector('h1', text: 'Homepage') }
      it { page.should have_selector('title', text: "#{base_title} - Home") }
  end
  
  describe "Help page" do
      before { visit '/static_pages/help' }
      it { page.should have_selector('h1', text: 'Help page') }
      it { page.should have_selector('title', text: "#{base_title} - Help") }
  end
end