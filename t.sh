micromamba env create -n pocl python=3.11

micromamba activate pocl

micromamba install -y clangdev=16 llvmdev=16
micromamba install -y llvm-spirv libhwloc ld64 compilers pkg-config cmake make
# micromamba install -y khronos-opencl-icd-loader clhpp

# # release
# # from `.github/workflows/build_cmake_macos.yml`
# micromamba activate pocl
# cmake \
#   -DCMAKE_INSTALL_PREFIX=$PWD/build/install \
#   -DCMAKE_EXPORT_COMPILE_COMMANDS=TRUE \
#   -DENABLE_ICD=0 -DENABLE_EXTRA_VALIDITY_CHECKS=1 -DENABLE_RELOCATION=0 \
#   -DDEVELOPER_MODE=ON -DCMAKE_FIND_FRAMEWORK=LAST -DCMAKE_PREFIX_PATH=$CONDA_PREFIX \
#   -DOPENCL_H=$CONDA_PREFIX/include/CL/opencl.h -DOPENCL_HPP=$CONDA_PREFIX/include/CL/opencl.hpp \
#   -DCMAKE_BUILD_TYPE=Release \
#   -DCMAKE_C_FLAGS_RELEASE="-O1 -march=native -Wall -Wextra -Wno-unused-parameter -Wno-unused-variable" \
#   -DCMAKE_CXX_FLAGS_RELEASE="-O1 -march=native -Wall -Wextra -Wno-unused-parameter -Wno-unused-variable" \
#   -DWITH_LLVM_CONFIG=$CONDA_PREFIX/bin/llvm-config -DLLVM_SPIRV=$CONDA_PREFIX/bin/llvm-spirv \
#   -S $PWD -B $PWD/build
# cmake --build $PWD/build --config Release --target all --

# debug
# TODO: not work
micromamba activate pocl
cmake \
  -DCMAKE_INSTALL_PREFIX=$PWD/build/install \
  -DCMAKE_EXPORT_COMPILE_COMMANDS=TRUE \
  -DCMAKE_BUILD_TYPE=Debug \
  -DENABLE_ICD=1 \
  -DCMAKE_FIND_FRAMEWORK=NEVER \
  -DDEVELOPER_MODE=ON -DENABLE_EXTRA_VALIDITY_CHECKS=ON -DENABLE_RELOCATION=ON \
  -DCMAKE_PREFIX_PATH=$CONDA_PREFIX \
  -DOPENCL_H=$CONDA_PREFIX/include/CL/opencl.h -DOPENCL_HPP=$CONDA_PREFIX/include/CL/opencl.hpp \
  -DWITH_LLVM_CONFIG=$CONDA_PREFIX/bin/llvm-config -DLLVM_SPIRV=$CONDA_PREFIX/bin/llvm-spirv \
  -S $PWD -B $PWD/build

cmake --build $PWD/build --config Debug --target all --

# test
build/bin/poclcc -l
