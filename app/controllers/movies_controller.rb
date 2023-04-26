class MoviesController < ApplicationController
  before_action :authenticate_user!, only: [:new]

  def index
    @movies = Movie.available
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new movie_params
    if @movie.save
      flash[:notice] = 'Success'
      redirect_to movies_path
    else
      render :new
    end
  end

  private

  def movie_params
    params.require(:movie).permit(:link)
  end
end
