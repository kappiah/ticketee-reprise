require "rails_helper"

RSpec.feature "Users can create new projects" do
  scenario "with valid attributes" do
    visit "/"

   click_link "New Project"

   fill_in "Name", with: "New Project"
   fill_in "Description", with: "A Text editor for everyone"
   click_button "Create Project"

   expect(page).to have_content("Project has been created")
  end
end
