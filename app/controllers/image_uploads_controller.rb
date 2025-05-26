# app/controllers/image_uploads_controller.rb
class ImageUploadsController < ApplicationController
  def create
    @image = ActiveStorage::Blob.create_and_upload!(
      io: params[:file],
      filename: params[:file].original_filename,
      content_type: params[:file].content_type
    )

    render json: {
      url: url_for(@image),
      id: @image.signed_id
    }
  end
end
