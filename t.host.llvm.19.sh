args=(
  -DCMAKE_BUILD_TYPE=Debug
  # -DCMAKE_INSTALL_PREFIX=/opt/pocl
  -DCMAKE_INSTALL_PREFIX=$PWD/build/install
  -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
  # -DCMAKE_INSTALL_RPATH=$CONDA_PREFIX/lib
  # fixed rpaths will be set
  -DCMAKE_INSTALL_RPATH_USE_LINK_PATH=ON
  -DCMAKE_C_COMPILER=/usr/bin/clang
  -DCMAKE_CXX_COMPILER=/usr/bin/clang++
  -DDEVELOPER_MODE=ON
  -DENABLE_ICD=OFF
  -DINSTALL_OPENCL_HEADERS=ON
  -DENABLE_TESTS=OFF
  -DENABLE_EXAMPLES=ON

  # iree-llvm docker env
  # ln -s /iree-llvm-project/build/install /iree-llvm-project/build/Release
  -DLLVM_CONFIG=/iree-llvm-project/build/install/bin/llvm-config
  -DLLVM_INCLUDE_DIRS=/iree-llvm-project/build/install/include
  -DSTATIC_LLVM=ON

  -DKERNELLIB_HOST_CPU_VARIANTS="generic"
  -DLLC_HOST_CPU="generic"
  # -DKERNELLIB_HOST_CPU_VARIANTS="native"
  # -DLLC_HOST_CPU="native"
  -DCLANG_MARCH_FLAG="-mcpu="
  -S$PWD -B$PWD/build -GNinja
)
cmake "${args[@]}"

cmake --build $PWD/build --target install

###############################################################################

patchelf --add-rpath "\$ORIGIN/../lib:\$ORIGIN/../lib/CL:\$ORIGIN/../lib/pocl" $(which poclcc)

# test
# POCL_DEBUG=ALL build/bin/poclcc -l
poclcc -l

# TODO: fix error:
# ` |   WARNING |  Loading libpocl-devices-pthread.so failed: libpocl-devices-pthread.so: cannot open shared object file: No such file or directory`

# patchelf --add-rpath "\$ORIGIN/../lib:\$ORIGIN/../lib/CL:\$ORIGIN/../lib/pocl" build/examples/matadd/matadd
patchelf --remove-rpath build/examples/matadd/matadd
patchelf --add-rpath "$PWD/build/install/lib" build/examples/matadd/matadd
patchelf --print-rpath build/examples/matadd/matadd

# `lib/CL/pocl_debug.h`
POCL_DEBUG=ALL build/examples/matadd/matadd
POCL_DEBUG=GENERAL build/examples/matadd/matadd
POCL_DEBUG=LLVM build/examples/matadd/matadd
