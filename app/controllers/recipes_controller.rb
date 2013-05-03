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

  def show
    app_id = '0b8b841f'
    app_key = 'b766cf986e0ebf2cc801af09229e7d50'
    access_key = "?_app_id=#{app_id}&_app_key=#{app_key}"
    url = "http://api.yummly.com/v1/api/recipe/#{params[:id]+access_key}&requirePictures=true"
    response = open(url).read
    @recipe = JSON.parse(response)
  end

  def add_recipe
    redirect_to '/recipes'
  end

  def parse
    url = params[:url]
    doc = Nokogiri::HTML(open(url))
    @ingredients = doc.css('ul.kv-ingred-list1 > li')
    @directions = doc.css('div.fn_instructions > p')
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

end
