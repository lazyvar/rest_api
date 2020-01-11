RSpec.describe RestApi do
  it "has a version number" do
    expect(RestApi::VERSION).not_to be nil
  end

  class Earthquake < RestApi::Base

    BASE_URL = 'https://earthquake.usgs.gov/fdsnws/event/1/'

    def catalogs
      get "catalogs"
    end

  end

end
