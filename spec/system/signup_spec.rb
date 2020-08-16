# frozen_string_literal: true

require "rails_helper"

describe "Sign up", type: :system do
  before do
    driven_by(:selenium)
  end

  before(:each) do
    click_link "Log In"
    click_link('#popupSignupLink')
  end

  it "should not sign-up when no credentials" do
    click_button "Sign up"

    expect(page).to have_text("Email can't be blank")
    expect(page).to have_text("Password can't be blank")
  end

  it "should not sign-up when password is empty" do
    fill_in "Name", with: "user1"
    fill_in "Email", with: "user1@example.com"
    click_button "Sign up"

    expect(page).to have_text("Password can't be blank")
  end

  it "should not sign-up when email is empty" do
    fill_in "Name", with: "user1"
    fill_in "Password", with: "secret"
    click_button "Sign up"

    expect(page).to have_text("Email can't be blank")
  end

  it "should not sign-up when password is less than 6 characters" do
    fill_in "Name", with: "user1"
    fill_in "Password", with: "secr"
    click_button "Sign up"

    expect(page).to have_text("Password is too short (minimum is 6 characters)")
  end


  it "should sign-up when valid credentials" do
    fill_in "Name", with: "user1"
    fill_in "Email", with: "user1@example.com"
    fill_in "Password", with: "secret"
    click_button "Sign up"

    expect(page).to have_text(@user.name.to_s)
  end
end
