# TODO:

## Tile::ValueStore::Global/Local

I'd like a facility that allows me to store private or shared values for synchronization across multiple units. Right now, I have a builder for a Tile class that allows me to synchronize a set of variables across everything built. This works, but updating the value store in one location does not propogate across all.

What I'd like to do is the following:

* Section off the value store to both `Shared` and `Local` spaces.
* Have the main class provide facilities to read these values, preferring `Local` over `Shared`.
* Provide a method that allows for one unit to define which values it should keep in `Shared` space.
* Provide a method that allows for one unit to replace the `Shared` space of one or more other units (effectively synchronizing all shared values).

## Tile::Rasterizer::Shader

Shaders should be integrated within the rasterizer, and leveraged during the draw to the RenderTexture target (if available).

What I'd like to do is the following:

* Provide a means of configuring the shader, like how animations and distortions are done.
* Provide a means of loading shader source code from either a file or from embedded source.
* Provide a key-value store for automatically handling variable passing to shaders.
* Have the key-value store leverage either fixed values or a proc to obtain said values.
* Update proc-based values automatically.
* Update manually-modified values only on request, and only the values requsted.