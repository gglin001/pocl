#
cmake \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_INSTALL_PREFIX=$PWD/build/install \
  -DCMAKE_EXPORT_COMPILE_COMMANDS=ON \
  -DENABLE_ICD=OFF \
  -DENABLE_SLEEF=OFF \
  -DCLANG_MARCH_FLAG="-mcpu=" \
  -DLLC_HOST_CPU="generic-rv64" \
  -DLLC_TRIPLE="riscv64-unknown-linux-gnu" \
  -S $PWD -B $PWD/build

cmake --build $PWD/build --target all
cmake --build $PWD/build --target install

###############################################################################

poclcc -l
