vec4 position(mat4 transformation_projection, vec4 vertex_position) {
    return transformation_projection * vertex_position;
}

const vec3 black = vec3(0, 0, 0);

vec4 effect(vec4 color, Image texture, vec2 texcoord, vec2 pixcoord) {
    vec4 texcolor = Texel(texture, texcoord);
    texcolor.rgb = black;
    return texcolor;
}
