#include <cuda_runtime.h>
#include <cuda_runtime_api.h>
#include "hello.cuh"



int main() {
    launch_hello_from_gpu();

    return 0;
}
