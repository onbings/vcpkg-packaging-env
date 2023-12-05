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

# ===========================
# == EXTERNAL DEPENDENCIES ==
# ===========================
# Find dependencies here, using find_package
#set(CMAKE_FIND_DEBUG_MODE TRUE)
find_package(bofstd CONFIG REQUIRED)
find_package(bof2d CONFIG REQUIRED)
#set(CMAKE_FIND_DEBUG_MODE FALSE)
# ===========
# == BUILD ==
# ===========
add_executable(vcpkg-packaging-env main.cpp)
target_link_libraries(vcpkg-packaging-env
  PRIVATE 
  ONBINGS::bofstd
  ONBINGS::bof2d
)
