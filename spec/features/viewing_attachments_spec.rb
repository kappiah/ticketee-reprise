require "rails_helper"

RSpec.feature "Users can view a tickets attached files" do
  let(:user) { FactoryGirl.create(:user) }
  let(:project) { FactoryGirl.create(:project) }
  let(:ticket) { FactoryGirl.create(:ticket, project: project, author: user) }
  let!(:attachment) { FactoryGirl.create(:attachment, ticket: ticket) }

  before do
    assign_role!(user, :viewer, project)
  end

  scenario "successfully" do
    visit project_ticket_path(project, ticket, as: user)

    click_link("speed.txt")
    expect(current_path).to eq attachment_path(attachment)
    expect(page).to have_content("The blink tag can blink faster")
  end
end
