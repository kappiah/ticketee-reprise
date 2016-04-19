require "rails_helper"

RSpec.feature "admins can create new states for tickets" do
  let(:admin) { FactoryGirl.create(:user, :admin) }

  scenario "with valid details" do
    visit admin_root_path as: admin

    click_link "States"
    click_link "New State"

    fill_in "Name", with: "Won't fix"
    fill_in "Colour", with: "orange"

    click_button "Create state"

    expect(page).to have_content("State has been created")
  end
end
