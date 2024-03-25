# TODO: needs llvm libs for riscv pocl compiler (and it may not work even though)

args=(
  -DCMAKE_BUILD_TYPE=Release
  -DCMAKE_INSTALL_PREFIX=$PWD/build/install
  -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
  -DCMAKE_TOOLCHAIN_FILE=$PWD/ToolchainExample.cmake
  -DBUILD_SHARED_LIBS=ON
  -DENABLE_LLVM=OFF
  -DENABLE_POCLCC=OFF
  -DENABLE_TESTS=OFF
  -DENABLE_EXAMPLES=ON
  -DHOST_DEVICE_BUILD_HASH=00000000
  # -DHOST_DEVICE_BUILD_HASH=riscv64-unknown-linux
  -DHAVE_64BIT_ATOMICS_WITHOUT_LIB=ON
  -DCMAKE_BUILD_WITH_INSTALL_RPATH=ON
  -DENABLE_LOADABLE_DRIVERS=OFF
  -DENABLE_HWLOC=OFF
  -DENABLE_HOST_CPU_DEVICES=ON
  -S $PWD -B $PWD/build -GNinja
)
cmake "${args[@]}"

cmake --build $PWD/build --target install

# =============================================================================

args=(
  -cpu rv64,v=true,vext_spec=v1.0
  -L /opt/riscv/sysroot
  # only runtime is built
  build/examples/boxadd/boxadd
  # build/examples/example0/example0
  # build/examples/enumopencl/enumopencl
)
qemu-riscv64 "${args[@]}"
