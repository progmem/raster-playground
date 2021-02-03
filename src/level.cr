class Level
  module Builder
    def palette
      @@palette
    end
  end

  module PlayfieldBuilder
    include Builder 

    def as_tile(view)
      Tile::Playfield.new(SF.vector2(@@tile_width, @@tile_height), @@width, @@map, @@tileset, view)
    end
  end
  
  module BackdropBuilder
    include Builder 

    def as_tile(view)
      Tile::Backdrop.new(SF.vector2(@@tile_width, @@tile_height), @@width, @@map, @@tileset, view)
    end
  end

end

require "./level/**"
