require "crsfml"

require "./level"
require "./tile"

module Game
  struct Acceleration
    property x : Float64 = 0
    property y : Float64 = 0

    @x_cap = 10.0
    @y_cap = 10.0

    def initialize(cap = 10)
      recap(cap)
    end

    def recap(cap)
      @x_cap = cap.to_f
      @y_cap = cap.to_f
    end

    def accel(ax, ay)
      old_x = @x
      old_y = @y

      ax = (ax + @x).clamp(-@x_cap..@x_cap)
      ay = (ay + @y).clamp(-@y_cap..@y_cap)

      @x_moved = true unless ax == @x
      @y_moved = true unless ay == @y

      @x = ax
      @y = ay

      decel_x unless ax.abs >= old_x.abs
      decel_y unless ay.abs >= old_y.abs
    end

    def decel_x
      return if @x == 0.0
      @x *= 0.95
      @x  = @x.ceil  if @x < 0
      @x  = @x.floor if @x > 0
    end

    def decel_y
      return if @y == 0.0
      @y *= 0.95
      @y  = @y.ceil  if @y < 0
      @y  = @y.floor if @y > 0
    end

    def speed
      {@x.round.to_i, @y.round.to_i}
    ensure
      decel_x unless @x_moved
      decel_y unless @y_moved

      @x_moved = false
      @y_moved = false
    end
  end

  extend self

  WINDOW = SF::RenderWindow.new SF::VideoMode.new(1280, 960), "SFML Window", SF::Style::Close
  VIEW   = SF::View.new SF.float_rect(0, 0, 320, 240)
  CLOCK  = SF::Clock.new

  WINDOW.view = VIEW

  ACCEL = Acceleration.new

  BACKDROP = Level::ChemicalPlantBg.as_tile(VIEW)
  LEVEL    = Level::AquaticRuin.as_tile(VIEW)

#  BACKDROP.rasterizer.distortion.configure do |distort|
#    world!
#
#    from_line 0 do |pos|
#      pos * SF.vector2(17/16, 1)
#    end
#
#    from_line 384 do |pos|
#      pos * SF.vector2(1/64, 1)
#    end
#
#    from_line 432 do |pos|
#      pos * SF.vector2(1/8, 1)
#    end
#
#    from_line 452 do |pos|
#      pos * SF.vector2(1/7, 1)
#    end
#
#    from_line 466 do |pos|
#      pos * SF.vector2(1/6, 1)
#    end
#
#    from_line 479 do |pos|
#      pos * SF.vector2(1/5, 1)
#    end
#
#    from_line 482 do |pos|
#      pos * SF.vector2(1/4, 1)
#    end
#
#    from_line 498 do |pos|
#      pos * SF.vector2(1/3, 1)
#    end
#
#    from_line 528 do |pos|
#      (pos * SF.vector2(1/2, 1))
#    end
#
#    from_line 576 do |pos|
#      pos * SF.vector2(17/16, 1)
#    end
#  end

  LEVEL.rasterizer.distortion.configure do |distort|
    # Proc to determine the current water line
    water_line = -> {896 - 8 + (Math.sin(((distort.frame / 6) % 48) / 24 * Math::PI) * 8).round.to_i}

    world!

    from_line 0 do |pos|
      pos
    end

    # Water distortion
    from_line water_line do |pos|
      offset = Math.sin(((distort.line + (distort.frame / 8)) % 64) / 32 * Math::PI)

      pos + SF.vector2(offset, 0)
    end
  end

  BACKDROP.namespace.animator.configure do |config|
    refresh { config.frame % 8 == 0 }
    index   { config.frame // 8 }

    animate_tile 141, [141,174,176,178,180,182,184,186]
    animate_tile 142, [142,175,177,179,181,183,185,187]
  end

  BACKDROP.rasterizer.distortion.configure do |distort|
    world!

    water_line = -> {896 - 8 + (Math.sin(((distort.frame / 6) % 48) / 24 * Math::PI) * 8).round.to_i}

    from_line 0 do |pos|
      pos * {0.5, 0.5}
    end

    from_line water_line do |pos|
      # Correct for having the distortion move everything at half-speed
      line = (distort.line - pos.y) + (pos.y / 2)

      offset = Math.sin(((line + (distort.frame / 8)) % 256) / 128 * Math::PI) * 64
      
      (pos * 0.5) + SF.vector2(0, offset)
    end

  end
  
  LEVEL.move_to 0, 640

  def draw
    WINDOW.clear SF::Color::Blue
    yield
    WINDOW.display
  end

  def loop
    if !SF::Shader.available?
      puts "Oh no"
    end

    palette     = SF::Texture.from_file Level::AquaticRuin.palette
    # palette_bg  = SF::Texture.from_file Level::AquaticRuinBg.palette
    palette_bg  = SF::Texture.from_file Level::ChemicalPlantBg.palette
    palette_cnt = 4
    shader      = SF::Shader.from_file("palette.frag", SF::Shader::Fragment)
    shader.set_parameter "window_height", 240.0
    shader.set_parameter "window_scale", WINDOW.size.y / VIEW.size.y
    
    saved_tile = 0
    auto_move  = false

    focused    = false

    while WINDOW.open?
      while event = WINDOW.poll_event
        focused = true  if event.is_a? SF::Event::GainedFocus
        focused = false if event.is_a? SF::Event::LostFocus
        WINDOW.close if event.is_a? SF::Event::Closed

        if event.is_a? SF::Event::KeyPressed
          auto_move = !auto_move if event.code == SF::Keyboard::Space
        end

        if event.is_a? SF::Event::MouseButtonPressed
          pos      = LEVEL.position + {event.x // 4, event.y // 4}
          tile_pos = SF.vector2(
            pos.x // LEVEL.map.tile_size.x,
            pos.y // LEVEL.map.tile_size.y
          )

          saved_tile = LEVEL.tile_at(tile_pos)        if event.button.middle?
          LEVEL.assign_tile_at(tile_pos, saved_tile)  if event.button.left?
          LEVEL.assign_tile_at(tile_pos, 0)           if event.button.right?
        end

        if event.is_a? SF::Event::MouseWheelScrolled
          unless event.delta == 0
            pos      = LEVEL.position + {event.x // 4, event.y // 4}
            tile_pos = SF.vector2(
              pos.x // LEVEL.map.tile_size.x,
              pos.y // LEVEL.map.tile_size.y
            )

            LEVEL.next_tile_at(tile_pos) if event.delta < 0
            LEVEL.prev_tile_at(tile_pos) if event.delta > 0
          end
        end
      end

      if !focused
        sleep 0.1
        next
      end
      
      water_line = 896 - 8 + (Math.sin(((LEVEL.values.frames / 6) % 48) / 24 * Math::PI) * 8).round
      shader.set_parameter "water_level", water_line

      draw do
        frame = (LEVEL.values.frames // 8) % 4
        GC.collect if frame % 60 == 0

        shader.set_parameter "window_origin", LEVEL.values.position

        shader.set_parameter "palette_cnt", 1.0
        shader.set_parameter "palette",     palette_bg
        WINDOW.draw BACKDROP, SF::RenderStates.new(shader: shader)

        shader.set_parameter "palette_idx", frame.to_f
        shader.set_parameter "palette",     palette
        shader.set_parameter "palette_cnt", palette_cnt.to_f

        WINDOW.draw LEVEL, SF::RenderStates.new(shader: shader)

        GC.collect unless (LEVEL.values.frames % 60) > 0
      end

      ACCEL.accel(-0.2,    0) if SF::Keyboard.key_pressed?(SF::Keyboard::Left)  || SF::Keyboard.key_pressed?(SF::Keyboard::A)
      ACCEL.accel( 0.2,    0) if SF::Keyboard.key_pressed?(SF::Keyboard::Right) || SF::Keyboard.key_pressed?(SF::Keyboard::D)
      ACCEL.accel(   0, -0.2) if SF::Keyboard.key_pressed?(SF::Keyboard::Up)    || SF::Keyboard.key_pressed?(SF::Keyboard::W)
      ACCEL.accel(   0,  0.2) if SF::Keyboard.key_pressed?(SF::Keyboard::Down)  || SF::Keyboard.key_pressed?(SF::Keyboard::S)

      if SF::Keyboard.key_pressed? SF::Keyboard::LShift
        ACCEL.recap 20
      else
        ACCEL.recap 10
      end

      speed = ACCEL.speed
      speed = {1, 0} if auto_move

      LEVEL.move_by   *speed
      BACKDROP.move_to LEVEL.values.position.x, LEVEL.values.position.y

      return if SF::Keyboard.key_pressed? SF::Keyboard::Escape
    end
  end
    
  WINDOW.vertical_sync_enabled = true
  loop
end
