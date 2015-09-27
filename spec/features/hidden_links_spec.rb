require "rails_helper"

RSpec.feature "only admins can view protected links" do
  let(:admin) { FactoryGirl.create(:user, :admin) }
  let(:user) { FactoryGirl.create(:user) }
  let(:project) { FactoryGirl.create(:project) }
  let(:ticket) { FactoryGirl.create(:ticket, project: project, author: user) }

  before do
    assign_role!(user, :viewer, project)
  end

  context "regular users" do
    scenario "cannot see the new project link" do
      visit root_path as: user

      expect(page).to_not have_link("New Project")
    end

    scenario "cannot see the delete project link" do
      visit project_path(project, as: user)

      expect(page).to_not have_link("Delete Project")
    end

    scenario "cannot see the create comment form" do
      visit project_ticket_path(project, ticket, as: user)

      expect(page).to_not have_heading("New Comment")
    end
  end

  context "non admin users (project viewers)" do
    scenario "cannot see the edit project link" do
      visit project_path(project, as: user)

      expect(page).to_not have_link("Edit Project")
    end

    scenario "cannot see the the new ticket link" do
      visit project_path(project, as: user)

      expect(page).to_not have_link("New Ticket")
    end

    scenario "cannot see the edit ticket link" do
      visit project_ticket_path(project, ticket, as: user)

      expect(page).to_not have_link("Edit Ticket")
    end

    scenario "cannot see the delete ticket link" do
      visit project_ticket_path(project, ticket, as: user)

      expect(page).to_not have_link("Delete Ticket")
    end
  end

  context "admin users" do
    scenario "can see the new project link" do
      visit root_path as: admin

      expect(page).to have_link("New Project")
    end

    scenario "can see the delete project link" do
      visit project_path(project, as: admin)

      expect(page).to have_link("Delete Project")
    end

    scenario "can see the edit project link" do
      visit project_path(project, as: admin)

      expect(page).to have_link("Edit Project")
    end

    scenario "can see the new ticket link" do
      visit project_path(project, as: admin)

      expect(page).to have_link("New Ticket")
    end

    scenario "can see the edit ticket link" do
      visit project_ticket_path(project, ticket, as: admin)

      expect(page).to have_link("Edit Ticket")
    end

    scenario "can see the delete ticket link" do
      visit project_ticket_path(project, ticket, as: admin)

      expect(page).to have_link("Delete Ticket")
    end

    scenario "can see the new comment form" do
      visit project_ticket_path(project, ticket, as: admin)

      expect(page).to have_heading("New Comment")
    end
  end
end
