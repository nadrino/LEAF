
file( GLOB SRC_FILES
    ${CMAKE_CURRENT_SOURCE_DIR}/*.cpp
    )

if( USE_STATIC_LINKS )
  add_library(DataModelLite STATIC ${SRC_FILES})
else()
  add_library(DataModelLite SHARED ${SRC_FILES})
endif()

target_include_directories( DataModelLite PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}
)

target_link_libraries( DataModelLite
    ${ROOT_LIBRARIES}
)

install( TARGETS DataModelLite DESTINATION lib )

