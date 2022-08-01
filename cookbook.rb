require "pry-byebug"
require "csv"
require_relative "recipe"

class Cookbook
  attr_reader :recipes

  def initialize(csv_file_path)
    @csv = csv_file_path
    @recipes = parse_csv(csv_file_path)
  end

  def all
    return @recipes
  end

  def add_recipe(recipe)
    @recipes << recipe
    update_csv
  end

  def remove_recipe(recipe_index)
    @recipes.delete_at(recipe_index)
    update_csv
  end

  private

  def update_csv
    CSV.open(@csv, 'wb') do |csv|
      @recipes.each do |recipe|
        csv << [recipe.name, recipe.description, recipe.rating, recipe.prep_time, recipe.done]
      end
    end
  end

  def parse_csv(csv_file_path)
    csv_contents = []
    CSV.foreach(csv_file_path) do |row|
      csv_contents << Recipe.new(row[0], row[1], row[2], row[3], row[4])
    end
    return csv_contents
  end
end



# chocolate = Recipe.new("Chocolate", "This is a good dessert!")

# p chocolate
# p chocolate.to_s
# newone = Cookbook.new("lib/recipes.csv")
# p newone.recipes
# p newone.add_recipe(chocolate)
# p newone.recipes
# p newone.recipes
