cmake_minimum_required(VERSION 3.9)

if(${CMAKE_SOURCE_DIR} STREQUAL ${CMAKE_BINARY_DIR})
    message(FATAL_ERROR "In-source-tree build forbidden.")
endif()

PROJECT(___project_name___)
SET(VERSION 1.0)

if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Debug)
endif()

set( CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin )
set( CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib )

set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set( CMAKE_CXX_FLAGS "-Wall" )

find_package(Threads REQUIRED)

include(ProcessorCount)
ProcessorCount(PROCESSOR_COUNT)
if ( PROCESSOR_COUNT EQUAL 0 )
  set(PROCESSOR_COUNT 1)
endif()

message("-- Using ${PROCESSOR_COUNT} cpu(s) during configuration")

set(ARGS_DEPS_DIR ${PROJECT_SOURCE_DIR}/deps/args)
configure_file(cmake/args.in ${ARGS_DEPS_DIR}/CMakeLists.txt)
execute_process(COMMAND ${CMAKE_COMMAND} -G "${CMAKE_GENERATOR}" . WORKING_DIRECTORY ${ARGS_DEPS_DIR})
execute_process(COMMAND ${CMAKE_COMMAND} --build . WORKING_DIRECTORY ${ARGS_DEPS_DIR})
include_directories(3rdparty/args/include)

set( SOURCES
    src/main.cpp
)

add_executable( ___project_name___ ${SOURCES} )

target_link_libraries(
   ___project_name___
   PRIVATE Threads::Threads
)
