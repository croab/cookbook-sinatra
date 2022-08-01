require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"
require_relative 'cookbook'
require_relative 'controller'

CSV_FILE = File.join(__dir__, 'recipes.csv')

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

get "/" do
  erb :root
end

get "/list" do
  @cookbook = Cookbook.new(CSV_FILE)
  @controller = Controller.new(cookbook)
  @controller.list
  erb :list
end
