require "rails_helper"

RSpec.feature "Users can view tickets" do
  let(:user) { FactoryGirl.create(:user) }

  before do
    sublime = FactoryGirl.create(:project, name: "Sublime Text 3")
    FactoryGirl.create(:ticket, project: sublime,
                       name: "Make it shiny!",
                       description: "Gradients! Starbursts! Oh My!",
                       author: user)

    ie = FactoryGirl.create(:project, name: "Internet Explorer")
    FactoryGirl.create(:ticket, project: ie,
                       name: "Standards Compliance",
                       description: "Isn't a joke",
                       author: user)

    assign_role!(user, :viewer, sublime)
    visit root_path as: user
  end

  scenario "for a given project" do
    click_link "Sublime Text 3"

    expect(page).to have_content("Make it shiny!")
    expect(page).not_to have_content("Standards Compliance")

    click_link("Make it shiny!")

    within("#ticket h2") do
      expect(page).to have_content("Make it shiny!")
    end

    expect(page).to have_content("Gradients! Starbursts! Oh My!")
  end
end
