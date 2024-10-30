vec4 position(mat4 transformation_projection, vec4 vertex_position) {
    return transformation_projection * vertex_position; // Position the vertex
}

const float brightness = 0.3; // Hardcoded brightness value (0.0 to 1.0)

vec4 effect(vec4 color, Image texture, vec2 texcoord, vec2 pixcoord) {
    vec4 texcolor = Texel(texture, texcoord); // Get the texture color
    texcolor.rgb *= brightness; // Multiply the RGB values by the brightness
    return texcolor; // Return the modified color
}
