require "nokogiri"
require "open-uri"

BASE_URL = "https://www.allrecipes.com/search/results/?search="

class ScrapeAllrecipesService
  def initialize(keyword)
    @keyword = keyword
  end

  def call
    # TODO: return a list of `Recipe` built from scraping the web.
    search_url_full = BASE_URL + @keyword
    doc = Nokogiri::HTML(URI.open(search_url_full).read, nil, "utf-8")
    internet_recipes = []
    doc.search(".card__detailsContainer").first(5).each do |container|
      name = container.search(".card__title").text.strip
      summary = container.search(".card__summary").text.strip
      rating = container.search(".review-star-text").text.strip.match(/\d(\.\d)?/)[0].to_f
      prep_time = prep_time_logic(container)
      internet_recipes << [name, summary, rating, prep_time]
    end
    return internet_recipes
  end

  private

  def prep_time_logic(container)
    recipe_page_url = container.search(".card__titleLink").attribute("href").value
    doc = Nokogiri::HTML(URI.open(recipe_page_url).read, nil, "utf-8")
    if doc.search(".recipe-meta-item-header").first.text.strip.include?("prep:")
      return doc.search(".recipe-meta-item-body").first.text.strip
    else
      return "unknown"
    end
  end
end
