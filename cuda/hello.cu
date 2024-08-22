#include "hello.cuh"


__global__ void hello_from_gpu(){

    const int bx = blockIdx.x;
    const int by = blockIdx.y;
    const int bz = blockIdx.z;

    const int tx = threadIdx.x;
    const int ty = threadIdx.y;
    const int tz = threadIdx.z;

    printf("gpu: hello world! block(%d, %d, %d) -- thread(%d, %d, %d)\n", bx, by, bz, tx, ty, tz);
}

void launch_hello_from_gpu() {
    dim3 threadsPerBlock(2, 2, 2);
    dim3 numBlocks(2, 2, 2);

    hello_from_gpu<<<numBlocks, threadsPerBlock>>>();
    cudaDeviceSynchronize();
}
