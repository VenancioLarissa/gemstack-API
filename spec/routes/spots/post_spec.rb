describe "POST /spots" do
  before(:all) do
    # instancia anonima
    result = SpotApi.new.session({ email: "fer@qaninja.io" })
    @user_id = result.parsed_response["_id"]
  end

  context "when save spot" do
    before(:all) do
      thumbnail = File.open(File.join(Dir.pwd, "spec/imagens", "google.jpg"))
      puts thumbnail
      puts thumbnail.class

      payload = {
        thumbnail: thumbnail,
        company: "Google",
        techs: "Java, golang, node",
        price: "10",
      }

      MongoDb.new.remove_company(payload[:company], @user_id)

      @result = SpotApi.new.save_spot(payload, @user_id)
    end

    it "should return 200" do
      expect(@result.response.code).to eql "200"
    end
  end

  context "when empty company" do
    before(:all) do
      thumbnail = File.open(File.join(Dir.pwd, "spec/imagens", "google.jpg"))

      payload = {
        thumbnail: thumbnail,
        company: "",
        techs: "Java, golang, node",
        price: "10",
      }
      @result = SpotApi.new.save_spot(payload, @user_id)
    end

    it "should return 412" do
      expect(@result.response.code).to eql "412"
    end

    it "should return code 1001" do
      expect(@result.parsed_response["code"]).to eql 1001
    end

    it "return required company" do
      expect(@result.parsed_response["error"]).to eql "Company is required"
    end
  end

  context "when empty techs" do
    before(:all) do
      thumbnail = File.open(File.join(Dir.pwd, "spec/imagens", "google.jpg"))

      payload = { thumbnail: thumbnail, company: "Venancio", techs: "", price: "10" }

      @result = SpotApi.new.save_spot(payload, @user_id)
    end

    it "should return 412" do
      expect(@result.response.code).to eql "412"
    end

    it "should return code 1002" do
      expect(@result.parsed_response["code"]).to eql 1002
    end

    it "return required company" do
      expect(@result.parsed_response["error"]).to eql "Technologies is required"
    end
  end

  context "when empty thumbnail" do
    before(:all) do
      thumbnail = File.open(File.join(Dir.pwd, "spec/imagens", "google.jpg"))

      payload = { thumbnail: "", company: "Venancio", techs: "java, node", price: "10" }

      @result = SpotApi.new.save_spot(payload, @user_id)
    end

    it "should return 412" do
      expect(@result.response.code).to eql "412"
    end

    it "return required company" do
      expect(@result.parsed_response["error"]).to eql "Incorrect Spot data :("
    end
  end
end
