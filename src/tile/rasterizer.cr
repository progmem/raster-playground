class Tile
  class Rasterizer < SF::Transformable
    include SF::Drawable

    @vertices = SF::VertexArray.new(SF::Quads)
    @texture  = SF::Texture.new(1,1)

    @width  : Int32
    @height : Int32
    @stripe : SF::Vector2(Int32)

    getter distortion : Distortion    

    def initialize(@namespace : Namespace, @values : Values, screen : SF::Window | SF::View)
      super()

      @width  = screen.size.x.to_i
      @height = screen.size.y.to_i
      @target = SF::RenderTexture.new(@namespace.px_width, @namespace.px_height)

      @stripe = SF.vector2(@width, 1)
      @distortion = Distortion.new(@values)
    end

    def draw(target, states)
      refresh

      states.transform *= transform()
      states.texture    = @texture

      target.draw @vertices, states
    end

    private def pixel_precise(coords)
      SF.vector2 *Tuple(Int32, Int32).from(coords.map(&.round.to_i))
    end

    private def refresh
      @vertices = SF::VertexArray.new(SF::Quads)

      @height.times do |y|
        @values.lines = y
        space_pos   = SF.vector2(0, y)
        texture_pos = @distortion.distort y

        { {0,0}, {1,0}, {1,1}, {0,1} }.each do |delta|
          pos_coords = (space_pos + delta) * @stripe
          tex_coords = texture_pos + pos_coords

          @vertices.append SF::Vertex.new(
            pos_coords,
            tex_coords: pixel_precise(tex_coords)
            # tex_coords: tex_coords
          )
        end
      end

      @target.clear SF::Color.new(0, 0, 0, 0)
      @target.draw @namespace
      @target.display

      @texture = @target.texture
      @texture.repeated = true
    end
  end
end

require "./rasterizer/**"