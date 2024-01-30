micromamba env create -n pocl python=3.11

micromamba activate pocl

micromamba install -y clangdev=16 llvmdev=16
micromamba install -y llvm-spirv libhwloc ld64 compilers pkg-config cmake make
micromamba install -y khronos-opencl-icd-loader clhpp

micromamba activate pocl

# from https://github.com/conda-forge/pocl-feedstock
cmake \
  -DCMAKE_INSTALL_PREFIX=$PWD/build/install \
  -DCMAKE_EXPORT_COMPILE_COMMANDS=TRUE \
  -DENABLE_TESTS=FALSE \
  -DENABLE_EXAMPLES=FALSE \
  -DENABLE_ICD=0 -DENABLE_EXTRA_VALIDITY_CHECKS=1 -DENABLE_RELOCATION=0 \
  -DKERNELLIB_HOST_CPU_VARIANTS='cyclone' -DCLANG_MARCH_FLAG='-mcpu=' -DLLC_HOST_CPU=cyclone \
  -DDEVELOPER_MODE=ON -DCMAKE_FIND_FRAMEWORK=NEVER -DCMAKE_PREFIX_PATH=$CONDA_PREFIX \
  -DOPENCL_H=$CONDA_PREFIX/include/CL/opencl.h -DOPENCL_HPP=$CONDA_PREFIX/include/CL/opencl.hpp \
  -DCMAKE_BUILD_TYPE=Debug \
  -DCMAKE_C_FLAGS="-O1 -march=native -Wall -Wextra -Wno-unused-parameter -Wno-unused-variable" \
  -DCMAKE_CXX_FLAGS="-O1 -march=native -Wall -Wextra -Wno-unused-parameter -Wno-unused-variable" \
  -DWITH_LLVM_CONFIG=$CONDA_PREFIX/bin/llvm-config -DLLVM_SPIRV=$CONDA_PREFIX/bin/llvm-spirv \
  -S $PWD -B $PWD/build

cmake --build $PWD/build --config Debug --target install --

# test
build/install/bin/poclcc -l
