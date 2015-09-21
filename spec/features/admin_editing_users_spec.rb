require "rails_helper"

RSpec.feature "Admins can edit users" do
  let(:admin) { FactoryGirl.create(:user, :admin) }
  let(:user) { FactoryGirl.create(:user) }

  before do
    visit admin_user_path(user, as: admin)
    click_link "Edit User"
  end

  scenario "with valid details" do
    fill_in "Email", with: "updateduser@example.com"
    click_button "Create/Update User"

    expect(page).to have_content("User has been updated")
    expect(page).to have_content("updateduser@example.com")
    expect(page).to_not have_content user.email
  end

  scenario "when toggling a users admin status" do
    check "Is an Admin?"
    click_button "Create/Update User"

    expect(page).to have_content("User has been updated")
    expect(page).to have_content("#{user.email} (Admin)")
  end
end
