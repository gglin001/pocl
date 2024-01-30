#!/bin/bash

# from https://github.com/conda-forge/pocl-feedstock
cmake \
  -DCMAKE_BUILD_TYPE=Debug \
  -DCMAKE_INSTALL_PREFIX=$PWD/build/install \
  -DCMAKE_EXPORT_COMPILE_COMMANDS=TRUE \
  -DCMAKE_FIND_FRAMEWORK=NEVER \
  -DENABLE_TESTS=FALSE \
  -DENABLE_EXAMPLES=FALSE \
  -DDEVELOPER_MODE=ON \
  -DENABLE_ICD=0 -DENABLE_EXTRA_VALIDITY_CHECKS=1 -DENABLE_RELOCATION=0 \
  -DCMAKE_PREFIX_PATH=$CONDA_PREFIX \
  -DOPENCL_H=$CONDA_PREFIX/include/CL/opencl.h -DOPENCL_HPP=$CONDA_PREFIX/include/CL/opencl.hpp \
  -DWITH_LLVM_CONFIG=$CONDA_PREFIX/bin/llvm-config -DLLVM_SPIRV=$CONDA_PREFIX/bin/llvm-spirv \
  -S $PWD -B $PWD/build

cmake --build $PWD/build --config Debug --target install --
