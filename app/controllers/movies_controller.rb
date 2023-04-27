class MoviesController < ApplicationController
  before_action :authenticate_user!, only: [:new]

  def index
    @movies = Movie.available.includes(:user)
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new movie_params
    @movie.user = current_user
    if @movie.save
      flash[:notice] = 'Your movie will be publish if available'
      redirect_to movies_path
    else
      flash[:alert] = @movie.errors.first.full_message
      redirect_back(fallback_location: movies_path)
    end
  end

  private

  def movie_params
    params.require(:movie).permit(:link)
  end
end
