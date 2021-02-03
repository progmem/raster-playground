uniform sampler2D texture;
uniform sampler2D palette;
uniform float     palette_cnt;
uniform float     palette_idx;
uniform float     window_height;
uniform float     window_scale;
uniform float     water_level;
uniform vec2      window_origin;

void main()
{
    float pal_idx = mod(palette_idx, palette_cnt);

    float height = float(int(window_origin.y + window_height - ((gl_FragCoord.y - 0.5) / window_scale)));

    // Create a multiplier to determine how to divide up a palette texture.
    vec2 multiplier = vec2(1.0, 1.0 / palette_cnt);
    // Create an offset to index to the next palette.
    vec2 offset     = vec2(0.0, pal_idx / palette_cnt);

    if (water_level > 0.0) {
      multiplier.x = 0.5;

      if (height >= water_level) {
        if (height == water_level) {
          gl_FragColor = vec4(1.0, 1.0, 1.0, 1.0);
          return;
        }
        offset.x = 0.5;
      }
    }
    // Grab current pixel
    vec4 index  = texture2D(texture, gl_TexCoord[0].xy);
    // Use red and green values for texture lookup.
    vec4 lookup = texture2D(palette, (index.xy * multiplier) + offset);
    
    gl_FragColor = lookup;
}
