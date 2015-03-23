require 'rails_helper'

RSpec.describe "Confessions", type: :request do

  describe "on index page" do
    before(:each) do
      visit root_path
    end

    it "should have a new confession link" do
      page.should have_link("Write a confession")
    end

    it "should have confessions" do
      page.should have_css("div.confessions-list-container")
    end

    it "redirects to sign in page if logged out user tries to post" do
      click_link("Write a confession")
      current_path.should eq(new_session_path)
    end

    # it "redirects user to facebook auth when sign in is clicked" do
    #   click_link("Sign in with Facebook")
    #   current_path.should eq("/auth/facebook")
    # end
  end

  describe "on show page" do
    before(:each) do
      confession = Confession.create(title: "Hello", body: "blah blah #blah")
      visit confession_path(confession)
    end

    it "contains a confession" do
      page.should have_selector("h1", text: "Hello")
      page.should have_selector("p", text: "blah blah #blah")
    end

    it "contains a comment area" do
      page.should have_selector("textarea")
      page.should have_selector("input")
    end

    it "has hashtags that link to their pages" do
      body.should have_selector("a", text: "#blah")
      click_link("#blah")
      current_path.should eq(hashtag_path)
    end #why doesnt it show the hashtag link?
  end

end
