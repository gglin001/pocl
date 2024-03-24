#!/bin/bash

# from https://github.com/conda-forge/pocl-feedstock
cmake \
  -DCMAKE_BUILD_TYPE=Debug \
  -DCMAKE_INSTALL_PREFIX=$PWD/build/install \
  -DCMAKE_EXPORT_COMPILE_COMMANDS=ON \
  -DCMAKE_FIND_FRAMEWORK=NEVER \
  -DDEVELOPER_MODE=ON \
  -DENABLE_ICD=OFF -DENABLE_EXTRA_VALIDITY_CHECKS=ON -DENABLE_RELOCATION=OFF \
  -DCMAKE_PREFIX_PATH=$CONDA_PREFIX \
  -DOPENCL_H=$CONDA_PREFIX/include/CL/opencl.h -DOPENCL_HPP=$CONDA_PREFIX/include/CL/opencl.hpp \
  -DWITH_LLVM_CONFIG=$CONDA_PREFIX/bin/llvm-config -DLLVM_SPIRV=$CONDA_PREFIX/bin/llvm-spirv \
  -DKERNELLIB_HOST_CPU_VARIANTS="generic" -DLLC_HOST_CPU="generic" -DCLANG_MARCH_FLAG="-mcpu=" \
  -S $PWD -B $PWD/build

cmake --build $PWD/build --config Debug --target install --
