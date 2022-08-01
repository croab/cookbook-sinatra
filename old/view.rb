class View
  def collect_recipe_data
    puts "Please enter the name of the recipe..."
    name = gets.chomp
    puts "Please enter a description of the recipe..."
    description = gets.chomp
    puts "Please enter a rating for the recipe..."
    rating = gets.chomp
    puts "Please enter a prep time for the recipe..."
    prep_time = gets.chomp
    return [name, description, rating, prep_time]
  end

  def display(cookbook)
    cookbook.each_with_index do |recipe, index|
      puts "#{index + 1}. #{convert_bool_to_x(recipe.done)} #{recipe.name}. Recipe number #{index + 1}."
      puts "This is described as '#{recipe.description}"
      puts "It has been rated as #{recipe.rating}"
      prep_time(recipe)
    end
  end

  def ask_for_index
    puts "Please select a recipe number..."
    return gets.chomp.to_i - 1
  end

  def recipe_to_import
    puts "What ingredient would you like a recipe for?"
    gets.chomp
  end

  def display_from_web(top_five_recipes)
    puts "Please select from the following recipes..."
    top_five_recipes.each_with_index do |recipe, index|
      puts "#{index + 1}. #{recipe[0]}"
    end
    gets.chomp.to_i
  end

  private

  def convert_bool_to_x(doneness)
    if doneness == true
      return "[x]"
    else
      return "[ ]"
    end
  end

  def prep_time(recipe)
    if recipe.prep_time == "unknown"
      puts "The prep time is not available"
    else
      puts "The prep time will be #{recipe.prep_time}"
    end
  end
end
