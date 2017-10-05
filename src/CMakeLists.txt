project (${PROJECT_NAME})
add_definitions(-DMULTIFILE)
set(SOURCE h5_sqlite_plugin.c db_sqlite.c base.c)
add_executable(run ${SOURCE})
