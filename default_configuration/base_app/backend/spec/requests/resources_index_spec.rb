require 'spec_helper'


# example JSON output from request
# {"links"=>{
#    lists of route names and their uri templates
#    (e.g "page" => "/pages/{url_slug}")
#   },
#  "data"=>
#   {}

describe "resources#index", :type => :request do

  describe "GET /resources" do
    it "shows route templates asjson" do
      json_get "/resources"

      expect(response).to be_success
      expect(parse_json(response.body,"links/validate_token")).to eq("/users/validate_token")
    end
  end
end
