require 'mkmf'

LIBDIR      = RbConfig::CONFIG['libdir']
INCLUDEDIR  = RbConfig::CONFIG['includedir']

HEADER_DIRS = [INCLUDEDIR]

LIB_DIRS = [LIBDIR]

dir_config('.', HEADER_DIRS, LIB_DIRS)

create_makefile('./cron')
