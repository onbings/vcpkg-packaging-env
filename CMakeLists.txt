cmake_minimum_required(VERSION 3.15)
# cmake -DCMAKE_TOOLCHAIN_FILE=/home/bha/pro/vcpkg/scripts/buildsystems/vcpkg.cmake -DBUILD_SHARED_LIBS=ON -DVCPKG_TARGET_TRIPLET=x64-linux  -DVCPKG_OVERLAY_PORTS=/home/bha/pro/github/onbings-vcpkg-registry/ports/ -DRHEL:STRING="el9" -B/home/bha/bld/a -S/home/bha/pro/github/vcpkg-packaging-env
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
find_package(bofdearimgui CONFIG REQUIRED)
find_package(bofwebrpc CONFIG REQUIRED)
#set(CMAKE_FIND_DEBUG_MODE FALSE)
# ===========
# == BUILD ==
# ===========
add_executable(vcpkg-packaging-env main.cpp)
target_link_libraries(vcpkg-packaging-env
  PRIVATE 
  ONBINGS::bofstd
  ONBINGS::bofdearimgui
  ONBINGS::bofwebrpc
)
