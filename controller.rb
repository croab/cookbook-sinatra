require_relative "recipe"
require_relative "view"
require_relative "scrape_all_recipes_service"
require "nokogiri"
require "open-uri"

class Controller
  def initialize(cookbook)
    @cookbook = cookbook
    @view = View.new
  end

  def list
    recipes = @cookbook.all
    @view.display(recipes)
  end

  def create
    user_data = @view.collect_recipe_data
    name = user_data[0]
    description = user_data[1]
    rating = user_data[2]
    prep_time = user_data[3]
    new_recipe = Recipe.new(name, description, rating, prep_time)
    @cookbook.add_recipe(new_recipe)
  end

  def destroy
    list
    index_to_delete = @view.ask_for_index
    @cookbook.remove_recipe(index_to_delete)
  end

  def mark_as_done
    index = @view.ask_for_index
    @cookbook.recipes[index].mark_as_done!
    list
  end

  def import
    internet_recipes = ScrapeAllrecipesService.new(@view.recipe_to_import).call
    selected_index = @view.display_from_web(internet_recipes)
    selected_recipe = internet_recipes[selected_index - 1]
    new_recipe = Recipe.new(selected_recipe[0], selected_recipe[1], selected_recipe[2], selected_recipe[3])
    @cookbook.add_recipe(new_recipe)
    list
  end
end
