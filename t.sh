docker run -d -it \
  --name pocl_dev_0 \
  -v $PWD/../:/repos \
  -w /repos \
  base:latest

micromamba env create -n pocl python=3.11

micromamba activate pocl

micromamba install -y clangdev=16 llvmdev=16
micromamba install -y llvm-spirv libhwloc pkg-config cmake ninja
micromamba install -y ocl-icd clhpp

micromamba activate pocl

cat >>~/.bashrc <<-EOF
micromamba activate pocl
export PATH=\$PATH:\${EXT_PATH}
export PYTHONPATH=\$PYTHONPATH:\${EXT_PYTHONPATH}
export LD_LIBRARY_PATH=\$LD_LIBRARY_PATH:\$CONDA_PREFIX/lib
EOF

bash c.sh

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
