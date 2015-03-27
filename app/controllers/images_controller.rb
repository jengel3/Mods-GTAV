class ImagesController < ApplicationController

  def create
    @submission = Submission.find(params[:submission_id])
    @image = Image.new(create_params)
    @image.submission = @submission
    if @image.save
      redirect_to [@submission, @image]
    else
      render 'edit'
    end
  end

  private
  def image_params
    params.require(:image).permit(:image, :location, :caption)
  end
end
