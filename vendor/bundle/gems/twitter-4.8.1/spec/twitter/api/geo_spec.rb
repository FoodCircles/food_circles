require 'helper'

describe Twitter::API::PlacesAndGeo do

  before do
    @client = Twitter::Client.new
  end

  describe "#place" do
    before do
      stub_get("/1.1/geo/id/247f43d441defc03.json").to_return(:body => fixture("place.json"), :headers => {:content_type => "application/json; charset=utf-8"})
    end
    it "requests the correct resource" do
      @client.place("247f43d441defc03")
      expect(a_get("/1.1/geo/id/247f43d441defc03.json")).to have_been_made
    end
    it "returns a place" do
      place = @client.place("247f43d441defc03")
      expect(place.name).to eq "Twitter HQ"
    end
  end

  describe "#reverse_geocode" do
    before do
      stub_get("/1.1/geo/reverse_geocode.json").with(:query => {:lat => "37.7821120598956", :long => "-122.400612831116"}).to_return(:body => fixture("places.json"), :headers => {:content_type => "application/json; charset=utf-8"})
    end
    it "requests the correct resource" do
      @client.reverse_geocode(:lat => "37.7821120598956", :long => "-122.400612831116")
      expect(a_get("/1.1/geo/reverse_geocode.json").with(:query => {:lat => "37.7821120598956", :long => "-122.400612831116"})).to have_been_made
    end
    it "returns places" do
      places = @client.reverse_geocode(:lat => "37.7821120598956", :long => "-122.400612831116")
      expect(places).to be_an Array
      expect(places.first.name).to eq "Bernal Heights"
    end
  end

  describe "#geo_search" do
    before do
      stub_get("/1.1/geo/search.json").with(:query => {:ip => "74.125.19.104"}).to_return(:body => fixture("places.json"), :headers => {:content_type => "application/json; charset=utf-8"})
    end
    it "requests the correct resource" do
      @client.geo_search(:ip => "74.125.19.104")
      expect(a_get("/1.1/geo/search.json").with(:query => {:ip => "74.125.19.104"})).to have_been_made
    end
    it "returns nearby places" do
      places = @client.geo_search(:ip => "74.125.19.104")
      expect(places).to be_an Array
      expect(places.first.name).to eq "Bernal Heights"
    end
  end

  describe "#similar_places" do
    before do
      stub_get("/1.1/geo/similar_places.json").with(:query => {:lat => "37.7821120598956", :long => "-122.400612831116", :name => "Twitter HQ"}).to_return(:body => fixture("places.json"), :headers => {:content_type => "application/json; charset=utf-8"})
    end
    it "requests the correct resource" do
      @client.similar_places(:lat => "37.7821120598956", :long => "-122.400612831116", :name => "Twitter HQ")
      expect(a_get("/1.1/geo/similar_places.json").with(:query => {:lat => "37.7821120598956", :long => "-122.400612831116", :name => "Twitter HQ"})).to have_been_made
    end
    it "returns similar places" do
      places = @client.similar_places(:lat => "37.7821120598956", :long => "-122.400612831116", :name => "Twitter HQ")
      expect(places).to be_an Array
      expect(places.first.name).to eq "Bernal Heights"
    end
  end

  describe "#place_create" do
    before do
      stub_post("/1.1/geo/place.json").with(:body => {:name => "@sferik's Apartment", :token => "22ff5b1f7159032cf69218c4d8bb78bc", :contained_within => "41bcb736f84a799e", :lat => "37.783699", :long => "-122.393581"}).to_return(:body => fixture("place.json"), :headers => {:content_type => "application/json; charset=utf-8"})
    end
    it "requests the correct resource" do
      @client.place_create(:name => "@sferik's Apartment", :token => "22ff5b1f7159032cf69218c4d8bb78bc", :contained_within => "41bcb736f84a799e", :lat => "37.783699", :long => "-122.393581")
      expect(a_post("/1.1/geo/place.json").with(:body => {:name => "@sferik's Apartment", :token => "22ff5b1f7159032cf69218c4d8bb78bc", :contained_within => "41bcb736f84a799e", :lat => "37.783699", :long => "-122.393581"})).to have_been_made
    end
    it "returns a place" do
      place = @client.place_create(:name => "@sferik's Apartment", :token => "22ff5b1f7159032cf69218c4d8bb78bc", :contained_within => "41bcb736f84a799e", :lat => "37.783699", :long => "-122.393581")
      expect(place.name).to eq "Twitter HQ"
    end
  end

end
