local Assets = {
  IMAGES_PATH = "assets/images/",
  MUSIC_PATH = "assets/audio/music/",
  SFX_PATH = "assets/audio/sfx/",
}

function Assets.image_path(path)
  return Assets.IMAGES_PATH .. path
end

function Assets.music_path(path)
  return Assets.MUSIC_PATH .. path
end

function Assets.sfx_path(path)
  return Assets.SFX_PATH .. path
end

return Assets
