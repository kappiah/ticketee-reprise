require "rails_helper"

RSpec.describe CommentsController do
  let(:user) { FactoryGirl.create(:user) }
  let(:project) { Project.create!(name: "Ticketee!") }
  let(:state) { State.create!(name: "Hacked") }
  let(:ticket) do
    project.tickets.create(name: "State Transitions",
                           description: "Cannot be hacked",
                           author: user)
  end

  context "a user without permissions to change state" do
    before :each do
      assign_role!(user, :editor, project)
      sign_in_as(user)
    end

    it "cannot transition a state by passing though state_id" do
      post :create, { comment: { text: "Did I hack it?",
                                 state_id: state.id },
                      ticket_id: ticket.id }
      ticket.reload

      expect(ticket.state).to be_nil
    end
  end
end
