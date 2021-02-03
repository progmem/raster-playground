class Tile
  class Rasterizer
    class Distortion
      # Distortions are a paired table of indexes to procs
      getter distortion_points  = [] of Int32 | Proc(Int32)
      getter procs              = [] of Proc(SF::Vector2(Int32), SF::Vector2(Int32) | SF::Vector2(Float64))

      @distortions = [] of Int32

      @world : Bool  = false
      

      def initialize(@values : Values)
        super()
      end

      def configure(&block)
        with self yield self
        update!
      end

      # Distort an incoming vector at a given line
      def distort(line)
        update if line == 0

        return @values.position unless @distortions.size > 0

        line += @values.position.y if @world
        index   = @distortions.rindex{|l| line >= l}
        index ||= 0
        procs[index].call(@values.position)
      end

      private def update
        return unless @distortion_points.index {|v| v.is_a? Proc(Int32) }
        update!
      end

      private def update!
        @distortions = @distortion_points.map do |v|
          case v
          when Proc(Int32)
            v.call
          else
            v
          end
        end
      end

      private def world!
        @world = true
      end

      private def screen!
        @world = false
      end

      private def from_line(line, &block : SF::Vector2(Int32) -> SF::Vector2(Int32) | SF::Vector2(Float64))
        index = config_index line
        @distortion_points.insert index, line
        @procs.insert       index, block
      end

      private def config_index(line)
        update!

        @distortions.index do |v|
          case line
          when Proc(Int32) then line.call < v
          when Int32       then line      < v
          end
        end || @distortions.size
      end

      # Get the number of elapsed frames
      def frame
        @values.frames
      end

      # Get the number of lines already drawn
      def line
        if @world
          @values.lines + @values.position.y
        else
          @values.lines
        end
      end
    end
  end
end
