#ifndef __HELLO_CUH__
#define  __HELLO_CUH__

#include <stdio.h>
#include <cuda_runtime.h>
#include <cuda_runtime_api.h>
#include <device_launch_parameters.h>

/*core func*/
__global__ void hello_from_gpu();
/*wrapper func*/
void launch_hello_from_gpu();
#endif