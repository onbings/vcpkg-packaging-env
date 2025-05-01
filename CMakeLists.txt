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

include(cmake/fetch_content.cmake)

# ===========================
# == Project Definition    ==
# ===========================
project(vcpkg-packaging-env VERSION 0.0.0 LANGUAGES CXX)
set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreadedDebug")
#message("==============================================start fetch=========================")
#fetch_external_library_add(googletest "${LIST_OF_LIB}" https://github.com/google/googletest release-1.12.1)
#fetch_external_library_add(spdlog "${LIST_OF_LIB}" https://github.com/gabime/spdlog v1.12.0)
#make_external_library_available("${LIST_OF_LIB}")
#message("==============================================END fetch=========================")
# ===========================
# == EXTERNAL DEPENDENCIES ==
# ===========================
# Find dependencies here, using find_package
#set(CMAKE_FIND_DEBUG_MODE TRUE)
find_package(bofstd CONFIG REQUIRED)
#find_package(bof2d CONFIG REQUIRED)
find_package(bofwebrpc CONFIG REQUIRED)
find_package(bofdearimgui CONFIG REQUIRED)
find_package(imgui CONFIG REQUIRED)
#set(CMAKE_FIND_DEBUG_MODE FALSE)
# ===========
# == BUILD ==
# ===========
add_executable(vcpkg-packaging-env main.cpp)
set_property(TARGET vcpkg-packaging-env PROPERTY CXX_STANDARD 17)

target_link_libraries(vcpkg-packaging-env
  PRIVATE 
  ONBINGS::bofstd
  #ONBINGS::bof2d
  ONBINGS::bofwebrpc
  ONBINGS::bofdearimgui
  hello-imgui::hello_imgui
)
