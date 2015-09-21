require "rails_helper"

RSpec.feature "Admins can create new users" do
  let(:admin) { FactoryGirl.create(:user, :admin) }

  before do
    visit root_path as: admin
    click_link "Admin"
    click_link "Users"
    click_link "New User"
  end

  scenario "with valid credentials" do
    fill_in "Email", with: "newuser@example.com"
    fill_in "Password", with: "password"
    click_button "Create/Update User"

    expect(page).to have_content("User has been created")
  end

  scenario "when the user is an admin" do
    fill_in "Email", with: "newadmin@example.com"
    fill_in "Password", with: "password"
    check "Is an Admin?"

    click_button "Create/Update User"

    expect(page).to have_content("User has been created")
    expect(page).to have_content("newadmin@example.com (Admin)")
  end
end
