#include <flutter/runtime_effect.glsl>

uniform vec2 uResolution;
uniform float uTime;

uniform float bloom;
uniform float verticalMotion;
uniform float horizontalMotion;

out vec4 fragColor;

void main() {
    vec2 fragCoord = FlutterFragCoord().xy;
    
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = fragCoord / uResolution;
    vec2 nuv = uv;
    float aspect = uResolution.y / uResolution.x;
    nuv.x *= aspect;
    
    vec2 pos = uv * 2.0 - vec2(1.0, 1.0);
    // create horizontal flame variation
    pos.x += sin(uTime * 0.1) * uv.y * (sin(uTime - uv.y) + cos((uTime - uv.y) * 0.1)) * 0.5 * horizontalMotion;
    
    // create vertical flame variation 
    pos.y += verticalMotion * fract(sin(30.0 * uTime)) + verticalMotion * sin(uTime);
    
    // select background to black
    vec3 color = vec3(0.0, 0.0, 0.0);
    
    // set scale of flame 
    float p = 0.001;
    
    // create shape of flame (output y)
    float y = pow(abs(pos.x), 3.0 + cos(uTime) * 0.1) / (1.0 * p) * 1.0;
    
    // create the height of flame 
    float flame_out = length(pos + vec2(pos.x, y)) * 0.78332; // 0.78332 = sin(0.9)
    
    // fix colors flame by RGB
    color.rg += smoothstep(0.0, 0.3, 0.6 - flame_out);
    
    // fix color of flame by G (green)
    color.g /= 2.4;
    
    // add slight blue to the base of the flame
    color.b -= 0.2 * pos.y / flame_out;
    
    // Add bloom
    color.rg += smoothstep(0.0, 10.1, 1.0 / distance(nuv, vec2(pos.x + 0.25, (pos.y * 0.1 + 0.4)))) * bloom;
    color.r += smoothstep(0.0, 5.1, 1.0 / distance(nuv, vec2(pos.x + 0.25, (pos.y * 0.1 + 0.5)))) * bloom;
    
    // output color
    color += pow(color.r, 1.0);
    fragColor = vec4(color, 1.0);
}