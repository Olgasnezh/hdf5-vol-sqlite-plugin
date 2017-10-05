cmake_minimum_required (VERSION 3.0)


set(PROJECT_NAME hdf5-vol-sqlite-plugin)
project (${PROJECT_NAME})

find_package (sqlite3 REQUIRED)
find_package(HDF5 REQUIRED)
find_package(MPI REQUIRED)


set(CMAKE_REQUIRED_INCLUDES ${HDF5_INCLUDE_DIR} ${MPI_INCLUDE_PATH} ${SQLITE3_INCLUDE_DIRS})
set(CMAKE_REQUIRED_LIBRARIES ${HDF5_LIBRARIES} ${MPI_LIBRARIES} ${SQLITE3_LIBRARIES})


target_link_libraries(hdf5-vol-sqlite-plugin ${HDF5_LIBRARIES} ${SQLITE3_LIBRARIES})
link_directories(hdf5-vol-sqlite-plugin ${HDF5_LIBRARY_DIRS} ${MPI_LIBRARIES})
include_directories(${CMAKE_SOURCE_DIR}/src ${HDF5_INCLUDE_DIR} ${MPI_INCLUDE_PATH} ${SQLITE3_INCLUDE_DIRS})

