# args=(
#   -DCMAKE_BUILD_TYPE=Release
#   -DCMAKE_INSTALL_PREFIX=$PWD/build/install
#   -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
#   -DENABLE_ICD=OFF
#   -DENABLE_SLEEF=OFF
#   -DENABLE_HWLOC=OFF
#   -DENABLE_TESTS=OFF
#   # -DENABLE_EXAMPLES=OFF
#   -DENABLE_PRINTF_IMMEDIATE_FLUSH=OFF
#   -DCLANG_MARCH_FLAG="-mcpu="
#   -DLLC_HOST_CPU="generic-rv64"
#   -DLLC_TRIPLE="riscv64-unknown-linux-gnu"
#   -S$PWD -B$PWD/build -GNinja
# )
# cmake "${args[@]}"
# cmake --build $PWD/build --target all
# cmake --build $PWD/build --target install

###############################################################################

# TODO: how to generate a riscv runtime bin in pocl from a non-riscv host?

args=(
  -DCMAKE_BUILD_TYPE=Debug
  -DCMAKE_INSTALL_PREFIX=$PWD/build/install
  -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
  -DCMAKE_C_COMPILER=/usr/bin/clang
  -DCMAKE_CXX_COMPILER=/usr/bin/clang++
  -DENABLE_ICD=OFF
  -DENABLE_SLEEF=OFF
  -DENABLE_HWLOC=OFF
  -DENABLE_TESTS=OFF
  # -DENABLE_EXAMPLES=OFF
  -DDEVELOPER_MODE=ON
  -DENABLE_PRINTF_IMMEDIATE_FLUSH=OFF
  -DLLC_TRIPLE="riscv64-unknown-linux-gnu"
  # -DKERNELLIB_HOST_CPU_VARIANTS="native"
  -DLLC_HOST_CPU="generic-rv64"
  -DCLANG_MARCH_FLAG="-mcpu="
  -S$PWD -B$PWD/build -GNinja
)
cmake "${args[@]}"

cmake --build $PWD/build --target install

###############################################################################

poclcc -l
