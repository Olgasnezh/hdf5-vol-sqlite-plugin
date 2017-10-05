cmake_minimum_required (VERSION 3.0)


set(PROJECT_NAME hdf5-vol-sqlite-plugin)
project (${PROJECT_NAME})


find_package(HDF5 REQUIRED)
find_package(MPI REQUIRED)


#find_package(PkgConfig REQUIRED)
#pkg_search_module(SDL2 REQUIRED sdl2)
#...
#target_link_libraries(testapp ${SDL2_LIBRARIES})
#target_include_directories(testapp PUBLIC ${SDL2_INCLUDE_DIRS})
#target_compile_options(testapp PUBLIC ${SDL2_CFLAGS_OTHER})

find_package (PkgConfig REQUIRED)
pkg_search_module(SQLITE3 REQUIRED sqlite3)


set(CMAKE_REQUIRED_INCLUDES ${HDF5_INCLUDE_DIR} ${MPI_INCLUDE_PATH} ${SQLITE3_INCLUDE_DIRS})
set(CMAKE_REQUIRED_LIBRARIES ${HDF5_LIBRARIES} ${MPI_LIBRARIES} ${SQLITE3_LIBRARIES})


add_subdirectory(src)
