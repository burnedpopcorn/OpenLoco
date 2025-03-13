varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float time;
uniform float panic;

uniform float red;
uniform float blue;
uniform float green;

//DDP You can change these values to tweak how intense the background is
#define TINTAMOUNT 0.25
#define TINTSPEED 2.0
#define RED_TINT (red + red * sin(TINTSPEED * time * panic)) * TINTAMOUNT * panic
#define BLUE_TINT (blue + blue * sin(TINTSPEED * time * panic)) * TINTAMOUNT * panic
#define GREEN_TINT (green + green * sin(TINTSPEED * time * panic)) * TINTAMOUNT * panic

void main() {
	// Tint background more with time.
	vec2 uv = v_vTexcoord;
	vec4 texel = texture2D(gm_BaseTexture, uv);
	
	texel.r += RED_TINT;
	texel.g += GREEN_TINT;
	texel.b += BLUE_TINT;
	gl_FragColor = texel;
}
