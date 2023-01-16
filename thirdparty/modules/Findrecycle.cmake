# we're "building" recycle as part of tcp_pubsub so it will always be found.
# set(recycle_FOUND True)
find_path(recycle_INCLUDE_DIR
  NAMES shared_pool.hpp
  HINTS
    "${CMAKE_CURRENT_LIST_DIR}/../recycle/recycle/include"
  NO_DEFAULT_PATH
  NO_CMAKE_FIND_ROOT_PATH
)

if(recycle_INCLUDE_DIR-NOTFOUND)
  message(FATAL_ERROR "Could not find recycle library")
  set(recycle_FOUND FALSE)
else()
  set(recycle_FOUND TRUE)
  set(RECYCLE_INCLUDE_DIR ${recycle_INCLUDE_DIR})
endif()

if(recycle_FOUND)
  include(FindPackageHandleStandardArgs)
  find_package_handle_standard_args(recycle
    REQUIRED_VARS recycle_INCLUDE_DIR)

  if(NOT TARGET steinwurf::recycle)
    set(recycle_INCLUDE_DIRS ${recycle_INCLUDE_DIR})
    add_library(steinwurf::recycle INTERFACE IMPORTED)
    set_target_properties(steinwurf::recycle PROPERTIES
      INTERFACE_INCLUDE_DIRECTORIES ${recycle_INCLUDE_DIR}
      INTERFACE_COMPILE_DEFINITIONS RECYCLE_STANDALONE)
    mark_as_advanced(recycle_INCLUDE_DIR)
  endif()
endif()
