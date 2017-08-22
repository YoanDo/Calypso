# encoding: utf-8

class PhotoUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  process eager: true  # Force version generation at upload time.

  process convert: 'jpg'

  version :standard do
    resize_to_fit 800, 600
  end

  version :profile_picture do
    cloudinary_transformation width: 150, height: 150, radius: "max", crop: :thumb, gravity: :face
  end
end
