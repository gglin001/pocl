# https://github.com/gglin001/Dockerfiles/blob/master/pocl/Dockerfile.riscv
docker exec -it pocl_riscv64_dev_1 bash
pushd /repos/_CL/pocl_linux

# install deps
# NOTE: seems lib polly(s) is dynamic linked, other llvm libs are static libs
apt install --no-install-recommends libclang-18-dev llvm-18-dev

# https://github.com/michaeljclark/busybear-linux/issues/10
# /usr/include/riscv64-linux-gnu/gnu/stubs.h:14:11: fatal error: 'gnu/stubs-lp64.h' file not found
pushd /usr/include/riscv64-linux-gnu/gnu
cp stubs-lp64d.h stubs-lp64.h
popd

# TODO: not work
args=(
  -DCMAKE_BUILD_TYPE=Release
  -DCMAKE_INSTALL_PREFIX=$PWD/build/install
  -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
  # -DCMAKE_C_COMPILER=/usr/bin/clang-18
  # -DCMAKE_CXX_COMPILER=/usr/bin/clang++-18
  -DWITH_LLVM_CONFIG=/usr/bin/llvm-config-18
  -DENABLE_ICD=OFF
  -DENABLE_SLEEF=OFF
  -DENABLE_HWLOC=OFF
  -DENABLE_TESTS=OFF
  -DENABLE_EXAMPLES=ON
  -DENABLE_LLVM=ON
  -DSTATIC_LLVM=ON
  # -DLLVM_LINK_TEST=ON
  # -DCLANG_LINK_TEST=ON
  -DENABLE_PRINTF_IMMEDIATE_FLUSH=OFF
  -DKERNELLIB_HOST_CPU_VARIANTS="native" -DLLC_HOST_CPU="generic-rv64" -DCLANG_MARCH_FLAG="-mcpu="
  # -DLLC_TRIPLE="riscv64-unknown-linux-gnu" -DLLC_HOST_CPU="generic-rv64" -DCLANG_MARCH_FLAG="-mcpu="
  -S$PWD -B$PWD/build -GNinja
)
cmake "${args[@]}"

cmake --build $PWD/build --target install

###############################################################################

poclcc -l

# OCL_ICD_FILENAMES=/home/pocl/build/install/lib/libOpenCL.so clinfo
