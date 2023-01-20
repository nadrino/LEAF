
if( NOT DEFINED ENV{WCSIM_DIR} )
  cmessage(WARNING "$WCSIM_DIR not set. LEAF won't compile without WCSim lib.")
  return()
endif()

cmessage(STATUS "Using WCSIM_DIR in $ENV{WCSIM_DIR}")

set( WCSIM_DIR $ENV{WCSIM_DIR} )
set( WCSIM_INCLUDE_DIR ${WCSIM_DIR}/include )

include_directories( ${WCSIM_INCLUDE_DIR} )

add_library( WCSimRoot SHARED IMPORTED )

if( APPLE )
  set( WCSIMROOT_LIB_FILE ${WCSIM_DIR}/libWCSimRoot.dylib )
elseif( UNIX )
  set( WCSIMROOT_LIB_FILE ${WCSIM_DIR}/libWCSimRoot.so )
endif()

set_target_properties( WCSimRoot PROPERTIES IMPORTED_LOCATION ${WCSIMROOT_LIB_FILE} )

install( FILES ${WCSIMROOT_LIB_FILE} DESTINATION lib )

