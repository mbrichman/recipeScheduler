class MenurecipejoinsController < ApplicationController

  def index

  end

  def show

  end

  def edit

  end

  def update

  end

  def create
    mrj = Menurecipejoin.new
    mrj.menu_id = params[:menu_id]
    mrj.recipe_id = params[:recipe_id]
    mrj.save

    redirect_to menu_url(params[:menu_id])

  end

  def update

  end

  def destroy

  end


end
