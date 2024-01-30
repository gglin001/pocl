micromamba env create -n pocl python=3.11

micromamba activate pocl

micromamba install -y clangdev=16 llvmdev=16
micromamba install -y llvm-spirv libhwloc ld64 compilers pkg-config cmake make
micromamba install -y khronos-opencl-icd-loader clhpp

micromamba activate pocl

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
