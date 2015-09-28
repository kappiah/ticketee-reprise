require "rails_helper"

RSpec.feature "users can comment on tickets" do
  let(:user) { FactoryGirl.create(:user) }
  let(:project) { FactoryGirl.create(:project) }
  let(:ticket) { FactoryGirl.create(:ticket, project: project, author: user) }

  before do
    assign_role!(user, :manager, project)
  end

  scenario "with valid attributes" do
    visit project_ticket_path(project, ticket, as: user)
    fill_in "Text", with: "Added a comment!"
    click_button("Create Comment")

    expect(page).to have_content("Comment has been created")

    within("#comments") do
      expect(page).to have_content("Added a comment!")
    end
  end

  scenario "with invalid details" do
    visit project_ticket_path(project, ticket, as: user)

    click_button("Create Comment")

    expect(page).to have_content("Comment has not been created")
  end

  scenario "when chaning a tickets state" do
    FactoryGirl.create(:state, name: "Open")

    visit project_ticket_path(project, ticket, as: user)

    fill_in "Text", with: "This is a real issue"
    select "Open", from: "State"
    click_button "Create Comment"

    expect(page).to have_content("Comment has been created")

    within("#ticket .state") do
      expect(page).to have_content("Open")
    end

    within("#comments") do
      expect(page).to have_content("state changed to Open")
    end
  end

  scenario "but cannot change the state without permission" do
    assign_role!(user, :editor, project)
    visit project_ticket_path(project, ticket, as: user)

    expect(page).to_not have_select("State")
  end
end
