# 3d Terrain Generator

This is a 3d Terrain Generator I created a while ago - I don't plan on updating it very much any more. The generated terrains simulate climate, temperature and plant growth. There is a wide variety of terrain types. It requires [Processing 3](processing.org), as well as the `peasycam` and `G4P` libraries.

NOTE: On some systems depth testing doesn't work properly for some reason, and the 3d graphics may look strange.

How to use:
- Click Generate Random to generate a new, random terrain. The seed for the terrain will appear in the box above.
- Click and drag with the left mouse button to rotate the view. Use the middle mouse button to pan, and the right mouse button to zoom.
- Enter a seed (must be an integer with no special characters or letters, between -2,147,483,648 and 2,147,483,647) and click Generate w/ Seed to generate a new random terrain with a seed. A certain seed will always generate the same terrain, so this can be a way to save a terrain you like. New versions of the Terrain Generator, however, may not give the same results.
- Click one of the four seasons to draw the same terrain, in a different season. By default, a random season is chosen. These buttons will currently clear any rotations you have made. Keep in mind that, in many places, it doesn't snow in the winter, and in others snow might not melt even in the spring or summer.