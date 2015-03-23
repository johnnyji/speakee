require 'rails_helper'

RSpec.describe "Confessions", type: :request do
  describe "on index page" do
    before(:each) do
      visit root_path
    end

    it "should have a new confession link" do
      page.should have_link("Write a confession")
    end
  end
end
