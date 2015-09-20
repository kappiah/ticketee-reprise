require "rails_helper"

RSpec.feature "authentication and signup" do
  let!(:user) { FactoryGirl.create(:user) }

  scenario "users can successfully signup" do
    visit "/"
    click_link "Sign In"
    click_link "Sign up"

    fill_in "Email", with: "newuser@example.com"
    fill_in "Password", with: "password"

    click_button "Sign up"

    expect(page).to have_content("You have signed in successfully")

    within ".user-info" do
      expect(page).to have_content("newuser@example.com")
    end
  end

  scenario "users can successfully signin" do
    visit "/"
    click_link "Sign In"
    fill_in "Email", with: user.email
    fill_in "Password", with: "password"

    click_button "Sign in"

    expect(page).to have_content("You have signed in successfully")

    within ".user-info" do
      expect(page).to have_content(user.email)
    end
  end
end
