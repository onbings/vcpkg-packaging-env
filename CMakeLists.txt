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

#include(cmake/fetch_content.cmake)

# ===========================
# == Project Definition    ==
# ===========================
project(vcpkg-packaging-env VERSION 1.0.0 LANGUAGES CXX)
#set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreadedDebug")
# ===========================
# == EXTERNAL DEPENDENCIES ==
# ===========================
##option(EVS_HWFW_DIS_BUILD_TESTS               "Build units tests of evs-hwfw-dis" ON)
##option(EVS_HWFW_DIS_FORCE_EXPORT_ALL          "Force exporting all symbols of evs-hwfw-dis (for shared library)" OFF)
##option(EVS_HWFW_DIS_EMSCRIPTEN_WASM_EXCEPTION "Manage Wasm exception" ON)
##option(EVS_HWFW_DIS_ADD_MDNS                  "Add mdns support" ON)
##option(EVS_HWFW_DIS_ADD_AVAHI                 "Add avahi support" ON) 
##option(EVS_HWFW_DIS_ADD_PROMETHEUS            "Add prometheus support" ON)
##option(EVS_HWFW_DIS_ADD_CONSUL                "Add consul support" ON)
##option(EVS_HWFW_DIS_BUILD_DIS_CLIENT          "Build dis client app" ON)
##option(EVS_HWFW_DIS_BUILD_DIS_SERVICE         "Build dis service app" ON)
##message("=======EVS_HWFW_DIS_ADD_MDNS====================================ENV==>" ${EVS_HWFW_DIS_ADD_MDNS})
##if(EVS_HWFW_DIS_BUILD_TESTS)
##  list(APPEND VCPKG_MANIFEST_FEATURES "gtest")
##endif()
##if(EVS_HWFW_DIS_ADD_MDNS)
##  list(APPEND VCPKG_MANIFEST_FEATURES "mdns")
##endif()
##if(EVS_HWFW_DIS_ADD_AVAHI)
##  list(APPEND VCPKG_MANIFEST_FEATURES "avahi")
##endif()
##if(EVS_HWFW_DIS_ADD_PROMETHEUS)
##  list(APPEND VCPKG_MANIFEST_FEATURES "prometheus")
##endif()
##if(EVS_HWFW_DIS_ADD_CONSUL)
##  list(APPEND VCPKG_MANIFEST_FEATURES "consul")
##endif()
##if(EVS_HWFW_DIS_BUILD_DIS_CLIENT)
##  list(APPEND VCPKG_MANIFEST_FEATURES "client")
##endif()
##if(EVS_HWFW_DIS_BUILD_DIS_SERVICE)
##  list(APPEND VCPKG_MANIFEST_FEATURES "service")
##endif()
# Find dependencies here, using find_package
#set(CMAKE_FIND_DEBUG_MODE TRUE)
find_package(bofstd CONFIG REQUIRED)
#find_package(bof2d CONFIG REQUIRED)
find_package(bofwebrpc CONFIG REQUIRED)
find_package(bofdearimgui CONFIG REQUIRED)
find_package(evs-hwfw-dis CONFIG REQUIRED)

#find_package(prometheus-cpp REQUIRED)
#find_package(ppconsul CONFIG REQUIRED)
#find_package(PkgConfig REQUIRED)
# ===========
# == BUILD ==
# ===========
add_executable(vcpkg-packaging-env main.cpp)
set_property(TARGET vcpkg-packaging-env PROPERTY CXX_STANDARD 20)
#get_target_property(deps ONBINGS::bofdearimgui INTERFACE_LINK_LIBRARIES)
#message("==================ENV==>Dependencies: ${deps}")

target_link_libraries(vcpkg-packaging-env
  PRIVATE 
  ONBINGS::bofstd
  #ONBINGS::bof2d
  ONBINGS::bofwebrpc
  ONBINGS::bofdearimgui
  EVS::evs-hwfw-dis
)
