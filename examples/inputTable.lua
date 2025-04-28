local input = {
  meta = {
    -- Used for backwards compatibility.
    -- The pdEdit version being used.
    -- NOTE: Versions will not be used until pdEdit 1.0 is out. For now it should always equal 1.
    version = 1
    bundleID = "com.example.example",
    name = "My Game",
    -- banner is an image with the same dimensions as on the catalog
    banner = "/Shared/path/to/banner"
    -- Tools are editing modes used in the editor.
    -- Some settings are only available when certain tools are enabled.
    tools = {
      rotate = true
      flip = true
      -- Settings tool is used to select custom settings.
      settings = true
    },
    -- maxX and maxY must use values <= 255. The minimum X and Y pos will always be 0.
    maxX = 255,
    maxY = 255
  },
  objects = {
    [1] = {
      meta = {
        name = "block",
        texture = "/Shared/path/to/texture"
      },
      settings = {
        canRotate = true,
        canFlip = true,
        rotations = [0,90,180,270],
        -- You can define custom settings for an object for your game to use.
        custom = {
          slippery = "bool"
        }
      }
    }
  }
}