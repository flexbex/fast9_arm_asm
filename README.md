# fast9_arm_asm
This is my implementation of the Fast9 Image Feature algorithm [2]. It is at least 2 times faster on Arm Processors then the OpenCv implementation and uses advanced Simd. But due to the fact that it is my first Assembler Program. I guess there is still some space for optimization. 
The Fast Algorithm is described in [2]. The Vector comparison is described in [1].
It is implemented for 320x240 uint8_t grayscale image. I did the optimization for Raspberry Pi Arm Cortex a53. For other Armv7 or Armv8 you need to adapt the compiler flags in compile.sh.

To compile and run the program simply hit.
./compile.sh

If it's not working try before with chmod +x compile.sh

Basic idea of Fast is to find pixel on an image that are sorounded in a 3 pix radius by 9 pixels that have a higher or lower value then the center.


Known issues:
- no maximum supression
- only 304 of the possible 314 (you always have to stay away 3 pixels from every edge) pixels.
- thrashhold is fixed to 8 

Code is based on the paper 
[1]https://pdfs.semanticscholar.org/437d/1e988f0cdadce8e7ae6d6e9acb393ba25fad.pdf
[2]https://www.edwardrosten.com/work/fast.html
