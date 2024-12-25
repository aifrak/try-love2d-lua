local Assets = {
  IMAGES_PATH = "assets/images/"
}

function Assets.image_path(path)
  return Assets.IMAGES_PATH .. path
end

return Assets
