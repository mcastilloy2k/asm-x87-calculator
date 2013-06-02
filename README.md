asm-x87-calculator
==================

A calculator using 16-bit code, and the FPU (x87).

This a graph calculator, that use the FPU to compute the values on the cartesian plane.  It can graph functions up to
X^5 with integer between -99 to 99 as parameters.  The output is a graph, using the video mode (BIOS interruption) and
the solutions of the function.

The program can solve using three methods of numerical approximation: Newton, Stephensen and Müller.
