require "rails_helper"

RSpec.feature "admins can manage states" do
  let!(:state) { FactoryGirl.create(:state, name: "Created") }
  let(:admin) { FactoryGirl.create(:user, :admin) }

  before do
    visit admin_states_path as: admin
  end

  scenario "marking as default state" do
    within list_item("Created") do
      click_link "Make Default"
    end

    expect(page).to have_content("'Created' is the new default state")
  end
end
