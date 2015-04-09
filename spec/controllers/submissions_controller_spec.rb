RSpec.describe SubmissionsController do
  describe "GET index" do
    it "shows no submissions" do
      get :index
      expect(assigns(:submissions)).to eq([])
    end

    it "shows new submissions" do 
      submission = create(:submission)
      get :index
      expect(assigns(:submissions)).to eq([submission])
    end
  end

  describe "GET show" do
    it "should render show template" do
      submission = create(:submission)
      get :show, id: submission.id
      expect(response).to render_template("show")
    end
  end

  describe "POST like" do
    it "should return unauthenticated" do
      submission = create(:submission)
      post :like, submission_id: submission.id
      expect(JSON.parse(response.body)['status']).to eq("not authenticated")
    end

    it "should disallow own content rating" do
      user = create(:user)
      sign_in user
      submission = create(:submission, creator: user)
      post :like, submission_id: submission.id
      expect(JSON.parse(response.body)['status']).to eq("can not rate own content")
    end

    it "should return a liked status" do
      Like.delete_all
      user = create(:user)
      sign_in user
      submission = create(:submission)
      post :like, submission_id: submission.id, format: :json
      expect(JSON.parse(response.body)['status']).to eq("liked submission")
    end
end
