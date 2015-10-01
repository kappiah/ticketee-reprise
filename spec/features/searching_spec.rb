require "rails_helper"

RSpec.feature "Users can search for tickets matching specific criteria" do
  let(:user) { FactoryGirl.create(:user) }
  let(:project) { FactoryGirl.create(:project) }
  let!(:ticket_1) { FactoryGirl.create(:ticket, name: "Create Projects",
                                      project: project, author: user,
                                      tag_names: "iteration_1") }

  let!(:ticket_2) { FactoryGirl.create(:ticket, name: "Create Users",
                                      project: project, author: user,
                                      tag_names: "iteration_2") }

  before do
    assign_role!(user, :manager, project)
    visit project_path(project, as: user)
  end

  scenario "searching by tag" do
    fill_in "Search", with: "tag:iteration_1"
    click_button("Search")

    within("#tickets") do
      expect(page).to have_link("Create Projects")
      expect(page).to_not have_link("Create Users")
    end
  end
end
