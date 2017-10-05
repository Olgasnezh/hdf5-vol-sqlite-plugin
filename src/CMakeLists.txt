add_library(hdf5-vol-sqlite-plugin SHARED h5_sqlite_plugin.c db_sqlite.c base)

target_link_libraries(hdf5-vol-sqlite-plugin ${HDF5_LIBRARIES} ${SQLITE3_LIBRARIES})
link_directories(hdf5-vol-sqlite-plugin ${HDF5_LIBRARY_DIRS} ${MPI_LIBRARIES} ${SQLITE3_LIBRARIES_DIRS})
include_directories(${CMAKE_SOURCE_DIR}/src ${HDF5_INCLUDE_DIR} ${MPI_INCLUDE_PATH} ${SQLITE3_INCLUDE_DIRS})

add_definitions(-D_LARGEFILE64_SOURCE)

