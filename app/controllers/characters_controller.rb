class CharactersController < ApplicationController


  def index
    @characters = Character.where("television_show_id=?",params[:television_show_id])
  end

  def show
    @characters = Character.where("television_show_id=?",params[:television_show_id])
  end

  def new
    @character = Character.new

  end

  def create
    @character = Character.new(character_params)
    if @character.save

      flash[:notice] = "Character Successfully added"
      redirect_to "/television_shows/#{@character.television_show_id}/characters"
    else
      flash.now[:notice] = "Your character couldn't be saved."
      render :new
    end
  end

  def edit
    @character = Character.find(params[:id])

  end

  def update
    @character = Character.find(params[:id])
    # @television_show = TelevisionShow.find(@character.television_show_id)
    if @character.update (character_params)
      flash.now[:notice] = "Item updated successfully"
      redirect_to "/television_shows/#{@character.television_show_id}"
    else
      render :edit
    end

  end


  def destroy
    @character = Character.find(params[:id])
    if @character.destroy
      redirect_to television_shows_path, notice: "Character was deleted"
    end
  end

  private

  def character_params
  params.require(:character).permit(:name, :actor, :description, :television_show_id)
  end

end
