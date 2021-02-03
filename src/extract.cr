require "digest"
require "crsfml"

require "./tile"
require "./tile/**"

module Game
  extend self

  filename, size_x, size_y, class_name = ARGV

  paths = {
    map:     "src/level/%s.cr"        % [class_name.underscore],
    tiles:   "res/levels/%s.png"      % [class_name.underscore],
    palette: "res/levels/%s.pal.png"  % [class_name.underscore]
  }

  # Build a tile-size from arguments
  tile_size = SF.vector2(size_x.to_i, size_y.to_i)
  view      = SF::View.new SF.float_rect(0, 0, tile_size.x, tile_size.y)
  texture   = SF::Texture.from_file filename

  width  = texture.size.x // tile_size.x
  height = texture.size.y // tile_size.y

  level = Tile::Playfield.new(
    tile_size,
    width,
    (0...(width * height)).to_a,
    filename,
    view
  )

  target = SF::RenderTexture.new(tile_size.x, tile_size.y)

  map      = [] of Int32
  indexes  = {} of String => Int32
  images   = [] of SF::Image 
  palette  = [] of SF::Color

  height.times do |y|
    width.times do |x|
      level.move_to x * tile_size.x, y * tile_size.y
      level.namespace.refresh!

      target.clear SF::Color.new 0, 0, 0, 0
      target.draw level
      target.display

      image       = target.texture.copy_to_image

      slice_size  = image.size.x * image.size.y * 4
      slice       = Slice.new(image.pixels_ptr, slice_size)

      digest  = Digest::SHA256.hexdigest(slice)

      index = indexes.fetch(digest) do
        # Record a new index
        i = indexes.size
        indexes[digest] = i

        # Grab colors
        tile_size.y.times do |tile_y|
          tile_size.x.times do |tile_x|
            color = image.get_pixel(tile_x, tile_y)

            unless pal = palette.index(color)
              pal = palette.size
              palette << color
            end

            new_color = SF::Color.new(
              (pal %  8) * 32,
              (pal // 8) * 32,
              0,
              color.a
            )
            image.set_pixel tile_x, tile_y, new_color
          end
        end

        # Record the image data
        images << image
        i
      end

      # Record the index to the map
      map << index
    end
  end

  tiles_per_row = 32

  tex_width  =   tile_size.x * tiles_per_row
  tex_height = ((images.size / tiles_per_row).ceil * 16).to_i

  output = SF::RenderTexture.new(tex_width, tex_height)
  output.clear SF::Color.new 0, 0, 0, 0
  
  images.each.with_index do |image, index|
    x =  (index * tile_size.x)  % tex_width
    y = ((index * tile_size.x) // tex_width) * tile_size.y
    
    position      = SF.vector2(x, y)
    texture       = SF::Texture.from_image image
    tile          = SF::Sprite.new(texture)
    tile.position = position

    output.draw tile
  end
  output.display
  output.texture.copy_to_image.save_to_file paths[:tiles]

  File.open paths[:map], "w" do |f|
    f.puts "class Levels"
    f.puts "  module %s" % class_name
    f.puts "    extend Level::PlayfieldBuilder"
    f.puts "    extend self"
    f.puts ""
    f.puts "    @@tile_width  = %d" % size_x
    f.puts "    @@tile_height = %d" % size_y
    f.puts "    @@tileset     = \"%s\"" % paths[:tiles]
    f.puts "    @@palette     = \"%s\"" % paths[:palette]
    f.puts "    @@width       = %d" % [width]
    f.puts "    @@map         = ["
    height.times do |y|
      f.printf "      "
      width.times do |x|
        pos = (width * y) + x
        f.printf "%4d, " % map[pos]
      end
      f.puts
    end
    f.puts "    ]"
    f.puts "  end"
    f.puts "end"
  end

  palette_image = SF::Image.new(8,8)

  palette.to_a.each.with_index do |color, index|
    palette_image.set_pixel(
      index %  8,
      index // 8,
      color
    )
  end

  palette_image.save_to_file paths[:palette]

  puts "Extracted %d tiles for a tile map of %d * %d" % [images.size, width, height]
end
