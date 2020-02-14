// an object factory to manage particles
class Universe {
    int generation = 0;		// how many generations have elapsed
    int pLimit = 4000;      // how many particles to create

    float a, b, c, d;		// equation parameters
    float t;    			// animation frame counter

    Particle[] p = new Particle[pLimit];
    
    // create a set of particles
    Universe() {
        for (int i=0; i<pLimit; i++) {
            p[i] = new Particle();
        }
        reset();
    }

	// randomise parameters and recreate all particles
    void reset() {
        generation = 0;
        
        // ranges defined so as to include de Jong and Bourke examples
        a = random(-2.7, 2.1);
        b = random(-2.6, 2.0);
        c = random(-1.0, 2.5);
        d = random(-2.5, 1.6);
    
        for (int i=0; i<pLimit; i++) {
            p[i].birth(a, b, c, d);
        }
    }

	// draw all particles
    void render() {
        ++generation;
        
        for (int i=0; i<pLimit; i++) {
            p[i].render();
        }
	}

	// display generation counter
    void counter() {
        if (generation % 10 == 0) {
            fill(BLACK);
            noStroke();
            rect(20, height-40, 60, 40);
            fill(GREY);
    		text(generation, 20, height-20);
		}
    }

    // return current parameters 
    String props() {
        return a + " " + b + " " + c + " " + d;
    }
}

// a point travelling a chaotic curve
class Particle {
    float x, y;				// current point
    float xn, yn;			// next point
    
    float a, b, c, d;       // equation parameters

    int age;				// current age
    int maxage = 128;  		// maximum age
    
    float dt = 3.0;			// delta amounts
    float dx = 0.5;
    float dy = 0.5;

	// create particle with equation parameters
    Particle() {
		birth(a, b, c, d);
    }

	// draw
    void render() {
        // equation set - try others!
        
        // --------------------------------------
        xn = sin(a * y) - cos(b * x);
        yn = sin(c * x) - cos(d * y);
        // --------------------------------------

        float d = sqrt((xn-x)*(xn-x) + (yn-y)*(yn-y));
        
        x = xn; y = yn;

        // draw a transparent pixel
        stroke(WHITE, ADDITIVE);
        point( (x/dt + dx) * width, (y/dt + dy) * height );

		// increment age
        age++;
        if (age > maxage) {
            birth(a, b, c, d);
        }
    } 

	// birth point with current parameters and random position
    void birth(float a_, float b_, float c_, float d_) {
        a = a_;
        b = b_;
        c = c_;
        d = d_;
        
        x = random(0.0, 1.0);
        y = random(-1.0, 1.0);
        
        age = 0;
    }
}
