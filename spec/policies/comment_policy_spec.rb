require 'rails_helper'

describe CommentPolicy do
  context "permissions" do
    subject { CommentPolicy.new(user, comment) }
    let(:user) { FactoryGirl.create(:user) }
    let(:project) { FactoryGirl.create(:project) }
    let(:ticket) { FactoryGirl.create(:ticket, project: project, author: user) }
    let(:comment) { FactoryGirl.create(:comment, ticket: ticket) }

    context "for anonymous users" do
      let(:user) { nil }
      it { should_not permit_action :create }
    end

    context "for viewers of the project" do
      before { assign_role!(user, :viewer, project) }
      it { should_not permit_action :create }
      it { should_not permit_action :change_state }
    end

    context "for editors of the project" do
      before { assign_role!(user, :editor, project) }
      it { should permit_action :create }
      it { should_not permit_action :change_state }
    end

    context "for managers of the project" do
      before { assign_role!(user, :manager, project) }
      it { should permit_action :create }
      it { should permit_action :change_state }
    end

    context "for managers of other projects" do
      before do
        assign_role!(user, :manager, FactoryGirl.create(:project))
      end

      it { should_not permit_action :create }
      it { should_not permit_action :change_state }
    end

    context "for admins" do
      let(:user) { FactoryGirl.create(:user, :admin) }
      it { should permit_action :create }
      it { should permit_action :change_state }
    end
  end
end
