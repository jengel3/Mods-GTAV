class ImagesController < ApplicationController
  layout false
  def create
    @submission = Submission.find(params[:submission_id])
    if params[:images]
      params[:images].each { |image|
        @image = @submission.images.create(image: image, location: params[:location])
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
end
