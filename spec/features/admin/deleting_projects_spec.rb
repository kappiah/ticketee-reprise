require "rails_helper"

RSpec.feature "users can delete projects" do
  let(:user) { FactoryGirl.create(:user, :admin) }

  before do
    FactoryGirl.create(:project, name: "Sublime Text 3")

    visit root_path as: user
    click_link "Sublime Text 3"
  end

  scenario "successfully" do
    click_link "Delete Project"

    expect(page).to have_content "Project has been deleted"
    expect(page.current_url).to eq(projects_url)
    expect(page).not_to have_content "Sublime Text 3"
  end
end
