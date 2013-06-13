class MoviesController < ApplicationController


  def index
    @all_ratings, selected_ratings, @checked_ratings = Movie.ratings, [], Movie.ratings

    if params[:Search] 
      @movies = Movie.where(:actors => params[:Search])
      
    elsif params[:sort] == "title" 
      @movies = Movie.group("title").where(:rating => session[:ratings]).all
      @checked_ratings = session[:ratings]
      @hilite1 = "title"
      session[:sort] = params[:sort]

    elsif params[:sort] == "release_date"
      @movies = Movie.group("release_date").where(:rating => session[:ratings]).all
      @checked_ratings = session[:ratings]
      @hilite2 = "release_date"
      session[:sort] = params[:sort]

    elsif !params[:ratings].nil?
      params[:ratings].each_key {|k| selected_ratings << k} unless params[:ratings].nil?
      session[:ratings] = selected_ratings
      @movies = Movie.group(session[:sort]).where(:rating => selected_ratings).all
      @checked_ratings = session[:ratings]
      if session[:sort] == "title"
        @hilite1 = "title"
      elsif session[:sort] == "release_date"
        @hilite2 = "release_date" 
      end

    else # No params selected, index page reloaded
      @movies = Movie.all
      if session[:sort] == "title"
        @hilite1 = "title"
        @movies = Movie.group("title").all
      elsif session[:sort] == "release_date"
        @hilite2 = "release_date" 
        @movies = Movie.group("release_date").all
      end
      if params[:ratings].nil? && !params[:commit].nil?
        puts session[:ratings]
        @checked_ratings = Movie.ratings
      else
        puts session[:ratings]
        @checked_ratings = session[:ratings] unless session[:ratings].nil?
      end
      if !session[:sort].nil?
        @movies = Movie.group(session[:sort]).where(:rating => session[:ratings]).all
      else
        @movies = Movie.where(:rating => session[:ratings]).all
      end
      # flash.keep
      # redirect_to movies_path(:sort => session[:sort], :rating => session[:ratings].to_param)
    end


  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(params[:movie])
    if !@movie.title.empty?
      @movie.save
      flash[:notice] = "#{@movie.title} was successfully created."
      redirect_to movies_path
    else
      flash[:notice] = "You left the title blank!"
      render :action => 'new'
    end
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

  def search_tmdb
    flash[:warning] = "'#{params[:search_terms]}' was not found in TMDb."
    redirect_to movies_path
  end

end
