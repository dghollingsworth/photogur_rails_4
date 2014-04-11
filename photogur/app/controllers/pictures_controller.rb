class PicturesController < ApplicationController

 	def index
    @most_recent_pictures = Picture.most_recent_five
    @created_before = Picture.created_before(1.month.ago)
  end

  def show
    @picture = Picture.find(params[:id])
    @comments = @picture.comments
  end

  def edit
  	@picture = Picture.find(params[:id])
  end

  def update
  	@picture = Picture.find(params[:id])

  	if @picture.update_attributes(picture_params)
  		redirect_to "/pictures/#{@picture.id}"
  	else
  		render :edit
  	end
  end

	def new
		@picture = Picture.new
	end

	def create
		@picture = Picture.new(picture_params)
		if @picture.save
			redirect_to pictures_url
		else
			render :new
		end#if
	end#create

	def destroy
		@picture = Picture.find(params[:id])
		@picture.destroy
		redirect_to pictures_url
	end
	
	private
	def picture_params
		params.require(:picture).permit(:artist, :title, :url)
	end


end