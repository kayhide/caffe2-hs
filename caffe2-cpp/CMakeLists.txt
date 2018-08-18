cmake_minimum_required(VERSION 3.5 FATAL_ERROR)

project (caffe2-wrapper)

set(CMAKE_INSTALL_PREFIX "${PROJECT_SOURCE_DIR}/../.libs")
set(CMAKE_CXX_STANDARD 11)

list(APPEND CMAKE_PREFIX_PATH ${CMAKE_CURRENT_SOURCE_DIR}/../extlib/pytorch/build/install)

include_directories(cpp)
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/../extlib/pytorch/build/install/include)

find_library(CAFFE2_LIB caffe2)

if(NOT CAFFE2_LIB)
  message(FATAL_ERROR "Caffe2 lib not found")
endif()

set(ALL_LIBRARIES)

macro(link_whole_archive lib)
  if("${CMAKE_CXX_COMPILER_ID}" MATCHES "Clang")
    list(APPEND ALL_LIBRARIES -Wl,-force_load,$<TARGET_FILE_NAME:${lib}> ${lib})
  elseif(MSVC)
    list(APPEND ALL_LIBRARIES -WHOLEARCHIVE:$<TARGET_FILE_NAME:${lib}>)
  else()
    list(APPEND ALL_LIBRARIES -Wl,--whole-archive ${lib} -Wl,--no-whole-archive)
  endif()
endmacro()

file(GLOB LIB_SOURCES "${PROJECT_SOURCE_DIR}/cpp/*.cpp")
add_library(caffe2-wrapper SHARED ${LIB_SOURCES})
link_whole_archive(caffe2-wrapper)
list(APPEND ALL_LIBRARIES ${CAFFE2_LIB})

target_link_libraries(caffe2-wrapper PRIVATE ${CAFFE2_LIB})

install(
  TARGETS caffe2-wrapper
  EXPORT Caffe2WrapperTargets
  LIBRARY DESTINATION lib
)
                
