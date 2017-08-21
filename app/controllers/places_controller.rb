class PlacesController < ApplicationController
	def index
    if params[:search].present?
      @places = Place.near(params[:search], 10, :order => :distance)
    else
      @places = Place.all
    end
  end

  def new
    @place = Place.new
  end

  def show
  @place = Place.find(params[:id])
	end
	
  def create
    @place = Place.new(place_params)
    if @place.save
      flash[:success] = "Place added!"
      redirect_to root_path
    else
      render 'new'
    end
  end

  private

  def place_params
    params.require(:place).permit(:title, :raw_address, :latitude, :longitude, :visited_by)
  end
end
