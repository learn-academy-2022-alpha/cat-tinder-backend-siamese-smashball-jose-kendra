require 'rails_helper'

RSpec.describe "Characters", type: :request do
  describe "GET /index" do
    it"gets a list characters" do
      Character.create(
        name: 'Jose',
        age: '5',
        enjoys: 'running',
        image: 'http://d279m997dpfwgl.cloudfront.net/wp/2017/11/jose-running-1000x800.jpg'
      )
      get '/characters'

      character = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(character.length).to eq 1
    end
  end

  describe "POST /create" do
    it"creates a custom character" do
      character_params = {
        character: {
        name: 'Jose',
        age: '5',
        enjoys: 'running',
        image: 'http://d279m997dpfwgl.cloudfront.net/wp/2017/11/jose-running-1000x800.jpg'
        }
      }
      post '/characters', params: character_params

      expect(response).to have_http_status(200)

      character = Character.first
      expect(character.name). to eq 'Jose'
    end
  end

  describe "PATCH /update" do
    it"edits an existing character" do
      Character.create name:'Jose', age: 5, enjoys: 'running', image: 'http://d279m997dpfwgl.cloudfront.net/wp/2017/11/jose-running-1000x800.jpg'

      update_example = Character.first

      character_params = {
        character: {
          name: 'Kendra',
          age: 5,
          enjoys: 'running',
          image: 'http://d279m997dpfwgl.cloudfront.net/wp/2017/11/jose-running-1000x800.jpg'
        }
      }

      patch "/characters/#{update_example.id}", params: character_params
      character_mystery = Character.find(update_example.id)
      expect(response).to have_http_status(200)
      expect(character_mystery.name).to eq 'Kendra'
    end
  end

  # describe 'DELETE/destroy' do	
	#   it 'deletes a character from the DB' do
	#     Character.create name:'Jose', age: 5, enjoys: 'running', image: 'http://d279m997dpfwgl.cloudfront.net/wp/2017/11/jose-running-1000x800.jpg'
	
	#     new_char = Character.first

	#     delete “/characters/#{new_char.id}”
	#     expect(response).to have_http_status(200)

	#     characters = Character.all
	#     expect(characters).to be_empty
  #   end
  # end


  describe "DELETE /destroy" do
    it "deletes a character" do
      Character.create(
        name: 'Kendra',
          age: 5,
          enjoys: 'running',
          image: 'http://d279m997dpfwgl.cloudfront.net/wp/2017/11/jose-running-1000x800.jpg'
      )
      char_kendra = Character.first
      delete "/characters/#{char_kendra.id}"
      expect(response).to have_http_status(200)
      char = Character.all
      expect(char).to be_empty
    end
  end
end