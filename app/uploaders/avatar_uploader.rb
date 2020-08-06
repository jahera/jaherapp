require "image_processing/mini_magick"

class AvatarUploader < Shrine
  include ImageProcessing::MiniMagick
  plugin :processing

  plugin :versions, names: [:small, :medium, :large]

  plugin :activerecord
  plugin :determine_mime_type
  plugin :remove_attachment
  plugin :validation_helpers

  Attacher.validate do
    validate_max_size 2.megabytes
    # validate_extension_inclusion [/jpe?g/, 'png', 'gif']
  end

  # process(:store) do |io, context|
  #   original = io.download

  #   size_800 = resize_to_limit!(original, 800, 800)
  #   size_500 = resize_to_limit(size_800,  500, 500)
  #   size_300 = resize_to_limit(size_500,  200, 200)

  #   { original: io, large: size_800, medium: size_500, small: size_300 }
  # end
end
