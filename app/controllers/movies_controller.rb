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
    @all_ratings = Movie.all_ratings
    @sort = params[:sort]
    
    if params[:ratings]
      @rating_checked = params[:ratings].keys
      session[:ratings] = params[:ratings].keys
    elsif session[:ratings] == nil
      @rating_checked = @all_ratings
    else
      @rating_checked = session[:ratings]
      #session[:ratings].clear
    end
    

    if @sort 
      session[:sort] = @sort
      @movies = Movie.with_ratings(@rating_checked).order(@sort)
      #flash[:notice] = "if redirect to new page #{@rating_checked} “  #{session[:sort]}"
    
    elsif session[:sort] == nil
      @movies = Movie.all
    
    else
      @movies = Movie.with_ratings(@rating_checked).order(session[:sort])
      @sort = session[:sort]
      #session[:sort].clear
      #flash[:notice] = "elseif redirect to new page #{session[:sort]}"
      #redirect_to movies_path
    # else
    #   @movies = Movie.with_ratings(@rating_checked).order(session[:sort])
    #   flash[:notice] = "else redirect to new page #{session[:sort]}"
    #   #redirect_to movies_path
    #   # @movies = Movie.with_ratings(@rating_checked)
    end
    
    #session.clear
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
