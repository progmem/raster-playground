require "./tile/**"

class Tile
  include SF::Drawable
  
  private class Values
    property frames   = 0
    property lines    = 0
    property position : SF::Vector2(Int32) = SF.vector2(0, 0)
  end

  getter values     = Values.new
  getter map        : Map
  getter namespace  : Namespace
  getter rasterizer : Rasterizer

  class Backdrop < Tile
    def initialize(tile_size, width, map, texture_path, viewport)
      super(tile_size, width, map, texture_path, viewport) do
        Namespace.new texture_path, @map, @values
      end
    end
  end

  class Playfield < Tile
    def initialize(tile_size, width, map, texture_path, viewport)
      super(tile_size, width, map, texture_path, viewport) do
        Namespace.new texture_path, @map, @values, viewport
      end
    end
  end
  
  def initialize(tile_size, width, map, texture_path, viewport)
    @map        = Map.new tile_size, width, map
    @namespace  = yield
    @rasterizer = Rasterizer.new @namespace, @values, viewport
  end

  def position
    @values.position
  end

  def move_by(x, y)
    @values.position += SF.vector2(x, y)
  end

  def move_to(x, y)
    @values.position  = SF.vector2(x, y)
  end

  def tile_at(pos)
    @map.tile_at pos
  end

  def assign_tile_at(pos, index)
    @map.assign_tile_at pos, index
    @namespace.refresh!
  end

  def next_tile_at(pos)
    @map.next_tile_at pos
    @namespace.refresh!
  end

  def prev_tile_at(pos)
    @map.prev_tile_at pos
    @namespace.refresh!
  end

  def draw(target, states)
    @rasterizer.draw(target, states)

    @values.frames += 1
  end
end
