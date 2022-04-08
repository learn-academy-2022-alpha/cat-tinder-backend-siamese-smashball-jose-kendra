class CharactersController < ApplicationController
    def index
        characters = Character.all
        render json: characters
    end

    def create
        character = Character.create(strong_character_params)
        if character.valid?
        render json: character
        else 
        render json: character.errors
        end
    end

    def update
        character = Character.find(params[:id])
        character.update(strong_character_params)
        if character.valid?
            render json: character
        else 
            render json: character.errors
        end
    end

    def destroy
        character = Character.find(params[:id])
   		if 
            character.destroy
   		    render json: character
   		else 
   		    render json: character.errors
        end
    end

    private
    def strong_character_params 
        params.require(:character).permit(:name, :age, :enjoys, :image)
    end
end
