class Tile
  class Map
    # Individual tile size
    getter tile_size : SF::Vector2(Int32)

    # Width and height, in tiles.
    getter width  : UInt32
    getter height : UInt32

    # Tile map. Should be width * height in size.
    getter map : Array(UInt32)

    def initialize(@tile_size, width, map)
      @width	= UInt32.new width
      @height = UInt32.new map.size // width
      @map    = map.map {|index| index.to_u32 }

      @max_tile = UInt32.new(@map.max)
    end

    def tile_at(pos : SF::Vector2(Int32))
      position = map_index(pos)

      @map[position]
    end

    def assign_tile_at(pos : SF::Vector2(Int32), index)
      position = map_index(pos)

      new_tile = index % @max_tile
      @map[position] = UInt32.new new_tile
    end
    
    def next_tile_at(pos : SF::Vector2(Int32))
      position = map_index(pos)

      new_tile = (@map[position].to_i + 1) % @max_tile
      @map[position] = UInt32.new new_tile
    end

    def prev_tile_at(pos : SF::Vector2(Int32))
      position = map_index(pos)

      new_tile = (@map[position].to_i - 1) % @max_tile
      @map[position] = UInt32.new new_tile
    end

    private def map_index(pos : SF::Vector2(Int32))
      pos.x = pos.x % width
      pos.y = pos.y % height
      (width * pos.y) + pos.x
    end
  end
end
