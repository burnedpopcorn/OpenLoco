varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float time;
uniform float panic;
uniform float lap3;

uniform float red;
uniform float blue;
uniform float green;

//DDP You can change these values to tweak how intense the background is
#define WAVELENGTH 48.0
#define AMPLITUDE 0.005
#define TINTAMOUNT 0.35
#define TINTSPEED 2.0
#define RED_TINT (red + red * sin(TINTSPEED * time * panic)) * TINTAMOUNT * panic
#define BLUE_TINT (blue + blue * sin(TINTSPEED * time * panic)) * TINTAMOUNT * panic
#define GREEN_TINT (green + green * sin(TINTSPEED * time * panic)) * TINTAMOUNT * panic
void main() {
	// Wobble back and forth more with time.
	vec2 uv = v_vTexcoord;
	uv.x += sin(WAVELENGTH * uv.y + 3.0 * time * panic) * AMPLITUDE * panic;
	uv.y += cos(WAVELENGTH * uv.x + 3.0 * time * panic) * AMPLITUDE * panic * lap3;
	//uv.z += sin(WAVELENGTH * uv.y + 3.0 * time * panic) * AMPLITUDE * panic;
	
	// Tint background more with time.
	vec4 texel = texture2D(gm_BaseTexture, uv);

	//texel.r += RED_TINT;
	//texel.g += GREEN_TINT;
	//texel.b += BLUE_TINT;
	gl_FragColor = texel;
}
