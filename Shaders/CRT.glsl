vec4 position(mat4 transformation_projection, vec4 vertex_position) {
    return transformation_projection * vertex_position;
}        

extern float elapsed;

vec2 radialDistortion(vec2 coord, float dist) {
    vec2 cc = coord - 0.5;
    dist = dot(cc, cc) * dist + cos(elapsed * .3) * .01;
    return (coord + cc * (1.0 + dist) * dist);
}

vec4 effect(vec4 color, Image tex, vec2 tc, vec2 pc) {
    vec2 tcr = radialDistortion(tc, .10) + vec2(.0005, 0);
    vec2 tcg = radialDistortion(tc, .06);
    vec2 tcb = radialDistortion(tc, .04) - vec2(.0005, 0);

    vec4 colorRed = vec4(Texel(tex, tcr).r, 0.0, 0.0, 1.0);
    vec4 colorGreen = vec4(0.0, Texel(tex, tcg).g, 0.0, 1.0);
    vec4 colorBlue = vec4(0.0, 0.0, Texel(tex, tcb).b, 1.0);

    vec4 res = colorRed + colorGreen + colorBlue;

    res = res
        - cos(tcg.y * 128. * 3.142 * 2) * .03
        - sin(tcg.x * 128. * 3.142 * 2) * .03;
    return res * Texel(tex, tcg).a;
}