# Introduction

This repository sets up a vcpkg overlay for testing or creating new vcpkg ports. 

This allows to test your package before submission to the [onbings vcpkg registry](https://...).

# Build options

- ``VCPKG_INSTALL_DIR`` - Specify vcpkg's installation directory. Default is **/opt/onbings/vcpkg**.

# Adding a new port

1. Create a directory for the new package in [vcpkg/ports](vcpkg/ports)
2. Add those two files (feel free to start from an existing vcpkg port, e.g. from our registry)
    - vcpkg.json: this file describe your package (name, description, version, dependencies)
    - portfile.cmake: this file contains the recipe for building your package.
3. Add the package to [vcpkg.json](vcpkg.json)
4. Add a find_package in [CMakeLists.txt](CMakeLists.txt)
5. Link the main target with the package you want to test
6. When the package is ready, submit it to the [onbings-vcpkg-registry](https://...)
