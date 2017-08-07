Achieve this paper: Lee C H, Varshney A, Jacobs D W. Mesh saliency[C]//ACM transactions on graphics (TOG). ACM, 2005, 24(3): 659-666.

### Usage: 

The main files are in Mesh-Saliency/worksheet, including modles(.ply) and executable files(.m). Others also should be added into path.

Firstly, when you want to see the saliency of the model, run prepareDataWS.m for prepare some essential data.

Secondly, run pipelineDemo.m
[saliency, az, el, az2, el2] = meshSaliencyPipeline(Mesh)

`saliency` is the saliency value corresponding to each vertex in the input mesh.

`az`, `el` are the spherical coordinates for the most salient viewpoint.

`az2`, `el2` are the spherical coordinates for the least salient viewpoint.

Thirdly, run displayResults.m and then you can see the mesh saliency in special spherical coordinates.

(Step 1-3 refered to page: http://research.dshin.org/code/saliency-for-3d-meshes.html)

Finally, run maxSaliencyArea.m, you can the most saliency area can be caculated and shown in yellow.