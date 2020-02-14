/*
	deJongAttractor

	Implements the Peter de Jong equations:
 		x[n+1] = sin(a y[n]) - cos(b x[n])
 		y[n+1] = sin(c x[n]) - cos(d y[n])
 
 	These were original published in the article:
		Dewdney, A. K. 1987. "Computer recreations: probing the strange attractions
			of chaos", Scientific American 257.1 (July 1987), 108-111.

 	Coded by Paul Bourke in 1989. Free use granted with credit. 
 		http://paulbourke.net/fractals/peterdejong/
 
 	Translated to Processing (c) 2012 Jared Tarbell. MIT License.
 		http://www.complexification.net/gallery/machines/peterdejong/
 
 	This version (c) 2020 Robin Parmar. MIT License.
 
 	Though this version doesn't allow direct specification of the parameters, 
 	it might be useful to know these good values, from Bourke:
         a = 1.641, b = 1.902,  c = 0.316, d= 1.525
         a = 0.970, b = -1.899, c = 1.381, d = -1.506
         a = 1.4,   b = -2.3,   c = 2.4,   d = -2.1 
         a = 2.01,  b = -2.53,  c = 1.61,  d = -0.33 
         a = -2.24, b = 0.43,   c = -0.65, d = -2.43
         
	Versions:
	1.00	 Code refactor. Object factory. Interactivity.
*/

boolean go = true;				// draw?
boolean readout = false;		// display frame counter?

int WHITE = 255;
int BLACK = 0;
int GREY = 100;
int ADDITIVE = 10;            	// degree of transparency

Universe u;

void setup() {
    fullScreen();
	frameRate(20);
	smooth(8);					// 8x anti-aliasing, if supported
    background(BLACK);

	u = new Universe();
}

void draw() {
    u.render();
    if (readout) u.counter();
}

void keyPressed() {
    switch (key) {
    case ' ':                // reset
        go = true;
        loop();
        
        background(BLACK);
        u.reset();
        break;
        
    case 'n':                // new without erasing (cumulative)
        go = true;
        loop();
        u.reset();
        break;
        
    case 's':                // screenshot
        saveFrame(u.props() + " @##.png");
        break;
        
    case 'f':                // frame readout
    	readout = !readout;
        break;
        
    case 'p':				// pause
        go = !go;
        if (!go) {
            println("paused @" + u.generation);
            noLoop();
        } else {
            println("running");
            loop();
        }
        break;
    }
}
