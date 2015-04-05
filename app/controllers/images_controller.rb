class ImagesController < ApplicationController
  before_filter :authenticate_user!, only: [:create, :destroy]
  def create
    @submission = Submission.find(params[:submission_id])
    if params[:images]
      params[:images].each { |image|
        @image = @submission.images.build
        @image.location = params[:location]
        @image.image = image
        respond_to do |format|
          if @image.save
            format.json { render json: @image }
          else
            format.json { render json: @image.errors }
          end
        end
      }
    end
  end

  def destroy
    @submission = Submission.find(params[:submission_id])
    @image = @submission.images.find(params[:id])
    if @image.destroy
      respond_to do |format|
        format.json { render json: {:status => "destroyed"}, status: 200}
      end
    else
      respond_to do |format|
        format.json { render json: @image.errors, status: 200}
      end
    end
  end
end
