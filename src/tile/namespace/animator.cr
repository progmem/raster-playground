class Tile
  class Namespace
    class Animator
      getter animated_tiles = [] of Int32
      getter animations     = [] of Array(Int32)

      @refresh_proc : Proc(Bool)  = ->{ false }
      @index_proc   : Proc(Int32) = ->{ 0 }
      @index = 0

      def initialize(@values : Values)
      end

      def should_refresh
        if animated_tiles.size > 0 && @refresh_proc.call
          new_index = @index_proc.call
          if @index != new_index
            @index = new_index
            return true
          end
        end

        false
      end

      def substitute(tile)
        return tile unless index = animated_tiles.index(tile)
        pool = animations[index]
        pool[@index % pool.size]
      end

      def configure(&block)
        with self yield self
      end

      private def refresh(&block : -> Bool)
        @refresh_proc = block
      end

      private def index(&block : -> Int32)
        @index_proc = block
      end

      private def animate_tile(parent : Int32, children : Array(Int32))
        size  = @animated_tiles.size
        index = @animated_tiles.index(parent) || size

        if index == size
          @animated_tiles.insert index, parent
              @animations.insert index, children
        else
          @animations[index] = children
        end
      end

      def frame
        @values.frames
      end
    end
  end
end