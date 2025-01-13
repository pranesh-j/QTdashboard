# Additional clean files
cmake_minimum_required(VERSION 3.16)

if("${CONFIG}" STREQUAL "" OR "${CONFIG}" STREQUAL "Debug")
  file(REMOVE_RECURSE
  "CMakeFiles\\appdashboard_autogen.dir\\AutogenUsed.txt"
  "CMakeFiles\\appdashboard_autogen.dir\\ParseCache.txt"
  "appdashboard_autogen"
  )
endif()
