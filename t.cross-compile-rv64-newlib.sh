# WIP, terget: buil cpu-minimum only(no pthread and other extra libs)

args=(
  -DCMAKE_BUILD_TYPE=Release
  -DCMAKE_INSTALL_PREFIX=$PWD/build/install
  -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
  -DBUILD_SHARED_LIBS=OFF
  -DCMAKE_TOOLCHAIN_FILE=$PWD/ToolchainExample.cmake
  -DENABLE_LLVM=OFF
  -DENABLE_POCLCC=OFF
  -DENABLE_TESTS=OFF
  # -DENABLE_EXAMPLES=ON
  -DENABLE_EXAMPLES=OFF
  -DHOST_DEVICE_BUILD_HASH=00000000
  # -DHOST_DEVICE_BUILD_HASH=riscv64-unknown-linux
  -DHAVE_64BIT_ATOMICS_WITHOUT_LIB=ON
  -DCMAKE_BUILD_WITH_INSTALL_RPATH=ON
  -DENABLE_LOADABLE_DRIVERS=OFF
  -DENABLE_HWLOC=OFF
  #
  -DCROSS_COMPILATION=ON
  -DCMAKE_CROSS_COMPILATION=ON
  -DENABLE_HOST_CPU_BASIC_ONLY=ON
  -DENABLE_HOST_CPU_DEVICES=OFF
  # -DENABLE_HOST_CPU_DEVICES=ON
  #
  -S $PWD -B $PWD/build -GNinja
)
cmake "${args[@]}"

cmake --build $PWD/build --target all --
cmake --build $PWD/build --target install --

# =============================================================================

args=(
  -cpu rv64,v=true,vext_spec=v1.0
  -L /opt/riscv_llvm_glibc/sysroot
  # only runtime is built
  # build/examples/boxadd/boxadd
  # build/examples/example0/example0
  build/examples/enumopencl/enumopencl
)
qemu-riscv64 "${args[@]}"
