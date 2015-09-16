require "rails_helper"

RSpec.feature "Users can create new projects" do
  before do
    visit "/"

    click_link "New Project"
  end

  scenario "with valid attributes" do
    fill_in "Name", with: "Sublime Text 3"
    fill_in "Description", with: "A Text editor for everyone"
    click_button "Create Project"

    expect(page).to have_content("Project has been created")
  end

  scenario "with invalid attributes" do
    click_button "Create Project"

    expect(page).to have_content "Project has not been created"
    expect(page).to have_content "Name can't be blank"
  end
end
