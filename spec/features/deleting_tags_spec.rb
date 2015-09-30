require "rails_helper"

RSpec.feature "Users can delete unwanted tags from a ticket" do
  let(:user) { FactoryGirl.create(:user) }
  let(:project) { FactoryGirl.create(:project) }
  let(:ticket) do
    FactoryGirl.create(:ticket,
                       project: project,
                       tag_names: "thistagmustdie",
                       author: user)
  end

  before do
    assign_role!(user, :manager, project)
    visit project_ticket_path(project, ticket, as: user)
  end

  scenario "successfully", js: true do
   within tag("thistagmustdie") do
     click_link("Remove")
   end

   expect(page).to_not have_content("thistagmustdie")
  end
end
