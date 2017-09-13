#!/bin/bash

#. /sw/rhel6-x64/tcl/modules-3.2.10/Modules/3.2.10/init/zsh 

#setopt SH_WORD_SPLIT

set -x
HOSTNAME=$(hostname)
set +x

if [ $HOSTNAME == "cluster" ]; then
	module purge
	module load gcc/7.2.0-gcc-5.4.0-ayc2n4l
	module load mvapich2/2.2-gcc-7.2.0-a4dgntt   
	module load sqlite/3.20.0-gcc-7.2.0-2hfgvlg
	module load betke/hdf5-vol/svn-20170912
	module load betke/netcdf/4.4.1-vol-sqlite
	module list
elif [ $HOSTNAME == "mistral"]; then
	module purge
	module load intel/17.0.1
	module load fca/2.5.2431
	module load mxm/3.4.3082
	module load bullxmpi_mlx_mt/bullxmpi_mlx_mt-1.2.9.2
	module load betke/hdf5-vol
	module load betke/sqlite3
	module list
else
	exit 1
fi 


SQLITEDIR="$(readlink -f $(dirname $(which sqlite3))/..)"
MPIPWD="$(readlink -f $(dirname $(which mpiexec))/..)"
ROOTDIR="${PWD}/.."
H5DIR="$(readlink -f $(dirname $(which h5dump)))/.."

CC="$(which mpicc)"

LDFLAGS=" \
	-L${ROOTDIR}/hdf5-vol-install/lib \
	-lhdf5 \
	-Wl,-rpath=$SQLITEDIR/lib \
	$(pkg-config --libs sqlite3)"

	#-g3 -DDEBUG -DTRACE \
CFLAGS=" \
	-std=gnu11 \
	-D_LARGEFILE64_SOURCE \
	-I${H5DIR}/include \
	-I${MPIPWD}/include \
	-I${ROOTDIR}/ext_plugin \
	$(pkg-config --cflags sqlite3)"


[ ! -d shared ] && mkdir -p shared
[ ! -d multifile ] && mkdir -p multifile

set -x
$CC $CFLAGS $LDFLAGS -shared -fpic -o shared/libh5-sqlite-plugin.so  h5_sqlite_plugin.c db_sqlite.c base.c
$CC $CFLAGS $LDFLAGS -shared -fpic -DMULTIFILE -o multifile/libh5-sqlite-plugin.so  h5_sqlite_plugin.c db_sqlite.c base.c
set +x
