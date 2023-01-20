

add_executable( leafAnalysis analysis.cpp )

target_link_libraries( leafAnalysis
    LEAF WCSimRoot HKManager ${ROOT_LIBRARIES}
)

install( TARGETS leafAnalysis DESTINATION bin )
