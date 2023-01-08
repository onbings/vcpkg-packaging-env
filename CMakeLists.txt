cmake_minimum_required(VERSION 3.15)
message("====ANDROID_PLATFORM====================>" ${ANDROID_PLATFORM})
if(NOT "${ANDROID_PLATFORM}")
    message("ANDROID->include vcpkg_android.cmake")
    include("vcpkg_android.cmake")
endif()
# ===================
# == Build options ==
# ===================
#set(VCPKG_INSTALL_DIR "/opt/evs/vcpkg" CACHE STRING "Specify the vcpkg installation directory")

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
#set(CMAKE_FIND_PACKAGE_REDIRECTS_DIR C:/Android/repo/github/bofstd/share/bofstd)
#set(bofstd_ROOT C:/Android/repo/github/bofstd/share/bofstd)
#set(CMAKE_PREFIX_PATH C:/Android/repo/github/bofstd/share/bofstd)

#message("----------------------->" ${CMAKE_PREFIX_PATH})

#set(CMAKE_FIND_ROOT_PATH ${CMAKE_FIND_ROOT_PATH} C:/Android/repo/github/bofstd/share/bofstd)
#set(CMAKE_FIND_ROOT_PATH ${CMAKE_FIND_ROOT_PATH} C:/Android/repo/github/bofstd)
#set(CMAKE_FIND_ROOT_PATH ${CMAKE_FIND_ROOT_PATH} C:/Android/repo/github)
set(CMAKE_FIND_ROOT_PATH ${CMAKE_FIND_ROOT_PATH} C:/Android/repo C:/Android/repo/github)
message("----------- CMAKE_FIND_ROOT_PATH------------>" ${CMAKE_FIND_ROOT_PATH})
# ===========================
# == EXTERNAL DEPENDENCIES ==
# ===========================
# Find dependencies here, using find_package
find_package(bofstdz REQUIRED NO_MODULE)
find_package(bof2d REQUIRED NO_MODULE)
#find_package(date REQUIRED)

# ===========
# == BUILD ==
# ===========
add_executable(vcpkg-packaging-env main.cpp)
target_link_libraries(vcpkg-packaging-env
  PRIVATE 
  ONBINGS::bofstd
  ONBINGS::bof2d
 # date::date
)
