class Tile
  class Namespace < SF::Transformable
    include SF::Drawable

    OFFSET_STRIPS = 4

    @vertices = SF::VertexArray.new(SF::Quads)

    @px_width   : Int32?
    @px_height  : Int32?

    @last_refresh : Tuple(Int32, Int32) = {0, 0}

    getter animator
    
    def initialize(texture_path, @map : Map, @values : Values)
      super()

      @texture        = SF::Texture.from_file texture_path
      @tiles_per_row  = Int32.new(@texture.size.x // @map.tile_size.x)

      @width    = Int32.new @map.width
      @height   = Int32.new @map.height
      @animator = Animator.new(@values)
      
      refresh!
    end

    # For a given number of tiles, find the power of 2 that can contain at least two dimensions worth of tiles.
    def initialize(texture_path, @map : Map, @values : Values, viewport : SF::Window | SF::View)
      super()

      @texture          = SF::Texture.from_file texture_path
      @tiles_per_row    = Int32.new(@texture.size.x // @map.tile_size.x)

      # There is a limit to the size of texture we can use; we have to make sure not to exceed this.
      texture_size_range = (0..SF::Texture.maximum_size)

      @width  = power_of_two_tiles (viewport.size.x / @map.tile_size.x).clamp(texture_size_range)
      @height = power_of_two_tiles (viewport.size.y / @map.tile_size.y).clamp(texture_size_range)
      @animator = Animator.new(@values)
      
      refresh!
    end

    def px_width
      @px_width   ||= @width  * @map.tile_size.x
    end

    def px_height
      @px_height  ||= @height * @map.tile_size.y
    end

    def draw(target, states)
      refresh
      
      states.transform *= transform()
      states.texture    = @texture

      target.draw @vertices, states
    end

    def refresh!
      refresh(true)
    end

    # Refresh 
    private def should_refresh
      return true if curr_refresh != @last_refresh
      if anim = @animator
        return anim.should_refresh
      end
      false
    end

    private def curr_refresh
      { @values.position.x // @map.tile_size.x // OFFSET_STRIPS,
        @values.position.y // @map.tile_size.y // OFFSET_STRIPS }
    end

    private def refresh(force = false)
      return unless force || should_refresh

      # Determine the nearest tile to start drawing from.
      x_window = @values.position.x // @map.tile_size.x
      y_window = @values.position.y // @map.tile_size.y

      # Calculate offset tables to determine what tiles to fetch.
      x_offset = tile_offsets x_window, @width
      y_offset = tile_offsets y_window, @height

      @vertices = SF::VertexArray.new(SF::Quads)

      @height.times do |y| 
        @width.times do |x|
          tile_x = x_offset[x] % @map.width
          tile_y = y_offset[y] % @map.height

          tile_index = @map.map[@map.width * tile_y + tile_x]
          tile_index = @animator.substitute(tile_index)

          texture_pos = SF.vector2(
            tile_index %  @tiles_per_row,
            tile_index // @tiles_per_row
          )

          destination = SF.vector2(x,y)

          { {0,0}, {1,0}, {1,1}, {0,1} }.each do |delta|
            @vertices.append SF::Vertex.new(
              (destination + delta) * @map.tile_size,
              tex_coords: (texture_pos + delta) * @map.tile_size
            )
          end
        end
      end
      @last_refresh = curr_refresh
    end

    private def tile_offsets(pos, size)
      offset = (size // 4)
      (0...size).to_a
                .map{|v| v + pos - offset}
                .rotate(offset - (pos % size))
    end
    
    private def power_of_two_tiles(dimension)
      2 ** (Math.log(dimension * 2, 2).ceil.to_i)
    end
  end
end

require "./namespace/**"