cmake_minimum_required(VERSION 3.15)
# ===================
# == Build options ==
# ===================
#set(VCPKG_INSTALL_DIR "/opt/onbings/vcpkg" CACHE STRING "Specify the vcpkg installation directory")

# ====================================================
# == VCPKG overlay configuration, for local testing ==
# ====================================================
#set(VCPKG_OVERLAY_TRIPLETS ${CMAKE_SOURCE_DIR}/vcpkg/triplets)
#set(VCPKG_OVERLAY_PORTS ${CMAKE_SOURCE_DIR}/vcpkg/ports)
#set(VCPKG_FEATURE_FLAGS registries versions)
#set(CMAKE_TOOLCHAIN_FILE ${VCPKG_INSTALL_DIR}/scripts/buildsystems/vcpkg.cmake CACHE STRING "Vcpkg toolchain file")


# ===========================
# == Project Definition    ==
# ===========================
project(vcpkg-packaging-env VERSION 0.0.0 LANGUAGES CXX)
set(CMAKE_FIND_DEBUG_MODE false)
# ===========================
# == EXTERNAL DEPENDENCIES ==
# ===========================
# Find dependencies here, using find_package
find_package(bofstd REQUIRED NO_MODULE)
find_package(bof2d REQUIRED NO_MODULE)

# ===========
# == BUILD ==
# ===========
add_executable(vcpkg-packaging-env main.cpp)
target_link_libraries(vcpkg-packaging-env
  PRIVATE 
  ONBINGS::bofstd
  ONBINGS::bof2d
)
