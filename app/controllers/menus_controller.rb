class MenusController < ApplicationController

  def index
    @menus = Menu.all
  end

  def show
    @menu = Menu.find_by_id(params[:id])
  end

  def new
    @menu = Menu.new
  end

  def create
    @menu = Menu.new
    @menu.name = params[:name]
    @menu.menu_date = params[:menu_date]
    
    if @menu.save
            redirect_to menus_url
          else
      render 'new'
    end
  end

  def edit
    @menu = Menu.find_by_id(params[:id])
  end

  def update
    @menu = Menu.find_by_id(params[:id])
    @menu.name = params[:name]
    @menu.menu_date = params[:menu_date]
    
    if @menu.save
            redirect_to menus_url
          else
      render 'edit'
    end
  end

  def destroy
    @menu = Menu.find_by_id(params[:id])
    @menu.destroy
        redirect_to menus_url
      end
end
