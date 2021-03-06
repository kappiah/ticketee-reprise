require "rails_helper"

RSpec.feature "users can delete tickets" do
  let(:user) { FactoryGirl.create(:user) }
  let(:project) { FactoryGirl.create(:project) }
  let(:ticket) {FactoryGirl.create(:ticket, project: project, author: user) }

  before do
    assign_role!(user, :manager, project)
    visit project_ticket_path(project, ticket, as: user)
  end

  scenario "successfully" do
    click_link "Delete Ticket"

    expect(page).to have_content("Ticket has been deleted")
    expect(page.current_url).to eq(project_url(project))
  end
end
