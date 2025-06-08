set(VCPKG_TARGET_ARCHITECTURE x64)
set(VCPKG_CRT_LINKAGE dynamic)
set(VCPKG_LIBRARY_LINKAGE static)

set(VCPKG_CMAKE_SYSTEM_NAME Linux)

# Enforce C++20 usage and debug info (-g)
set(VCPKG_CXX_FLAGS "-std=c++20 -fPIC -g ${VCPKG_CXX_FLAGS}")
set(VCPKG_C_FLAGS   "-g -fPIC ${VCPKG_C_FLAGS}")