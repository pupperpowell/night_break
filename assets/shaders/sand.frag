#include <flutter/runtime_effect.glsl>

uniform vec2 uSize;
uniform float uGraininess;
uniform vec3 uBaseColor;
uniform vec3 uSecondaryColor;

out vec4 fragColor;

float random(vec2 st) {
    return fract(sin(dot(st.xy, vec2(12.9898, 78.233))) * 43758.5453123);
}

void main() {
    vec2 st = FlutterFragCoord().xy / uSize;
    
    // Create gradient
    vec3 color = mix(uBaseColor, uSecondaryColor, st.y);
    
    // Add noise
    float noise = random(st * uGraininess);
    color = mix(color, vec3(noise), 0.1);
    
    fragColor = vec4(color, 1.0);
}