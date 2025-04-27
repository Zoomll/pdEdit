local input = {
  meta = {
    -- Used for backwards compatibility.
    -- The pdEdit version being used.
    version = 1
    bundleID = "com.example.example",
    name = "My Game",
    -- banner is an image with the same dimensions as on the catalog
    banner = "/Shared/path/to/banner"
    tools = {
      rotate = true
      flip = true
      settings = true
    }
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