class RecipeboxesController < ApplicationController
  def show
    @recipes = Recipe.where()
  end
end
