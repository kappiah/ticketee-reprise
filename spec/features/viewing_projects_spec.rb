require 'rails_helper'

RSpec.feature "Users can view projects" do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:project) { FactoryGirl.create(:project, name: "Sublime Text 3") }
  let!(:hidden) { FactoryGirl.create(:project, name: "Nothing to see here") }

  before do
    assign_role!(user, :viewer, project)
    visit root_path as: user
  end

  scenario "with the project details" do
    click_link "Sublime Text 3"
    expect(page.current_url).to eq(project_url(project))
  end

  scenario "unless they have permission to do so" do
    expect(page).to_not have_content("Nothing to see here")
  end
end
