micromamba env create -n pocl python=3.11

micromamba activate pocl

micromamba install -y clangdev=16 llvmdev=16
micromamba install -y llvm-spirv libhwloc ld64 compilers pkg-config cmake make
micromamba install -y khronos-opencl-icd-loader clhpp

micromamba activate pocl

bash c.sh

# test
# build/install/bin/poclcc -l
poclcc -l

# > poclcc -l
# LIST OF DEVICES:
# 0:
#   Vendor:   ARM
#     Name:   cpu
#  Version:   OpenCL 3.0 PoCL HSTR: cpu-arm64-apple-macosx14.0.0-cyclone
