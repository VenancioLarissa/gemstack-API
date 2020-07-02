require "httparty"

describe ("POST / sessions") do
  context "when send my email", :smoke do
    before(:all) do
      @result = SpotApi.new.session({ email: "fernando@qaninja.io" })
    end

    it "should return 200" do
      expect(@result.response.code).to eql "200"
    end

    it "should return session id" do
      expect(@result.parsed_response["_id"].length).to eql 24
    end
  end

  context "when send a wrong email" do
    before(:all) do
      api = SpotApi.new
      @result = api.session({ email: "fernado@acme.io" })
    end

    it "should return 200" do
      expect(@result.response.code).to eql "200"
    end
  end

  context "when send a empty email" do
    before(:all) do
      api = SpotApi.new
      @result = api.session({ email: "" })
    end

    it "should return 412" do
      expect(@result.response.code).to eql "412"
    end
  end

  context "when send without data" do
    before(:all) do
      api = SpotApi.new
      @result = api.session({})
    end

    it "should return 412" do
      expect(@result.response.code).to eql "412"
    end
  end
end
