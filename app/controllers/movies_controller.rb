class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @movies = Movie.all
    
    # Get All Possible Ratings
    @all_ratings = Movie.all_ratings
    
    if params[:ratings] == nil    
      # If no checkbox is selected, display everything
      @ratings = {}
      @all_ratings.each {|key| @ratings[key] = "1"} 
    else
      @ratings = params[:ratings]
    end
    
    if @ratings.length > 0
      @movies = @movies.where(:rating => @ratings.keys)
    end

    # Sorting the table by selected column
    @order = params[:sorted]
    if @order != nil
      @movies = @movies.order(@order)
    end
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
