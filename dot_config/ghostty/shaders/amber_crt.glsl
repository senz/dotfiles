// NOTE:
// This is neat, but I don't find it usable day to day - but it takes me back to good memories 
// from many years ago when I was playing Flight Sim on my grandfather's amber CRT.  :)
//
// I know ZERO glsl shader coding, the code below is courtesy of the work that @m-ahdal has done
//   (https://github.com/m-ahdal/ghostty-shadershttps://github.com/m-ahdal/ghostty-shaders)
// and asking Claude 3.5 Sonnet for assistance. I would love to see someone improve this and make 
// it usable. :)
//
// OH! And it looks way better if you also apply the bloom filter from the github link mentioned.
// 
// Example ~/.config/ghostty/config:
//   custom-shader = "/Users/foo/.config/ghostty/shaders/amber_crt.glsl"
//   custom-shader = "/Users/foo/.config/ghostty/shaders/bloom.glsl"

// Example TINT_COLOR values:
//   Amber (default): vec3(1.0, 0.7, 0.2)
//   Green (classic): vec3(0.6, 1.0, 0.3)
//   Blue (DOS):      vec3(0.3, 0.7, 1.0)
vec3 TINT_COLOR = vec3(1.0, 0.7, 0.2); 

float warp = 0; // simulate curvature of CRT monitor
float scan = 0.25; // simulate darkness between scanlines
float NOISE_GRAIN_SIZE = 0.5; // Controls the size of the noise grain (higher = finer, lower = coarser)
float ENABLE_SCANLINE = 1.0; // Set to 1.0 to enable scanline effect, 0.0 to disable
float SCANLINE_SIZE = 0.6; // Controls scanline frequency (higher = more lines, lower = fewer lines)
float SCANLINE_SPEED = 3.0; // Controls scanline animation speed (higher = faster)

void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    // // Normalized pixel coordinates (from 0 to 1)
    // vec2 uv = fragCoord/iResolution.xy;
    
    // squared distance from center
    vec2 uv = fragCoord / iResolution.xy;
    vec2 dc = abs(0.5 - uv);
    dc *= dc;
    
    // warp the fragment coordinates
    uv.x -= 0.5; uv.x *= 1.0 + (dc.y * (0.3 * warp)); uv.x += 0.5;
    uv.y -= 0.5; uv.y *= 1.0 + (dc.x * (0.4 * warp)); uv.y += 0.5;

    // Soft radial gradient
    float gradient = length(uv - 0.5) * 2.0;
    gradient = 1.0 - smoothstep(0.0, 1.0, gradient);
    
    // Base color from terminal text
    vec3 terminalText = texture(iChannel0, uv).rgb;
    
    // Base color gradient with subtle variation
    vec3 color = mix(
        vec3(0.2), // Lighter center (increased from 0.1)
        vec3(0.4), // Lighter edges (increased from 0.3)
        gradient
    );
    
    // Vignette effect
    float vignette = 1.0 - dot(uv - 0.5, uv - 0.5);
    vignette = smoothstep(0.0, 0.7, vignette); // Reduced darkness at edges
    
    // Scanline effect - barely visible
    float scanline = sin(uv.y * iResolution.y * SCANLINE_SIZE + iTime * SCANLINE_SPEED) * 0.025 + 0.975; // Extremely subtle contrast
    scanline = pow(scanline, 1.02); // Very minimal falloff
    scanline = mix(1.0, scanline, ENABLE_SCANLINE); // If disabled, scanline = 1.0 (no effect)
    
    // Subtle noise overlay
    float noise = fract(sin(dot(uv * NOISE_GRAIN_SIZE + iTime * 0.01, vec2(12.9898, 78.233))) * 43758.5453);
    noise = smoothstep(0.4, 0.6, noise) * 0.03; // Reduced noise
    
    // Amber color transformation
    vec3 amberColor = TINT_COLOR;  // Use customizable tint color
    vec3 finalColor = mix(color, terminalText, 0.9) * amberColor * 1.2; // Increased text visibility and overall brightness
    
    // Combine effects
    finalColor *= vignette;
    finalColor *= scanline;
    finalColor += noise;
    
    // Slight color softening
    finalColor = mix(finalColor, finalColor * 1.1, 0.1);
    
    // Output to screen
    fragColor = vec4(finalColor, 1.0);
}
