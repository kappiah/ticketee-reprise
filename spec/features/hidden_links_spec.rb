require "rails_helper"

RSpec.feature "only admins can view protected links" do
  let(:admin) { FactoryGirl.create(:user, :admin) }
  let(:user) { FactoryGirl.create(:user) }
  let(:project) { FactoryGirl.create(:project) }

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
  end

  context "non admin users (project viewers)" do
    scenario "cannot see the edit project link" do
      visit project_path(project, as: user)

      expect(page).to_not have_link("Edit Project")
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
  end
end
