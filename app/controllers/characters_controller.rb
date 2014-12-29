class CharactersController < ApplicationController

  def index
    @characters = Character.where("television_show_id=?",params[:id])
  end

  def create
    @character = Character.new(character_params)

    if @character.save
      flash[:notice] = "Character Successfully added"

      redirect_to "/television_shows/#{params[:television_show_id]}"

    else
      flash.now[:notice] = "Your character couldn't be saved."
    end
  end

  private

  def character_params
  params.require(:character).permit(:name, :actor, :description, :television_show_id)
  end

end
