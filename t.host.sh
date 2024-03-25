cat >>~/.bashrc <<-EOF
export PATH=\$PATH:\${EXT_PATH}
export PYTHONPATH=\$PYTHONPATH:\${EXT_PYTHONPATH}
export LD_LIBRARY_PATH=\$LD_LIBRARY_PATH:\$CONDA_PREFIX/lib
EOF

###############################################################################

cmake \
  -DCMAKE_BUILD_TYPE=Debug \
  -DCMAKE_INSTALL_PREFIX=$PWD/build/install \
  -DCMAKE_EXPORT_COMPILE_COMMANDS=ON \
  -DDEVELOPER_MODE=ON \
  -DENABLE_ICD=OFF \
  -DKERNELLIB_HOST_CPU_VARIANTS="generic" -DLLC_HOST_CPU="generic" -DCLANG_MARCH_FLAG="-mcpu=" \
  -S$PWD -B$PWD/build -GNinja

cmake --build $PWD/build --target install

###############################################################################

# test
# POCL_DEBUG=ALL build/bin/poclcc -l
poclcc -l

# `lib/CL/pocl_debug.h`
POCL_DEBUG=ALL build/examples/matadd/matadd
POCL_DEBUG=GENERAL build/examples/matadd/matadd
POCL_DEBUG=LLVM build/examples/matadd/matadd

# misc
rm -f build/llvm_link_test_*
rm -f build/compile_test_*
rm -f build/clang_link_test_*
rm -f compile_test_*.bc
rm -f compile_test_*.o

# misc
micromamba install patchelf
patchelf --print-rpath build/bin/poclcc
