require "rails_helper"


RSpec.describe IdeasController, type: :controller do
  def current_user
    @current_user ||= FactoryBot.create(:user)
  end 
  describe "#new" do
      context "without a signed in user" do
          it "it should redirect to the sign in page" do
            get :new
            expect(response).to redirect_to(new_session_path)
          end
      end
      context "with a user signed in" do
          before do
            session[:user_id] = current_user.id
          end

          it "render the new post form" do 
            get :new
            expect(response).to render_template(:new)
          end

          it "sets an instance variable with a new post" do
            get(:new)
            expect(assigns(:idea)).to(be_a_new(Idea))
          end
      end
  end

  describe "#create" do
    def valid_request
      post(:create, params: { idea: FactoryBot.attributes_for(:idea) })
    end

    context "with user not signed in" do
      it "should redirect to the sign in page" do
        valid_request
        expect(response).to redirect_to(new_session_path)
      end
    end
    context "with user signed in" do
      before do
        session[:user_id] = current_user.id
      end

        context "with valid parameters" do
          it "creates a idea in the database" do
            # GIVEN
            count_before = Idea.count
            # WHEN
            valid_request
            # THEN
            count_after = Idea.count
            expect(count_after).to eq(count_before + 1)
          end
          it "redirects us to the show page for that idea" do
            # WHEN
            valid_request
            # THEN
            idea = Idea.last
            expect(response).to(redirect_to(idea_url(idea.id)))
          
          end
        end
        context "with invalid parameters" do
          def invalid_request
            post(:create, params: { idea: FactoryBot.attributes_for(:idea, title: nil) })
          end
          it "does not save a record in the database" do
            count_before = Idea.count
            invalid_request
            count_after = Idea.count
            expect(count_after).to eq(count_before)
          end
          it "renders the new template" do
            invalid_request
            expect(response).to render_template(:new)
          end
        end

    end
end







end