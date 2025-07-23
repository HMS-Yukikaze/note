# llvm-project 构建

```shell
#!/bin/bash
llvm=`pwd`/
build_llvm=`pwd`/build-llvm
build_clang=`pwd`/build-clang21
installprefix=`pwd`/install

mkdir -p $build_llvm    || exit 1
mkdir -p $build_clang   || exit 1 
mkdir -p $installprefix || exit 1

echo "Building in: $build_clang"
# Verify clang source exists
if [ ! -d "$llvm/clang" ]; then
    echo "Error: clang source not found at $llvm/clang"
    exit 1
fi

rm -rf build-llvm



cmake -G Ninja -S $llvm/llvm -B $build_clang \
    -DLLVM_TARGETS_TO_BUILD="X86" \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_CXX_STANDARD=17 \
    -DCMAKE_C_COMPILER=/usr/bin/x86_64-linux-gnu-gcc-11 \
    -DCMAKE_CXX_COMPILER=/usr/bin/x86_64-linux-gnu-g++-11 \
    -DLLVM_ENABLE_PROJECTS="clang;lld;lldb" \
    -DLLVM_ENABLE_RUNTIMES="libcxx;libcxxabi;libunwind" \
    -DCMAKE_EXPORT_COMPILE_COMMANDS=1
#ninja -C $build_llvm install
#ninja -C $build_clang -j4  
```