
message("\n==vcpkg_android.cmake==INPUT VAR:")
message("==vcpkg_android.cmake==ANDROID_PLATFORM===============> " ${ANDROID_PLATFORM})
message("==vcpkg_android.cmake==CPP_ANDROID_PRJ================> " ${CPP_ANDROID_PRJ})
message("==vcpkg_android.cmake==CPP_ANDROID_ABI================> " ${CPP_ANDROID_ABI})
message("==vcpkg_android.cmake==ANDROID_NDK_HOME===============> " ${ANDROID_NDK_HOME})
message("==vcpkg_android.cmake==VCPKG_ROOT=====================> " ${VCPKG_ROOT})
message("==vcpkg_android.cmake==CPP_ANDROID_REPO_BLD_ROOT======> " ${CPP_ANDROID_REPO_BLD_ROOT})
message("==vcpkg_android.cmake==CMAKE_BUILD_TYPE===============> " ${CMAKE_BUILD_TYPE})
message("==vcpkg_android.cmake==VCPKG_OVERLAY_PORTS============> " ${VCPKG_OVERLAY_PORTS})

# message("==vcpkg_android.cmake=======> Start of variable")
# get_cmake_property(_variableNames VARIABLES)
# list (SORT _variableNames)
# foreach (_variableName ${_variableNames})
#    message(STATUS "${_variableName}=${${_variableName}}")
# endforeach()
# message("==vcpkg_android.cmake=======> End of variable")

if(NOT "${ANDROID_PLATFORM}")
	message("\n")
	string(CONCAT MKDIR ${CPP_ANDROID_REPO_BLD_ROOT} "/bld/" ${CPP_ANDROID_PRJ} "/Debug")
	message("Create Debug bld directory:       " ${MKDIR}) 
	file(MAKE_DIRECTORY ${MKDIR})
	
	string(CONCAT MKDIR ${CPP_ANDROID_REPO_BLD_ROOT} "/bld/" ${CPP_ANDROID_PRJ} "/Release")
	message("Create Release bld directory:     " ${MKDIR}) 
	file(MAKE_DIRECTORY ${MKDIR})
	
	string(CONCAT MKDIR ${CPP_ANDROID_REPO_BLD_ROOT} "/repo/" ${CPP_ANDROID_PRJ})
	message("Create repo directory:            " ${MKDIR}) 
	file(MAKE_DIRECTORY ${MKDIR})
	
	message("Set env var ANDROID_NDK_HOME to : " ${ANDROID_NDK_HOME}) 
	set(ENV{ANDROID_NDK_HOME} ${ANDROID_NDK_HOME})
	message("Set env var VCPKG_ROOT to :       " ${VCPKG_ROOT}) 
	set(ENV{VCPKG_ROOT} ${VCPKG_ROOT})

    if (NOT DEFINED ENV{ANDROID_NDK_HOME})
        message(FATAL_ERROR "
        Please set an environment variable ANDROID_NDK_HOME
        For example:
        export ANDROID_NDK_HOME=/home/your-account/Android/Sdk/ndk-bundle
        Or:
        export ANDROID_NDK_HOME=/home/your-account/Android/android-ndk-r21b
        ")
    endif()
	
    if (NOT DEFINED ENV{VCPKG_ROOT})
        message(FATAL_ERROR "
        Please set an environment variable VCPKG_ROOT
        For example:
        export VCPKG_ROOT=/path/to/vcpkg
        ")
    endif()

    #
    # There are four different Android ABI, each of which maps to 
    # a vcpkg triplet. The following table outlines the mapping from vcpkg architectures to android architectures
    #
    # |VCPKG_TARGET_TRIPLET       | CPP_ANDROID_ABI          |
    # |---------------------------|----------------------|
    # |arm64-android              | arm64-v8a            |
    # |arm-android                | armeabi-v7a          |
    # |x64-android                | x86_64               |
    # |x86-android                | x86                  |
    #
    # The variable must be stored in the cache in order to successfully the two toolchains. 
    #
    message("\nParse '" ${ANDROID_PLATFORM} "' to extract android api level")
	if (ANDROID_PLATFORM MATCHES "(.*)-(.*)")
		message("Platform name: " ${CMAKE_MATCH_1})
		set(CPP_ANDROID_API ${CMAKE_MATCH_2})
		message("Api level:     " ${CPP_ANDROID_API})
	else()
		message(FATAL_ERROR "Platform format error ('android-apilevel' such as android-30)")
	endif()
	
    if (${CPP_ANDROID_ABI} MATCHES "arm64-v8a")
	    string(CONCAT CPP_VCPKG_TARGET_TRIPLET "arm64-android-" ${CPP_ANDROID_API})
        set(VCPKG_TARGET_TRIPLET ${CPP_VCPKG_TARGET_TRIPLET} CACHE STRING "" FORCE)
    elseif(${CPP_ANDROID_ABI} MATCHES "armeabi-v7a")
	    string(CONCAT CPP_VCPKG_TARGET_TRIPLET "arm-android-" ${CPP_ANDROID_API})
        set(VCPKG_TARGET_TRIPLET ${CPP_VCPKG_TARGET_TRIPLET} CACHE STRING "" FORCE)
    elseif(${CPP_ANDROID_ABI} MATCHES "x86_64")
	    string(CONCAT CPP_VCPKG_TARGET_TRIPLET "x64-android-" ${CPP_ANDROID_API})
        set(VCPKG_TARGET_TRIPLET ${CPP_VCPKG_TARGET_TRIPLET} CACHE STRING "" FORCE)
    elseif(${CPP_ANDROID_ABI} MATCHES "x86")
	    string(CONCAT CPP_VCPKG_TARGET_TRIPLET "x86-android-" ${CPP_ANDROID_API})
        set(VCPKG_TARGET_TRIPLET ${CPP_VCPKG_TARGET_TRIPLET} CACHE STRING "" FORCE)
    else()
        message(FATAL_ERROR "
        Please specify CPP_ANDROID_ABI
        For example
        cmake ... -DCPP_ANDROID_ABI=armeabi-v7a

        Possible ABIs are: arm64-v8a, armeabi-v7a, x64-android, x86-android
        ")
    endif()
	
	# -DCMAKE_INSTALL_PREFIX=%CPP_ANDROID_REPO%/%CPP_PRJ% -DCMAKE_TOOLCHAIN_FILE=C:/pro/vcpkg/scripts/buildsystems/vcpkg.cmake -DVCPKG_CHAINLOAD_TOOLCHAIN_FILE=%ANDROID_NDK_HOME%/build/cmake/android.toolchain.cmake -GNinja -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DCMAKE_BUILD_TYPE=%CPP_TYPE% -DCMAKE_LIBRARY_OUTPUT_DIRECTORY=lib/%CPP_ANDROID_ABI%/%CPP_TYPE% -DCMAKE_ARCHIVE_OUTPUT_DIRECTORY=lib/%CPP_ANDROID_ABI%/%CPP_TYPE% -DCMAKE_RUNTIME_OUTPUT_DIRECTORY=bin/%CPP_ANDROID_ABI%/%CPP_TYPE% -DCMAKE_DEBUG_POSTFIX=_d -DVCPKG_OVERLAY_PORTS=C:/pro/github/onbings-vcpkg-registry/ports C:\pro\github\vcpkg-packaging-env
#cmake -DANDROID_PLATFORM=android-30 -DCPP_ANDROID_PRJ=%1 -DCPP_ANDROID_ABI=x86_64 -DANDROID_NDK_HOME=C:\Android\Sdk\ndk\25.1.8937393 -DVCPKG_ROOT=C:\pro\vcpkg -DCPP_ANDROID_REPO_BLD_ROOT=C:\Android -Wno-dev -DCMAKE_FIND_DEBUG_MODE=OFF -DCMAKE_INSTALL_PREFIX=%CPP_ANDROID_REPO%/%CPP_PRJ% -GNinja -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DCMAKE_BUILD_TYPE=%CPP_TYPE%

	string(CONCAT THEPATH "lib/" ${CPP_ANDROID_ABI} "/" ${CMAKE_BUILD_TYPE})
	set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${THEPATH})
	string(CONCAT THEPATH "lib/" ${CPP_ANDROID_ABI} "/" ${CMAKE_BUILD_TYPE})
	set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${THEPATH})
	string(CONCAT THEPATH "bin/" ${CPP_ANDROID_ABI} "/" ${CMAKE_BUILD_TYPE})
	set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${THEPATH})
	string(CONCAT THEPATH ${VCPKG_ROOT} "/scripts/buildsystems/vcpkg.cmake")
	set(CMAKE_TOOLCHAIN_FILE ${THEPATH})
	string(CONCAT THEPATH ${ANDROID_NDK_HOME} "/build/cmake/android.toolchain.cmake")
	set(VCPKG_CHAINLOAD_TOOLCHAIN_FILE ${THEPATH})
	
    message("\n==vcpkg_android.cmake==OUTPUT VAR:")
	message("==vcpkg_android.cmake==VCPKG_TARGET_TRIPLET===========> " ${CPP_VCPKG_TARGET_TRIPLET})
	message("==vcpkg_android.cmake==CMAKE_LIBRARY_OUTPUT_DIRECTORY=> " ${CMAKE_LIBRARY_OUTPUT_DIRECTORY})
	message("==vcpkg_android.cmake==CMAKE_ARCHIVE_OUTPUT_DIRECTORY=> " ${CMAKE_ARCHIVE_OUTPUT_DIRECTORY})
	message("==vcpkg_android.cmake==CMAKE_RUNTIME_OUTPUT_DIRECTORY=> " ${CMAKE_RUNTIME_OUTPUT_DIRECTORY})
	message("==vcpkg_android.cmake==CMAKE_TOOLCHAIN_FILE===========> " ${CMAKE_TOOLCHAIN_FILE})
	message("==vcpkg_android.cmake==VCPKG_CHAINLOAD_TOOLCHAIN_FILE=> " ${VCPKG_CHAINLOAD_TOOLCHAIN_FILE})
	
	
	message("==vcpkg_android.cmake==ANDROID_PLATFORM===============> " ${ANDROID_PLATFORM})
message("==vcpkg_android.cmake==CPP_ANDROID_PRJ================> " ${CPP_ANDROID_PRJ})
message("==vcpkg_android.cmake==CPP_ANDROID_ABI================> " ${CPP_ANDROID_ABI})
message("==vcpkg_android.cmake==ANDROID_NDK_HOME===============> " ${ANDROID_NDK_HOME})
message("==vcpkg_android.cmake==VCPKG_ROOT=====================> " ${VCPKG_ROOT})
message("==vcpkg_android.cmake==CPP_ANDROID_REPO_BLD_ROOT======> " ${CPP_ANDROID_REPO_BLD_ROOT})
message("==vcpkg_android.cmake==CMAKE_BUILD_TYPE===============> " ${CMAKE_BUILD_TYPE})
message("==vcpkg_android.cmake==VCPKG_OVERLAY_PORTS============> " ${VCPKG_OVERLAY_PORTS})



        set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_LIBRARY_OUTPUT_DIRECTORY} CACHE STRING "" FORCE)
        set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_ARCHIVE_OUTPUT_DIRECTORY} CACHE STRING "" FORCE)
        set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_RUNTIME_OUTPUT_DIRECTORY} CACHE STRING "" FORCE)
        set(CMAKE_TOOLCHAIN_FILE ${CMAKE_TOOLCHAIN_FILE} CACHE STRING "" FORCE)
        set(VCPKG_CHAINLOAD_TOOLCHAIN_FILE ${VCPKG_CHAINLOAD_TOOLCHAIN_FILE} CACHE STRING "" FORCE)
        set(ANDROID_PLATFORM ${ANDROID_PLATFORM} CACHE STRING "" FORCE)
        set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_LIBRARY_OUTPUT_DIRECTORY} CACHE STRING "" FORCE)

else()
    message(FATAL_ERROR "Incoherent behavior !")
endif()

