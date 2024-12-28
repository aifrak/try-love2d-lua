local Assets = {}

-- Images
local IMAGES_PATH = "assets/images/"
local PLAYERS_PATH = "assets/images/sprites/characters/players/"
local NPCS_PATH = "assets/images/sprites/characters/npcs/"
local ITEMS_PATH = "assets/images/sprites/items/"
local MAPS_PATH = "assets/images/maps/"

-- Audio
local MUSIC_PATH = "assets/audio/music/"
local SFX_PATH = "assets/audio/sfx/"


function Assets.image_path(path)
  return IMAGES_PATH .. path
end

function Assets.players_path(path)
  return PLAYERS_PATH .. path
end

function Assets.npcs_path(path)
  return NPCS_PATH .. path
end

function Assets.items_path(path)
  return ITEMS_PATH .. path
end

function Assets.maps_path(path)
  return MAPS_PATH .. path
end

function Assets.music_path(path)
  return MUSIC_PATH .. path
end

function Assets.sfx_path(path)
  return SFX_PATH .. path
end

return Assets
