shared_examples "login is required" do
  context "when a user is not logged in" do
    before do
      expect(subject.current_user).to be_nil
    end

    it "redirects to the login page" do
      do_request
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end

shared_examples "resource ownership is required" do
  context "for a resource that is not owned by the user" do
    before do
      expect(resource_owner_id).to_not eq(user.id)
    end

    it "is not successful" do
      sign_in(user)
      expect { do_request }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end

shared_examples "a protected index action" do
  context "when a user is not signed in" do
    before do
      expect(subject.current_user).to be_nil
      get :index
    end

    it "redirects to the login page" do
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  context "when a user is signed in" do
    before do
      sign_in(user)
      get :index
    end

    it "is successful" do
      expect(response).to have_http_status(:success)
    end
  end
end

shared_examples "a protected show action" do
  def do_request(object)
    get :show, params: { id: object.id }
  end

  context "when a user is not signed in" do
    before do
      expect(subject.current_user).to be_nil
      do_request(object_owned_by_user)
    end

    it "redirects to the login page" do
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  context "when a user is signed in" do
    before do
      sign_in(user)
    end

    context "for an object not owned by the user" do
      it "is not successful" do
        expect { do_request(object_not_owned_by_user) }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context "for a object owned by the user" do
      before do
        do_request(object_owned_by_user)
      end

      it "is successful" do
        expect(response).to have_http_status(:success)
      end
    end
  end
end

shared_examples "a protected new action" do |options = {}|
  context "when a user is not signed in" do
    before do
      expect(subject.current_user).to be_nil
      get :new, params: owner_request_params
    end

    it "redirects to the login page" do
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  context "when a user is signed in" do
    before do
      sign_in(user)
    end

    context "for an object not owned by the user", if: !options[:skip_ownership_check] do
      def do_request
        get :new, params: non_owner_request_params
      end

      it "is not successful" do
        expect { do_request }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context "for an object owned by the user", if: !options[:skip_ownership_check] do
      before do
        get :new, params: owner_request_params
      end

      it "is successful" do
        expect(response).to have_http_status(:success)
      end
    end

    it "is successful", if: options[:skip_ownership_check] do
      get :new, params: owner_request_params
      expect(response).to have_http_status(:success)
    end
  end
end

shared_examples "a protected create action" do |options = {}|
  context "when a user is not signed in" do
    before do
      expect(subject.current_user).to be_nil
      post :create, params: valid_owner_request_params
    end

    it "redirects to the login page" do
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  context "when a user is signed in" do
    before do
      sign_in(user)
    end

    context "for an object not owned by the user", if: !options[:skip_ownership_check] do
      def do_request
        post :create, params: valid_non_owner_request_params
      end

      it "is not successful" do
        expect { do_request }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context "for an object owned by the user" do
      let!(:initial_count) { model.count }

      context "for invalid params" do
        before do
          post :create, params: invalid_owner_request_params
        end

        it "is successful" do
          expect(response).to have_http_status(:success)
        end

        it "does not create the model" do
          expect(model.count).to eq(initial_count)
        end
      end

      context "for valid params" do
        before do
          post :create, params: valid_owner_request_params
        end

        it "redirects to the correct url" do
          expect(response).to redirect_to(after_create_redirect_url)
        end

        it "creates the model" do
          expect(model.count).to eq(initial_count + 1)
        end
      end
    end
  end
end
