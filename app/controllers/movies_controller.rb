class MoviesController < ApplicationController

  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
  
  def index
    movies = Movie.all
    render json: movies
  end

  def show
    movie =Movie.find_by(params[:id]) 
    render json: movie
  end

  def create
    movie = Movie.create(movie_params)
    render json: movie, status: :created
  end
  
  private
  
  def movie_params
    params.permit(:title, :year, :length, :director, :description, :poster_url, :category, :discount, :female_director)
  end

  def render_unprocessable_entity_response(exception)
    render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
  end
  
end
