#===================================================================
# This file check if the user specified a configuration build type
# If not, then it defaults the build type to Release
#===================================================================

if(NOT SET_UP_CONFIGURATIONS_DONE)

  set(SET_UP_CONFIGURATIONS_DONE TRUE)

  # No reason to set CMAKE_CONFIGURATION_TYPES if it's not a multiconfig generator
  # Also no reason mess with CMAKE_BUILD_TYPE if it's a multiconfig generator.

  # Behaviour should be different depending this is multiconfig generator or not
  get_property(isMultiConfig GLOBAL PROPERTY GENERATOR_IS_MULTI_CONFIG)

  if(isMultiConfig)
    set(CMAKE_CONFIGURATION_TYPES "Debug;Release" CACHE STRING "" FORCE)
  else()

    # User did not specified the build type
    if(NOT CMAKE_BUILD_TYPE)
      set(CMAKE_BUILD_TYPE Release CACHE STRING "" FORCE)
    endif()

    # If someone is using a GUI to configure, set the valid options for cmake-gui drop-down list
    set_property(CACHE CMAKE_BUILD_TYPE PROPERTY HELPSTRING "Choose the type of build")
    set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS "Debug;Release")
  endif()
endif()
