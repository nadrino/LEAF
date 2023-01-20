cmake_minimum_required (VERSION 3.12 FATAL_ERROR)

project(LEAF)


option(USE_STATIC_LINKS "Library build in static mod" OFF)

# Colored messages
include(${CMAKE_SOURCE_DIR}/cmake/cmessage.cmake)
include(${CMAKE_SOURCE_DIR}/cmake/depROOT.cmake)
include(${CMAKE_SOURCE_DIR}/cmake/depWCSim.cmake)


add_subdirectory( ${CMAKE_SOURCE_DIR}/leaf/DataModel-lite )
add_subdirectory( ${CMAKE_SOURCE_DIR}/leaf )
add_subdirectory( ${CMAKE_SOURCE_DIR}/example )




