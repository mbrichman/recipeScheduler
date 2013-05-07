require 'open-uri'
require 'json'
require 'nokogiri'

class RecipesController < ApplicationController

  def home
    @recipes = Recipe.all
  end

  def index
    app_id = '0b8b841f'
    app_key = 'b766cf986e0ebf2cc801af09229e7d50'
    access_key = "?_app_id=#{app_id}&_app_key=#{app_key}"

    url = "http://api.yummly.com/v1/api/recipes#{access_key}&q=#{params[:ingredient]}&requirePictures=true"
    puts url

    response = open(url).read
    q = JSON.parse(response)
    @recipes = Array.new

    q['matches'].each do |r|
      r_hash = {}
      r_hash[:attributes] = r['attributes']
      r_hash[:url] = r['smallImageUrls'][0]
      r_hash[:id] = r['id']
      r_hash[:name] = r['recipeName']
      r_hash[:source] = r['sourceDisplayName']
      @recipes << r_hash
    end
  end

  def edit
    @recipe = Recipe.find_by_id(params[:id])
  end

  def update
    m = Recipe.find_by_id(params[:id])
    m.menu_id = params[:menu_id]
    m.save

    redirect_to recipe_url(params[:id])
  end

  def show
    @recipe = Recipe.find_by_id(params[:id])
  end

  def show_yummly
    app_id = '0b8b841f'
    app_key = 'b766cf986e0ebf2cc801af09229e7d50'
    access_key = "?_app_id=#{app_id}&_app_key=#{app_key}"
    url = "http://api.yummly.com/v1/api/recipe/#{params[:id]+access_key}&requirePictures=true"
    response = open(url).read
    @recipe = JSON.parse(response)
  end

  def add_recipe
    url = params[:id]
    doc = Nokogiri::HTML(open(url))
    ingredients_temp = doc.css('ul.kv-ingred-list1 > li')
    directions_temp = doc.css('div.fn_instructions > p')
    @ingredients = ingredients_temp.collect { |ing| ing.text.strip }.select {|i| i != ""}
    @directions = directions_temp.collect { |dir| dir.text.strip }.select {|i| i != ""}
    r = Recipe.new
    r.name = doc.css('h1.fn_name').text
    if doc.css('a#recipe-image').count != 0
      r.image_url = doc.css('a#recipe-image').first[:href]
    else
      r.image_url = 'No Image'
    end
    r.source = URI.parse(url).hostname
    r.source_url = url
    r.save
    @ingredients.each do |i|
      step = Ingredient.new
      step.ingredient = i
      step.step_type = 'I'
      step.recipe_id = r.id
      step.save
    end
    @temps = []
    @directions.each_with_index do |d, i|
      d.scan(/\d{3}+(?=\sdegrees)/).collect {|t| @temps << [i,t]}
      # if /\d* degrees/.match(d.ingredient)
      #   x = /\d* degrees/.match(d.ingredient)
      #   @temps << /\d{3}/.match(x[0])
      # end
      step = Ingredient.new
      step.ingredient = d
      step.step_type = 'D'
      step.recipe_id = r.id
      step.save
    end
    r.key_temps = Hash[*@temps.flatten].to_s
    r.save

    redirect_to 'http://localhost:3000/'
  end

  def parse
    url = params[:url]
    doc = Nokogiri::HTML(open(url))
    ingredients_temp = doc.css('ul.kv-ingred-list1 > li')
    directions_temp = doc.css('div.fn_instructions > p')
    @ingredients = ingredients_temp.collect { |ing| ing.text.strip }.select {|i| i != ""}
    @directions = directions_temp.collect { |dir| dir.text.strip }.select {|i| i != ""}
    @temps = []
    @directions.each_with_index do |d, i|
      d.scan(/\d{3}+(?=\sdegrees)/).collect {|t| @temps << [t, i]}
      #old regex that did not get each temp in the instruction
      # if /\d* degrees/.match(d)
      #   x = /\d* degrees/.match(d)
      #   @temps << /\d{3}/.match(x[0])[0]
      # end
    end
  end

  def create
    app_id = '0b8b841f'
    app_key = 'b766cf986e0ebf2cc801af09229e7d50'
    access_key = "?_app_id=#{app_id}&_app_key=#{app_key}"
    url = "http://api.yummly.com/v1/api/recipe/#{params[:id]+access_key}&requirePictures=true"
    response = open(url).read
    @recipe = JSON.parse(response)
    r = Recipe.new
    r.name = @recipe['name']
    r.source = @recipe['source']['sourceDisplayName']
    # r.source_url = ['source']['sourceRecipeUrl']
    r.image_url = @recipe['images'][0]['hostedLargeUrl']
    r.save
    @recipe['ingredientLines'].each do |i|
      ingr = Ingredient.new
      ingr.ingredient = i
      ingr.recipe_id = r.id
      ingr.save
    end
    redirect_to root_path
  end

  def destroy
    @recipe = Recipe.find_by_id(params[:id])
    @recipe.destroy

    redirect_to root_url
  end

end
