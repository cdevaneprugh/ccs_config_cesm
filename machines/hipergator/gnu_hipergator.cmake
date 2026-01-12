# Compiler settings for HiPerGator with GNU compiler

# In netcdf-c 4.9.3, _FillValue was changed to NC_FillValue to follow best practices.
# This line ensures legacy support for code that uses netcdf-c and the original convention.
string(APPEND CPPDEFS " -DNETCDF_ENABLE_LEGACY_MACROS")

# Link netcdf and lapack libraries
# Execute nf-config and store output as a variable
execute_process(COMMAND ${NETCDF_FORTRAN_PATH}/bin/nf-config --flibs OUTPUT_VARIABLE SHELL_CMD_OUTPUT_BUILD_INTERNAL_IGNORE0 OUTPUT_STRIP_TRAILING_WHITESPACE)

string(APPEND SLIBS " ${SHELL_CMD_OUTPUT_BUILD_INTERNAL_IGNORE0}")
string(APPEND SLIBS " -L$(LAPACK_LIBDIR) -llapack -lblas")

# Tell ParallelIO to optimize build for Lustre file system
set(PIO_FILESYSTEM_HINTS "lustre")
