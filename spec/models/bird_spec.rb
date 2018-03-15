require 'rails_helper'
require 'spec_helper'
require 'pry'
describe fly do
  before :each do
    @fly = FactoryGirl.build(:fly)
  end



  after :each do
    # this test uses the db storage for uniqueness testing, so need to clean between runs
    DatabaseCleaner.clean
  end

  describe "#valid" do
    it "should require a name" do
      expect(@fly.valid?).to eq(true)
      @fly.name = nil
      expect(@fly.valid?).to eq(false)
    end

    it "should require a family" do
      expect(@fly.valid?).to eq(true)
      @fly.family = nil
      expect(@fly.valid?).to eq(false)
    end

    it "should require a continents" do
      expect(@fly.valid?).to eq(true)
      @fly.continents = nil
      expect(@fly.valid?).to eq(false)
    end

    it "should not validate if the  a continents are empty" do
      expect(@fly.valid?).to eq(true)
      @fly.continents = []
      expect(@fly.valid?).to eq(false)
    end

    it "should not validate if  duplicate value find in continents" do
      expect(@fly.valid?).to eq(true)
      @fly.continents << "Africa"
      expect(@fly.valid?).to eq(false)
    end

    it "should not validate if  the given continent has not exists" do
      expect(@fly.valid?).to eq(true)
      @fly.continents << "Apple"
      expect(@fly.valid?).to eq(false)
    end



  end


end
