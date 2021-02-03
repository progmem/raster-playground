# Oh god, what is this?

I got in the mood to do some gamedev. It's been a while since I've done any gamedev stuff proper (maybe a decade?) and I got a hankering to get back into it.

One of my major influences growing up was the **Sega Genesis** (Megadrive), and in particular the **Sonic The Hedgehog** series. The Genesis, much like its counterpart, the **Super Nintendo** (Super Famicom), primarily uses a tile-driven approach to displaying graphics: tiles are drawn to some kind of plane, and a portion of that plane is rendered.

When rendering, images were drawn line by line, starting with the pixel data on the left and moving to the right. Due to how displays drew, there was a brief period of time, known as the **horizontal blanking period**, where the display would prepare to draw the next line. This time could be used to make small adjustments to the graphics data being used to compose the image, which allowed for fancy effects like **parallax scrolling** and **water effects** by adjusting the postion of layers and the palette used to draw them.

This repository is a work in progress to develop a renderer in the same vain. This may not be the most optimal renderer in the world, but it's my take on some of the same techniques and should allow me to (eventually) develop a game.
