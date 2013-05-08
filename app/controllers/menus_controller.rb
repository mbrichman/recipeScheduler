class MenusController < ApplicationController

  before_filter :authorize, only: [:edit, :update]

  def index
    @menus = Menu.where(:user_id => session[:user_id])
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
    @menu.user_id = session[:user_id]

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

  def add_recipe
    m = Recipe.find_by_id(params[:id])
    m.menu_id = params[:menu_id]
    m.save

    redirect_to menus_url
  end

  def cook
    @menu = Menu.find_by_id(params[:id])
    @temps = Array.new
  end

  def destroy
    @menu = Menu.find_by_id(params[:id])
    @menu.destroy
        redirect_to menus_url
      end
end
