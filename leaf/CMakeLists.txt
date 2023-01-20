

if( USE_STATIC_LINKS )
  add_library(LEAF STATIC ${CMAKE_CURRENT_SOURCE_DIR}/LEAF.cc)
  add_library(HKManager STATIC ${CMAKE_CURRENT_SOURCE_DIR}/HKManager.cc)
else()
  add_library(LEAF SHARED ${CMAKE_CURRENT_SOURCE_DIR}/LEAF.cc)
  add_library(HKManager SHARED ${CMAKE_CURRENT_SOURCE_DIR}/HKManager.cc)
endif()


target_include_directories( LEAF PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR} ${CMAKE_CURRENT_SOURCE_DIR}/DataModel-lite
)
target_include_directories( HKManager PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR} ${CMAKE_CURRENT_SOURCE_DIR}/DataModel-lite
)

target_link_libraries( LEAF
    WCSimRoot DataModelLite ${ROOT_LIBRARIES}
)
target_link_libraries( HKManager
    WCSimRoot DataModelLite
)

install(TARGETS LEAF DESTINATION lib)
install(TARGETS HKManager DESTINATION lib)
