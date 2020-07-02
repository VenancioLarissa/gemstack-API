describe "GET /dashboard" do
  before(:all) do
    result = SpotApi.new.session({ email: "kabum@papito.io" })
    @user_id = result.parsed_response["_id"]

    spots = [
      { thumbnail: "yahoo.jpg", company: "Yahoo", techs: ["java", "alixir"], price: 10, user: @user_id.to_mongo_id },
      { thumbnail: "kasolu.jpg", company: "Kasolu", techs: ["c", "alixir"], price: 20, user: @user_id.to_mongo_id },
      { thumbnail: "draculo.jpg", company: "Draculo", techs: ["javascript", "alixir"], price: 30, user: @user_id.to_mongo_id },
    ]

    MongoDb.new.save_spots(spots)
  end

  context "when get spot list" do
    before(:all) do
      @result = SpotApi.new.dash(@user_id)
    end

    it "should return 200" do
      expect(@result.response.code).to eql "200"
    end

    it "should return list" do
      expect(@result.parsed_response).not_to be_empty
    end
  end
end
