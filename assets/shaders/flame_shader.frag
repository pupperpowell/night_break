#include <flutter/runtime_effect.glsl>

uniform vec2 uResolution;
uniform float uTime;

// Variables
#define Bloom 0.05
#define VerticalMotion 0.01
#define HorizontalMotion 0.20

out vec4 fragColor;

void main() {
    vec2 fragCoord = FlutterFragCoord().xy;

    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = vec2(fragCoord.x, uResolution.y - fragCoord.y) / uResolution.xy;
    vec2 nuv = uv;
    float aspect = uResolution.y / uResolution.x;
    nuv.x *= aspect;
    
    vec2 pos = uv * 2.0-vec2(1.,1.);
    // create horizontal flame variation
    pos.x += sin(uTime*0.1) * uv.y * (sin(uTime - uv.y) + cos((uTime - uv.y) * 0.1)) * 0.5 * HorizontalMotion;
    // create vertical flame variation 
    pos.y += VerticalMotion * fract(sin(30.0*uTime)) + VerticalMotion * sin(uTime);

    // Initialize color with transparency
    vec4 color = vec4(0.0, 0.0, 0.0, 0.0);
    
    // set scale of flame
    float p =.001;
    
    // create shape of flame (output y)
    float y = pow(abs(pos.x), 3.0 + cos(uTime)*0.1)/(1.0*p)*1.0;
    
    // create the hight of flame
    float flame_out = length(pos+vec2(pos.x,y)) * 0.78332;
    
    // fix colors flame by RGB
    color.rg += smoothstep(0.0,0.3,0.6-flame_out);
    
    // fix color of flame by G (green)
    color.g /=2.4;
    
    //add slight blue to the base of the flame
    color.b -= 0.15 * pos.y / flame_out;
    
    //Add bloom
    color.rg += smoothstep(0.0, 10.1, 1.0 / distance(nuv, vec2(pos.x+0.25, (pos.y*0.1+0.4)))) * Bloom;
    color.r += smoothstep(0.0, 5.1, 1.0 / distance(nuv, vec2(pos.x+0.25, (pos.y*0.1+0.5)))) * Bloom;
    
    // output color
    color.rgb += pow(color.r, 1.0);
    
    // Set alpha based on color intensity
    color.a = length(color.rgb);
    
    fragColor = color;
}