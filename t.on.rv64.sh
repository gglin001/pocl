# https://github.com/gglin001/Dockerfiles/blob/master/pocl/Dockerfile.riscv
docker exec -it pocl_riscv64_dev_1 bash
pushd /repos/_CL/pocl_linux

# install deps
# NOTE: seems lib polly(s) is dynamic linked, other llvm libs are static libs
apt install clang-18 libclang-18-dev llvm-18-dev

# TODO: not work
args=(
  -DCMAKE_BUILD_TYPE=Release
  -DCMAKE_INSTALL_PREFIX=$PWD/build/install
  -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
  -DCMAKE_C_COMPILER=/usr/bin/clang-18
  -DCMAKE_CXX_COMPILER=/usr/bin/clang++-18
  -DWITH_LLVM_CONFIG=/usr/bin/llvm-config-18
  -DENABLE_ICD=OFF
  -DSTATIC_LLVM=ON
  -DLLVM_LINK_TEST=ON
  -DCLANG_LINK_TEST=ON
  # -DKERNELLIB_HOST_CPU_VARIANTS="rv64gc" -DLLC_HOST_CPU="rv64gc" -DCLANG_MARCH_FLAG="-march="
  -DKERNELLIB_HOST_CPU_VARIANTS="generic" -DLLC_HOST_CPU="generic" -DCLANG_MARCH_FLAG="-mcpu="
  -S$PWD -B$PWD/build -GNinja
)
cmake "${args[@]}"

cmake --build $PWD/build --target install
