#If you want to try an use the terminally buggy ROOT CMake scripts
find_package(
    ROOT
    REQUIRED COMPONENTS
    Geom Physics Matrix MathCore Tree RIO Minuit
    OPTIONAL_COMPONENTS
    Minuit2
)

if(ROOT_FOUND)
  cmessage(STATUS "[ROOT]: ROOT found")
  include(${ROOT_USE_FILE})
  cmessage(STATUS "[ROOT]: ROOT package found ${ROOT_LIBRARIES}")
  if (NOT ROOT_minuit2_FOUND)
    # Minuit2 wasn't found, but make really sure before giving up.
    execute_process (COMMAND root-config --has-minuit2
        OUTPUT_VARIABLE ROOT_minuit2_FOUND
        OUTPUT_STRIP_TRAILING_WHITESPACE)
  endif(NOT ROOT_minuit2_FOUND)

  # inc dir is $ROOTSYS/include/root
  set(CMAKE_ROOTSYS ${ROOT_INCLUDE_DIRS}/../../)

else(ROOT_FOUND)
  cmessage(STATUS "find_package didn't find ROOT. Using shell instead...")

  # ROOT
  if(NOT DEFINED ENV{ROOTSYS} )
    cmessage(FATAL_ERROR "$ROOTSYS is not defined, please set up root first.")
  else()
    cmessage(STATUS "Using ROOT installed at $ENV{ROOTSYS}")
    set(CMAKE_ROOTSYS $ENV{ROOTSYS})
  endif()

  cmessage(STATUS "Including local GENERATE_ROOT_DICTIONARY implementation.")
  include(${CMAKE_SOURCE_DIR}/cmake/GenROOTDictionary.cmake)
  execute_process(COMMAND root-config --cflags
      OUTPUT_VARIABLE ROOT_CXX_FLAGS
      OUTPUT_STRIP_TRAILING_WHITESPACE)
  execute_process(COMMAND root-config --libs
      OUTPUT_VARIABLE ROOT_LIBRARIES
      OUTPUT_STRIP_TRAILING_WHITESPACE)
  execute_process(COMMAND root-config --version
      OUTPUT_VARIABLE ROOT_VERSION
      OUTPUT_STRIP_TRAILING_WHITESPACE)
  execute_process (COMMAND root-config --ldflags
      OUTPUT_VARIABLE ROOT_LINK_FLAGS
      OUTPUT_STRIP_TRAILING_WHITESPACE)
  execute_process (COMMAND root-config --has-minuit2
      OUTPUT_VARIABLE ROOT_minuit2_FOUND
      OUTPUT_STRIP_TRAILING_WHITESPACE)

  cmessage(STATUS "[ROOT]: root-config --version: ${ROOT_VERSION}")
  cmessage(STATUS "[ROOT]: root-config --libs: ${ROOT_LIBRARIES}")
  cmessage(STATUS "[ROOT]: root-config --cflags: ${ROOT_CXX_FLAGS}")
  cmessage(STATUS "[ROOT]: root-config --ldflags: ${ROOT_LINK_FLAGS}")

  add_compile_options("SHELL:${ROOT_CXX_FLAGS}")
  add_link_options("SHELL:${ROOT_LINK_FLAGS}")

endif(ROOT_FOUND)

if (NOT ROOT_minuit2_FOUND)
  cmessage(STATUS "[ROOT]:Rebuild root using -Dminuit2=on in the cmake command")
  cmessage(FATAL_ERROR "[ROOT]: minuit2 is required")
endif(NOT ROOT_minuit2_FOUND)
