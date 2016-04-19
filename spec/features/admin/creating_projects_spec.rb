require "rails_helper"

RSpec.feature "Users can create new projects" do
  let(:user) { FactoryGirl.create(:user, :admin) }

  before do
    visit root_path as: user

    click_link "New Project"
  end

  scenario "with valid attributes" do
    fill_in "Name", with: "Sublime Text 3"
    fill_in "Description", with: "A Text editor for everyone"
    click_button "Create project"

    expect(page).to have_content("Project has been created")
  end

  scenario "with invalid attributes" do
    click_button "Create project"

    expect(page).to have_content "Project has not been created"
    expect(page).to have_content "Name can't be blank"
  end
end
