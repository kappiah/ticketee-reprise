require "rails_helper"

RSpec.feature "Admins can manage user roles" do
  let(:admin) { FactoryGirl.create(:user, :admin) }
  let(:user) { FactoryGirl.create(:user) }

  let!(:ie) { FactoryGirl.create(:project, name: "Internet Explorer") }
  let!(:st3) { FactoryGirl.create(:project, name: "Sublime Text 3") }

  scenario "when assigning roles for an existing user" do
    visit admin_user_path(user, as: admin)
    click_link "Edit User"

    select "Viewer", from: "Internet Explorer"
    select "Manager", from: "Sublime Text 3"
    click_button "Update User"

    expect(page).to have_content("User has been updated")

    click_link user.email
    expect(page).to have_content("Viewer: Internet Explorer")
    expect(page).to have_content("Manager: Sublime Text 3")
  end

  scenario "when creating a new user" do
    visit new_admin_user_path as: admin

    fill_in "Email", with: "newuser@example.com"
    fill_in "Password", with: "password"
    select "Editor", from: "Internet Explorer"

    click_button "Create/Update User"

    expect(page).to have_content("User has been created")

    click_link "newuser@example.com"
    expect(page).to have_content("Editor: Internet Explorer")
    expect(page).to_not have_content("Sublime Text 3")
  end
end
