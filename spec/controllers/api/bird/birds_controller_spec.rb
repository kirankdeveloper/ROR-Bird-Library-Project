require 'rails_helper'
require 'spec_helper'
require 'http_codes'

module Api
  module fly
    include HttpCodes
    describe flysController  do

      JSON_CONTENT = "application/json; charset=utf-8"
      describe "defaults" do
              before :each do
                get "flys_list"
              end
                it "should return a success response code" do
                  expect(response.status).to eq(OK)
                end
                it "should return the proper content type" do
                  expect(response.headers["Content-Type"]).to eq(JSON_CONTENT)
                end

                it "should not be null" do
                  expect(ActiveSupport::JSON.decode(response.body)).not_to eq(nil)
                end



      end

      describe "POST /" do
        it "should return a Bad request  response code when we are not sending the continent" do
          fly = FactoryGirl.build(:fly_obj)
          fly.extend(flyRepresenter)
          post "add_fly", fly.to_hash
          expect(response.status).to eq(BAD_REQUEST)
        end

        it "should return Success   response code" do
          fly = FactoryGirl.build(:fly)
          fly.extend(flyRepresenter)
          post "add_fly", fly.to_hash
          expect(response.status).to eq(CREATED)
        end

        it "should return Failure code when user has given the wrong continents" do
          fly = FactoryGirl.build(:invalid_fly_array)
          fly.extend(flyRepresenter)
          post "add_fly", fly.to_hash
          expect(response.status).to eq(BAD_REQUEST)
        end

        it "should return Failure code when user has given the wrong continents" do
          fly = FactoryGirl.build(:invalid_fly_array)
          fly.extend(flyRepresenter)
          post "add_fly", fly.to_hash
          expect(response.status).to eq(BAD_REQUEST)
        end

        it "should return Failure code when invalid continents" do
          fly = FactoryGirl.build(:in_valid_continents)
          fly.extend(flyRepresenter)
          post "add_fly", fly.to_hash
          expect(response.status).to eq(BAD_REQUEST)
        end

        it "should  accept when multiple continents given" do
          fly = FactoryGirl.build(:valid_continents)
          fly.extend(flyRepresenter)
          post "add_fly", fly.to_hash
          expect(response.status).to eq(CREATED)
        end

        it "should return the proper content type" do
          fly = FactoryGirl.build(:valid_continents)
          fly.extend(flyRepresenter)
          post "add_fly", fly.to_hash
          expect(response.headers["Content-Type"]).to eq(JSON_CONTENT)
          #response.headers["Content-Type"].should eq(JSON_CONTENT)
        end
        it "should return a valid  fly name " do
          fly = FactoryGirl.build(:valid_continents)
          fly.extend(flyRepresenter)
          post "add_fly", fly.to_hash
          fly_obj = JSON.parse(response.body)
          expect(fly_obj[0]['id']).not_to eq(nil)
          expect(fly_obj[0]['name']).to eq('Duck')
          expect(fly_obj[0]['continents']).to eq(["Africa","Antarctica"])
          expect(response.status).to eq(CREATED)
        end
      end



      describe "GET /:id" do
        before :each do
          @fly = FactoryGirl.build(:fly)
          @fly.extend(flyRepresenter).save!
          @fly.save!
        end
        it "should return a success response code" do
          get(:display_fly, id: @fly.id)
          expect(response.status).to eq(OK)
        end
        it "should return the proper content type" do
          get(:display_fly, id: @fly.id)
          expect(response.headers["Content-Type"]).to eq(JSON_CONTENT)
        end
        it "should return a valid response body" do
          get(:display_fly, id: @fly.id)
          obj = JSON.parse(response.body)
          validate_fly_response_content(obj,@fly)
        end

        it "should return a not found response code" do
          get(:display_fly, id: '12323123123213')
          expect(response.status).to eq(NOT_FOUND)
        end

      end

      describe "DELETE /:id" do
        before :each do
          @fly = FactoryGirl.build(:fly)
          @fly.extend(flyRepresenter)
          @fly.save!
        end

        it "should return a success response code" do
          delete(:remove_fly, id: @fly.id)
          expect(response.status).to eq(OK)
        end

        it "should return a not found  response code" do
          delete(:remove_fly, id: '12345678')
          expect(response.status).to eq(NOT_FOUND)
        end
      end

      def validate_fly_response_content(response, fly)
        expect(response[0]['name']).to eq(fly.name)
        expect(response[0]['family']).to eq(fly.family)
        expect(response[0]['id']).to eq(fly.id.to_s)
        expect(response[0]['visible']).to eq(fly.visible)
        expect(response[0]['continents']).to eq(fly.continents)
        expect(response[0]['added']).to eq(fly.added)
      end
    end
  end
end






