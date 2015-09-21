require "rails_helper"

RSpec.feature "Admins can archive users" do
  let(:admin) { FactoryGirl.create(:user, :admin) }
  let(:user) { FactoryGirl.create(:user) }

  before do
  end

  scenario "successfully" do
    visit admin_user_path(user, as: admin)
    click_link "Archive User"

    expect(page).to have_content("User has been archived")
    expect(page).to_not have_content(user.email)
  end

  scenario "users can archive themselves" do
    visit admin_user_path(admin, as: admin)

    click_link "Archive User"
    expect(page).to have_content("You cannot archive yourself!")
  end
end
