require 'rails_helper'
RSpec.describe Character, type: :model do
  describe 'create a character' do 
    it "should validate name" do
      character = Character.create age: 999, enjoys: 'playing', image: 'https://www.google.com' 
      expect(character.errors[:name]).to_not be_empty
    end

    it "should validate age" do
      character = Character.create name: 'Monster Truck', enjoys: 'playing', image: 'https://www.google.com'  
      expect(character.errors[:age]).to_not be_empty
    end

    it "should validate enjoys" do
      character = Character.create name: 'Monster Truck', age: 999, image: 'https://www.google.com' 
      expect(character.errors[:enjoys]).to_not be_empty
    end

    it "should validate name" do
      character = Character.create name: 'Monster Truck', age: 999, enjoys: 'playing'
      expect(character.errors[:image]).to_not be_empty
    end

    it "wont create a character without enjoys being less than 10   characters long" do
      character = Character.create name: 'Monster Truck', age: 999, enjoys: 'play', image: 'https://www.google.com' 
      expect(character.errors[:enjoys]).to_not be_empty
    end
  end
end