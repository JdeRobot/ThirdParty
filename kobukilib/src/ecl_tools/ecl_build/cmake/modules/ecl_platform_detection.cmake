###############################################################################
# Platform Detection
###############################################################################

#ifdef DOXYGEN_SHOULD_SKIP_THIS

###############################
# Distro
###############################
# Checks the linux distro and 
# sets the following variables
#
# - DISTRO_NAME
# - DISTRO_VERSION
# - DISTRO_VERSION_STRING
#
# If no recognised distro is found, it will 
# return each variable with a -UNKNOWN appended 
# (e.g. DISTRO_NAME = DISTRO_NAME-UNKNOWN)
# 
macro(ecl_detect_distro)
    if(EXISTS "/etc/issue")
        file(READ "/etc/issue" ETC_ISSUE)
        string(REGEX MATCH "9.10" DISTRO_KARMIC ${ETC_ISSUE})
        string(REGEX MATCH "10.04" DISTRO_LUCID ${ETC_ISSUE})
        string(REGEX MATCH "10.10" DISTRO_MAVERICK ${ETC_ISSUE})
        string(REGEX MATCH "11.04" DISTRO_NATTY ${ETC_ISSUE})
        string(REGEX MATCH "11.10" DISTRO_ONEIRIC ${ETC_ISSUE})
        string(REGEX MATCH "12.04" DISTRO_PRECISE ${ETC_ISSUE})
        string(REGEX MATCH "12.10" DISTRO_QUANTAL ${ETC_ISSUE})
    endif()
    if(DISTRO_KARMIC)
        set(DISTRO_NAME "Ubuntu")
        set(DISTRO_VERSION "9.10")
        set(DISTRO_VERSION_STRING "karmic")
    elseif(DISTRO_LUCID)
        set(DISTRO_NAME "Ubuntu")
        set(DISTRO_VERSION "10.04")
        set(DISTRO_VERSION_STRING "lucid")
    elseif(DISTRO_MAVERICK)
        set(DISTRO_NAME "Ubuntu")
        set(DISTRO_VERSION "10.10")
        set(DISTRO_VERSION_STRING "maverick")
    elseif(DISTRO_NATTY)
        set(DISTRO_NAME "Ubuntu")
        set(DISTRO_VERSION "11.04")
        set(DISTRO_VERSION_STRING "natty")
    elseif(DISTRO_ONEIRIC)
        set(DISTRO_NAME "Ubuntu")
        set(DISTRO_VERSION "11.10")
        set(DISTRO_VERSION_STRING "oneiric")
    elseif(DISTRO_PRECISE)
        set(DISTRO_NAME "Ubuntu")
        set(DISTRO_VERSION "12.04")
        set(DISTRO_VERSION_STRING "precise")
    elseif(DISTRO_QUANTAL)
        set(DISTRO_NAME "Ubuntu")
        set(DISTRO_VERSION "12.10")
        set(DISTRO_VERSION_STRING "quantal")
    else()
        set(DISTRO_NAME DISTRO_NAME-UNKNOWN)
        set(DISTRO_VERSION DISTRO_VERSION-UNKNOWN)
        set(DISTRO_VERSION_STRING DISTRO_VERSION_STRING-UNKNOWN)
    endif()
endmacro()

###############################
# Detect Posix
###############################
# This is as yet quite incomplete, but it suffices for what the 
# ecl currrently does. If it detects posix, it sets
# 
#  - PLATFORM_IS_POSIX
#
# It also configures the following variables to true
# for public consumption if found (these are close to equivalent
# to their c macro counterparts):
#
#  - ECL_POSIX_HAS_CLOCK_GETTIME
#  - ECL_POSIX_HAS_CLOCK_MONOTONIC
#  - ECL_POSIX_HAS_CLOCK_NANOSLEEP
#  - ECL_POSIX_HAS_CLOCK_SELECTION
#  - ECL_POSIX_HAS_NANOSLEEP
#  - ECL_POSIX_HAS_TIMERS
#  - ECL_POSIX_HAS_PRIORITY_SCHEDULING
#  - ECL_POSIX_HAS_TIMEOUTS
#  - ECL_POSIX_HAS_SEMAPHORES
#  - ECL_POSIX_HAS_SHARED_MEMORY_OBJECTS
#  - ECL_POSIX_HAS_CPUTIME
#
macro(ecl_detect_posix)

    # Need some standard cmake modules
    include(CheckSymbolExists)
    include(CheckLibraryExists)

    check_symbol_exists(_POSIX_VERSION unistd.h PLATFORM_IS_POSIX)

    if(PLATFORM_IS_POSIX)
        check_library_exists(rt clock_nanosleep "" POSIX_HAS_CLOCK_NANOSLEEP)
        check_library_exists(rt clock_gettime "" POSIX_HAS_CLOCK_GETTIME)
        check_library_exists(pthread pthread_mutex_timedlock "" POSIX_HAS_MUTEX_TIMEDLOCK)
        check_library_exists(pthread nanosleep "" POSIX_HAS_NANOSLEEP)
        check_library_exists(rt shm_open "" POSIX_HAS_SHM_OPEN)
        check_library_exists(pthread sched_setscheduler "" POSIX_HAS_SCHED_SETSCHEDULER)
        check_library_exists(pthread sem_timedwait "" POSIX_HAS_SEM_TIMEDWAIT)
        check_library_exists(pthread sem_init "" POSIX_HAS_SEM_INIT)
        check_symbol_exists(CLOCK_MONOTONIC time.h POSIX_HAS_CLOCK_MONOTONIC)
        check_symbol_exists(CLOCK_PROCESS_CPUTIME_ID time.h POSIX_HAS_CPUTIME)
    endif()
    
    if(POSIX_HAS_CLOCK_GETTIME)
        set(ECL_POSIX_HAS_CLOCK_GETTIME TRUE CACHE BOOL "platform has posix clock_gettime.")
        set(ECL_POSIX_HAS_CLOCK_MONOTONIC TRUE CACHE BOOL "platform has posix monotonic clock.")
    endif()
    if(POSIX_HAS_CLOCK_NANOSLEEP)
        set(ECL_POSIX_HAS_CLOCK_NANOSLEEP TRUE CACHE BOOL "platform has posix nanosleep clock.")
        set(ECL_POSIX_HAS_CLOCK_SELECTION TRUE CACHE BOOL "platform has posix clock selection.")
    endif()
    if(POSIX_HAS_NANOSLEEP)
        set(ECL_POSIX_HAS_NANOSLEEP TRUE CACHE BOOL "platform has posix nanosleep.")
        set(ECL_POSIX_HAS_TIMERS TRUE CACHE BOOL "platform has posix timers.")
    endif()
    if(POSIX_HAS_SCHED_SETSCHEDULER)
        set(ECL_POSIX_HAS_PRIORITY_SCHEDULING TRUE CACHE BOOL "platform has posix priority scheduling.")
    endif()
    if(POSIX_HAS_SEM_TIMEDWAIT AND POSIX_HAS_MUTEX_TIMEDLOCK)
        set(ECL_POSIX_HAS_TIMEOUTS TRUE CACHE BOOL "platform has posix timed wait and timed locks.")
    endif()
    if(POSIX_HAS_SEM_INIT)
        set(ECL_POSIX_HAS_SEMAPHORES TRUE CACHE BOOL "platform has posix semaphores.")
    endif()
    if(POSIX_HAS_SHM_OPEN)
        set(ECL_POSIX_HAS_SHARED_MEMORY_OBJECTS TRUE CACHE BOOL "platform has posix shared memory.")
    endif()
    if(POSIX_HAS_CPUTIME)
        set(ECL_POSIX_HAS_CPUTIME TRUE CACHE BOOL "platform has posix cpu time.")
    endif()
  mark_as_advanced(
    ECL_POSIX_HAS_CLOCK_GETTIME
    ECL_POSIX_HAS_CLOCK_MONOTONIC
    ECL_POSIX_HAS_CLOCK_NANOSLEEP
    ECL_POSIX_HAS_CLOCK_SELECTION
    ECL_POSIX_HAS_NANOSLEEP
    ECL_POSIX_HAS_TIMERS
    ECL_POSIX_HAS_PRIORITY_SCHEDULING
    ECL_POSIX_HAS_TIMEOUTS
    ECL_POSIX_HAS_SEMAPHORES
    ECL_POSIX_HAS_SHARED_MEMORY_OBJECTS
    ECL_POSIX_HAS_CPUTIME
  )
endmacro()

###############################
# Detect Threads
###############################
# If present, sets the variables to true
#
#  - ECL_PLATFORM_HAS_POSIX_THREADS
#  - ECL_PLATFORM_HAS_WIN32_THREADS
#
macro(ecl_detect_threads)
  if(DEFINED ECL_PLATFORM_HAS_POSIX_THREADS OR ECL_PLATFORM_HAS_WIN32_THREADS)
    # Do nothing
  else() 
    include(FindThreads)
    if(CMAKE_USE_PTHREADS_INIT) 
      set(ECL_PLATFORM_HAS_POSIX_THREADS TRUE CACHE BOOL "platform has posix threads.")
    elseif(CMAKE_USE_WIN32_THREADS_INIT)
      set(ECL_PLATFORM_HAS_WIN32_THREADS TRUE CACHE BOOL "platform has win32 threads.")
    endif(CMAKE_USE_PTHREADS_INIT)
  endif()
endmacro()

###############################
# Detect Timers
###############################
# This is very rough, if the right env found, sets the variables to TRUE
# 
#  - ECL_PLATFORM_HAS_WIN_TIMERS
#  - ECL_PLATFORM_HAS_MACH_TIMERS
#  - ECL_PLATFORM_HAS_RT_TIMERS
#  - ECL_PLATFORM_HAS_POSIX_TIMERS
# 
# and also sets the appropriate library variable(s) in:
#
#  - ECL_PLATFORM_TIME_LIBRARIES
#
macro(ecl_detect_timers)
  if(DEFINED ECL_PLATFORM_TIME_LIBRARIES)
    # Do nothing
  else() 
    ecl_detect_posix()
    ecl_detect_threads()
    # Note cache variables (ECL_PLATFORM_TIME_LIBRARIES) are read in only, can't modify them
    # once set. Try set_property(GLOBAL...if you want to do that).
    if(WIN32)
      set(ECL_PLATFORM_TIME_LIBRARIES "" CACHE STRING "platform time libraries")
      set(ECL_PLATFORM_HAS_WIN_TIMERS TRUE CACHE BOOL "platform has win32 timers.")
    elseif(APPLE)
      set(ECL_PLATFORM_TIME_LIBRARIES "" CACHE STRING "platform time libraries")
      set(ECL_PLATFORM_HAS_MACH_TIMERS TRUE CACHE BOOL "platform has apple mach timers.")
    elseif(ECL_POSIX_HAS_CLOCK_GETTIME AND ECL_POSIX_HAS_CLOCK_NANOSLEEP) # Found by ecl_detect_posix 
      set(ECL_PLATFORM_TIME_LIBRARIES "rt" CACHE STRING "platform time libraries")
      set(ECL_PLATFORM_HAS_RT_TIMERS TRUE CACHE BOOL "platform has clock_gettime and clock_nanosleep.")
    elseif ( ECL_POSIX_HAS_TIMERS ) 
      set(ECL_PLATFORM_TIME_LIBRARIES "pthread" CACHE STRING "platform time libraries")
      set(ECL_PLATFORM_HAS_POSIX_TIMERS TRUE CACHE BOOL "platform has basic posix timers.")
    endif()
  endif()
  mark_as_advanced(ECL_PLATFORM_TIME_LIBRARIES ECL_PLATFORM_HAS_WIN_TIMERS ECL_PLATFORM_HAS_MACH_TIMERS ECL_PLATFORM_HAS_RT_TIMERS ECL_PLATFORM_HAS_POSIX_TIMERS)
endmacro()

###############################
# Detect Sizes
###############################
# Configures the variables:
# 
#  - PLATFORM_SIZE_OF_CHAR
#  - PLATFORM_SIZE_OF_SHORT
#  - PLATFORM_SIZE_OF_INT
#  - PLATFORM_SIZE_OF_LONG
#  - PLATFORM_SIZE_OF_LONG_LONG
#  - PLATFORM_SIZE_OF_FLOAT
#  - PLATFORM_SIZE_OF_DOUBLE
#  - PLATFORM_SIZE_OF_LONG_DOUBLE
#  - PLATFORM_IS_32_BIT
#  - PLATFORM_IS_64_BIT
macro(ecl_detect_sizes)
    include(CheckTypeSize)
    
    CHECK_TYPE_SIZE (char PLATFORM_SIZE_OF_CHAR)
    CHECK_TYPE_SIZE (short PLATFORM_SIZE_OF_SHORT)
    CHECK_TYPE_SIZE (int PLATFORM_SIZE_OF_INT)
    CHECK_TYPE_SIZE (long PLATFORM_SIZE_OF_LONG)
    CHECK_TYPE_SIZE ("long long" PLATFORM_SIZE_OF_LONG_LONG)
    CHECK_TYPE_SIZE (float PLATFORM_SIZE_OF_FLOAT)
    CHECK_TYPE_SIZE (double PLATFORM_SIZE_OF_DOUBLE)
    CHECK_TYPE_SIZE ("long double" PLATFORM_SIZE_OF_LONG_DOUBLE)
    
    if( CMAKE_SIZEOF_VOID_P EQUAL 4 )
      set(PLATFORM_IS_32_BIT 1)
    elseif( CMAKE_SIZEOF_VOID_P EQUAL 8 ) 
      set(PLATFORM_IS_64_BIT 1)
    endif( CMAKE_SIZEOF_VOID_P EQUAL 4 )
endmacro()

###############################
# Detect Char Type
###############################
# Configures (or not) the variables:
# 
#  - PLATFORM_CHAR_IS_SIGNED
#  - PLATFORM_CHAR_IS_UNSIGNED
#
# This is bad because it fails when cross compiling. It is possible
# to do it without try_run though. Use try_compile on the classes
# set up like in ecl/concepts/containers so that it will fail to
# compile if a private constructor is called. Not necessary for
# us right now though. 
# 
macro(ecl_detect_char_type)
  rosbuild_find_ros_package(ecl_build)
  set(ECL_CMAKE_TESTS_PATH ${ecl_build_PACKAGE_PATH}/cmake/tests)
  try_run(IS_SIGNED_RAN_SUCCESS
          IS_SIGNED_COMPILED_SUCCESS 
              "${CMAKE_BINARY_DIR}"
              "${ECL_CMAKE_TESTS_PATH}/is_char_signed.cpp"
              RUN_OUTPUT_VARIABLE IS_SIGNED_OUTPUT
              )
   if(IS_SIGNED_OUTPUT STREQUAL "signed")
     set(PLATFORM_CHAR_IS_SIGNED TRUE)
   else()
     set(PLATFORM_CHAR_IS_UNSIGNED TRUE)
   endif()
endmacro()

###############################
# Detect Endianness
###############################
# Configures the variables:
# 
#  - PLATFORM_IS_BIG_ENDIAN
#  - PLATFORM_IS_LITTLE_ENDIAN
#
macro(ecl_detect_endianness)
    include(TestBigEndian)
    TEST_BIG_ENDIAN(PLATFORM_IS_BIG_ENDIAN)
    if(NOT PLATFORM_IS_BIG_ENDIAN)
      set(PLATFORM_IS_LITTLE_ENDIAN 1)
    endif()
endmacro()

###############################
# Compiler Version
###############################
# Configures the variables:
# 
#  - COMPILER_VERSION
#  - COMPILER_MAJOR_VERSION
#  - COMPILER_MINOR_VERSION
#  - COMPILER_PATCH_VERSION
#
macro(ecl_detect_compiler_version)
    if(${MSVC})
      set(COMPILER_VERSION ${MSVC})
    else()
      execute_process(
        COMMAND ${CMAKE_CXX_COMPILER} --version
        OUTPUT_VARIABLE COMPILER_VERSION_STRING
        )
      string(REGEX REPLACE ".* ([0-9])\\.([0-9])\\.([0-9]).*" "\\1.\\2.\\3"
                         COMPILER_VERSION ${COMPILER_VERSION_STRING})
      string(REGEX REPLACE ".* ([0-9])\\.[0-9]\\.[0-9].*" "\\1"
                         COMPILER_MAJOR_VERSION ${COMPILER_VERSION_STRING})
      string(REGEX REPLACE ".* [0-9]\\.([0-9])\\.[0-9].*" "\\1"
                         COMPILER_MINOR_VERSION ${COMPILER_VERSION_STRING})
      string(REGEX REPLACE ".* [0-9]\\.[0-9]\\.([0-9]).*" "\\1"
                         COMPILER_PATCH_VERSION ${COMPILER_VERSION_STRING})
    endif()
endmacro()

###############################
# Check CXX Flags
###############################
#
# This is a more general version of CheckCXXCompilerFlags.
# Why they made that one good only for compiler flags I dont know.
# Anyway, this one lets you also check for linker flags.
#
# Usage:
#   ecl_check_cxx_flags("-Wl,--as-needed" LINK_AS_NEEDED)
#   if(${LINK_AS_NEEDED})
#     set(${_flag} "-Wl,--as-needed")
#   else()
#     set(${_flag} "")
#   endif()
#
macro(ecl_check_cxx_flags _flag _result)
    include(CheckCXXSourceCompiles)
    set(ORIGINAL_CMAKE_REQUIRED_FLAGS "${CMAKE_REQUIRED_FLAGS}")
    set(CMAKE_REQUIRED_FLAGS "${_flag}")
    CHECK_CXX_SOURCE_COMPILES("int main() { return 0;}" ${_result}
      # Some compilers do not fail with a bad flag
      FAIL_REGEX "unrecognized .*option"                     # GNU
      FAIL_REGEX "ignoring unknown option"                   # MSVC
      FAIL_REGEX "[Uu]nknown option"                         # HP
      FAIL_REGEX "[Ww]arning: [Oo]ption"                     # SunPro
      FAIL_REGEX "command option .* is not recognized"       # XL
      )
    set(CMAKE_REQUIRED_FLAGS "${ORIGINAL_CMAKE_REQUIRED_FLAGS}")
endmacro()

###############################
# Compiler - link as needed
###############################
#
# This returns the result of a suitable flag for the compiler in _flag.
#
# ecl_link_as_needed(ECL_LINK_AS_NEEDED_FLAG)
# set(ROS_LINK_FLAGS "${ROS_LINK_FLAGS} ${ECL_LINK_AS_NEEDED_FLAG}")
#
macro(ecl_link_as_needed _flag)
    if(APPLE) # Apple gnu
        ecl_check_cxx_flags("-Wl,-mark_dead_strippable_dylib" DEAD_STRIPPABLE)
        if(${DEAD_STRIPPABLE})
            set(${_flag} "-Wl,-mark_dead_strippable_dylib")
        else()
            set(${_flag} "")
        endif()
    elseif(CMAKE_COMPILER_IS_GNUCXX) # Linux gnu
        ecl_check_cxx_flags("-Wl,--as-needed" link_as_needed)
        if(${link_as_needed})
            set(${_flag} "-Wl,--as-needed")
        else()
            set(${_flag} "")
        endif()
    endif()
endmacro()

###############################
# Compiler - no as needed
###############################
#
# This returns the result of a suitable flag for the compiler in _flag.
#
# ecl_link_no_as_needed(ECL_LINK_NO_AS_NEEDED_FLAG)
# set(ROS_LINK_FLAGS "${ROS_LINK_FLAGS} ${ECL_LINK_NO_AS_NEEDED_FLAG}")
#
macro(ecl_link_no_as_needed _flag)
    if(CMAKE_COMPILER_IS_GNUCXX)
        ecl_check_cxx_flags("-Wl,--no-as-needed" link_as_no_needed)
        if(${link_as_no_needed})
            set(${_flag} "-Wl,--no-as-needed")
        else()
            set(${_flag} "")
        endif()
    endif()
endmacro()

###############################
# Platform Detection
###############################
#
# The one to bind them all (detect macros)
#
macro(ecl_detect_platform)
  if(NOT DEFINED ECL_PLATFORM_DETECTION)
    set(ECL_PLATFORM_DETECTION TRUE CACHE BOOL "ecl has run platform detection checks.")
    mark_as_advanced(ECL_PLATFORM_DETECTION)
    ecl_detect_distro()
    ecl_detect_posix()
    ecl_detect_threads()
    ecl_detect_timers()
    ecl_detect_sizes()
    ecl_detect_endianness()
    #ecl_detect_char_type() # has a try_run test, bad for cross compiling
    ecl_detect_compiler_version()
    if(NOT PLATFORM_IS_POSIX)
      if(WIN32)
        set(PLATFORM_IS_WIN32 1)
      endif()
    endif()
    if(APPLE) 
      set(PLATFORM_IS_APPLE 1)
    endif()
    ecl_summary_platform()
  endif()
endmacro()

###############################
# Platform Summary
###############################
#
# Summarise platform statistics
#
macro(ecl_summary_platform)
    message("-------------------------------------------------------------------")
    message("Platform Summary")
    message("-------------------------------------------------------------------")
    message("")
    # System
    if(PLATFORM_IS_APPLE)
        message("System type.....................macosx")
    elseif(PLATFORM_IS_POSIX)
        message("System type.....................posix")
    elseif(PLATFORM_IS_WIN32)
        message("System type.....................win32")
    endif()
    message("Operating System................${CMAKE_SYSTEM}")
    if ( NOT DISTRO_NAME STREQUAL "DISTRO_NAME-UNKNOWN")
        message("Distro Name.....................${DISTRO_NAME}")
    endif()
    if ( NOT DISTRO_VERSION_STRING STREQUAL "DISTRO_VERSION_STRING-UNKNOWN")
        message(" - version string...............${DISTRO_VERSION_STRING}")
    endif()
    if ( NOT DISTRO_VERSION STREQUAL "DISTRO_VERSION-UNKNOWN")
        message(" - version......................${DISTRO_VERSION}")
    endif()
    # Timers
    if(ECL_PLATFORM_HAS_RT_TIMERS)
        message("Timer model.....................real-time")
    elseif(ECL_PLATFORM_HAS_MACH_TIMERS)
        message("Timer model.....................macosx")
    elseif(ECL_PLATFORM_HAS_POSIX_TIMERS)
        message("Timer model.....................posix")
    elseif(ECL_PLATFORM_HAS_WIN_TIMERS)
        message("Timer model.....................winmm")
    else()
        message("Timer model.....................unspecified")
    endif()
    # Threads
    if(CMAKE_USE_PTHREADS_INIT)
        message("Thread model....................posix")
    elseif(CMAKE_USE_WIN32_THREADS_INIT)
        message("Thread model....................win32")
    else(CMAKE_USE_PTHREADS_INIT)
        message("Thread model....................none")
    endif(CMAKE_USE_PTHREADS_INIT)
    # Type sizes
    message("Size of char....................${PLATFORM_SIZE_OF_CHAR}")
    message("Size of short...................${PLATFORM_SIZE_OF_SHORT}")
    message("Size of int.....................${PLATFORM_SIZE_OF_INT}")
    message("Size of long....................${PLATFORM_SIZE_OF_LONG}")
    message("Size of long long...............${PLATFORM_SIZE_OF_LONG_LONG}")
    message("Size of float...................${PLATFORM_SIZE_OF_FLOAT}")
    message("Size of double..................${PLATFORM_SIZE_OF_DOUBLE}")
    message("Size of long double.............${PLATFORM_SIZE_OF_LONG_DOUBLE}")
    if(PLATFORM_IS_32_BIT)
        message("Size of pointer.................32-bit")
    elseif(PLATFORM_IS_64_BIT)
        message("Size of pointer.................64-bit")
    endif(PLATFORM_IS_32_BIT)
    
    if(PLATFORM_IS_BIG_ENDIAN)
        message("Endianness......................big-endian")
    else(PLATFORM_IS_BIG_ENDIAN)
        message("Endianness......................little-endian")
    endif(PLATFORM_IS_BIG_ENDIAN)
    message("")

    if(PLATFORM_IS_POSIX)
        message("-------------------------------------------------------------------")
        message("Posix Specifications")
        message("-------------------------------------------------------------------")
        message("")
        if(ECL_POSIX_HAS_CLOCK_SELECTION)
            message("Clock selection.................yes")
        else()
            message("Clock selection.................no")
        endif()
        if(ECL_POSIX_HAS_CLOCK_MONOTONIC)
            message("Monotonic clock.................yes")
        else()
          message("Monotonic clock.................no")
        endif()
        if(ECL_POSIX_HAS_PRIORITY_SCHEDULING)
            message("Priority scheduling.............yes")
        else()
            message("Priority scheduling.............no")
        endif()
        if(ECL_POSIX_HAS_SEMAPHORES)
            message("Semaphores......................yes")
        else()
            message("Semaphores......................no")
        endif()
        if(ECL_POSIX_HAS_SHARED_MEMORY_OBJECTS)
            message("Shared memory objects...........yes")
        else()
            message("Shared memory objects...........no")
        endif()
        if(ECL_POSIX_HAS_TIMERS)
            message("Timers..........................yes")
        else()
            message("Timers..........................no")
        endif()
        if(ECL_POSIX_HAS_TIMEOUTS)
            message("Timeouts........................yes")
        else()
            message("Timeouts........................no")
        endif()
        if(ECL_POSIX_HAS_CLOCK_GETTIME)
            message(" - clock_gettime................yes")
        else()
            message(" - clock_gettime................no")
        endif()
        if(ECL_POSIX_HAS_CLOCK_NANOSLEEP)
            message(" - clock_nanosleep..............yes")
        else()
            message(" - clock_nanosleep..............no")
        endif()
        if(ECL_POSIX_HAS_NANOSLEEP)
            message(" - nanosleep....................yes")
        else()
            message(" - nanosleep....................no")
        endif()
        if(POSIX_HAS_MUTEX_TIMEDLOCK)
            message(" - pthread_mutex_timedlock......yes")
        else()
            message(" - pthread_mutex_timedlock......no")
        endif()
        if(POSIX_HAS_SCHED_SETSCHEDULER)
            message(" - sched_setscheduler...........yes")
        else()
            message(" - sched_setscheduler...........no")
        endif()
        if(ECL_POSIX_HAS_SEMAPHORES)
            if(POSIX_HAS_SEM_INIT)
                message(" - sem_init.....................yes")
            else()
                message(" - sem_init.....................no")
            endif()
            if(POSIX_HAS_SEM_TIMEDWAIT)
                message(" - sem_timedwait................yes")
            else()
                message(" - sem_timedwait................no")
            endif()
        endif()
        if(ECL_POSIX_HAS_SHARED_MEMORY_OBJECTS)
            if(POSIX_HAS_SHM_OPEN)
                message(" - shm_open.....................yes")
            else()
                message(" - shm_open.....................no")
            endif()
        endif()
        message("")
    endif()
    message("-------------------------------------------------------------------")
    message("Build Environment")
    message("-------------------------------------------------------------------")
    message("")
    # Compiler
    message("Compiler........................${CMAKE_CXX_COMPILER}")
    if(COMPILER_VERSION)
        message(" - version......................${COMPILER_VERSION}")
    endif()
    message("")
endmacro()

#endif // DOXYGEN_SHOULD_SKIP_THIS
