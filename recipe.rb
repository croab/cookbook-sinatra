class Recipe
  attr_reader :name, :description, :rating, :done, :prep_time

  def initialize(name, description, rating, prep_time, done = false)
    @name = name
    @description = description
    @rating = rating
    @done = done
    @prep_time = prep_time
  end

  def mark_as_done!
    @done = true
  end
end
