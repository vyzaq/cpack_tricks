include(CMakeParseArguments)

function(meetup_generate_package_configuration)
  set(options)
  set(oneValueArgs VENDOR PACKAGE MAJOR MINOR BUGFIX OUTNAME UPGRADE_GUID PACKAGE_FILENAME)
  set(multiValueArgs COMPONENTS GENERATORS)

  cmake_parse_arguments(_PACKAGE_GENERATION "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN})

  if(_PACKAGE_GENERATION_UPGRADE_GUID)
    set(CPACK_WIX_UPGRADE_GUID "${_PACKAGE_GENERATION_UPGRADE_GUID}")
  endif()

  if(_PACKAGE_GENERATION_PACKAGE_FILENAME)
    set(CPACK_PACKAGE_FILE_NAME "${_PACKAGE_GENERATION_PACKAGE_FILENAME}" )
  endif()

  set(CPACK_COMPONENTS_ALL ${_PACKAGE_GENERATION_COMPONENTS})
  set(CPACK_PACKAGE_NAME "${_PACKAGE_GENERATION_PACKAGE}")
  set(CPACK_PACKAGE_VENDOR "${_PACKAGE_GENERATION_VENDOR}")
  set(CPACK_PACKAGE_VERSION_MAJOR "${_PACKAGE_GENERATION_MAJOR}")
  set(CPACK_PACKAGE_VERSION_MINOR "${_PACKAGE_GENERATION_MINOR}")
  set(CPACK_PACKAGE_VERSION_PATCH "${_PACKAGE_GENERATION_BUGFIX}")
  set(CPACK_GENERATOR ${_PACKAGE_GENERATION_GENERATORS})
  set(CPACK_OUTPUT_CONFIG_FILE ${_PACKAGE_GENERATION_OUTNAME} )
  #set(CPACK_WIX_COMPONENT_INSTALL true)
  include(CPack)
endfunction()

function(meetup_install_3rd_party arg_component_name)

  set(options)
  set(oneValueArgs DESTINATION)
  set(multiValueArgs)

  cmake_parse_arguments(_THIRD_PARTY_INSTALL "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN})

  set(_install_destination ".")
  if(_THIRD_PARTY_INSTALL_DESTINATION)
    set(_install_destination "${_THIRD_PARTY_INSTALL_DESTINATION}")
  endif()

  foreach(_target_to_wrap ${_THIRD_PARTY_INSTALL_UNPARSED_ARGUMENTS})
    get_target_property(_config_list ${_target_to_wrap} IMPORTED_CONFIGURATIONS)
    foreach(_config ${_config_list})
      get_target_property(_lib_location ${_target_to_wrap} IMPORTED_LOCATION_${_config})
      #message("!!!!!!!!!!!! ${_lib_location} - ${arg_component_name} - ${_install_destination}")
      install(FILES ${_lib_location} CONFIGURATIONS ${_config} DESTINATION "${_install_destination}" COMPONENT ${arg_component_name})
    endforeach()
  endforeach()
endfunction()

function(meetup_qt_conf_generator arg_generated_file_path_variable)
  set(options)
  set(oneValueArgs TEMPLATE_PATH PLUGINS_LOCATION)
  set(multiValueArgs)

  cmake_parse_arguments(_QT_CONF_GENERATOR "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN})

  if(NOT _QT_CONF_GENERATOR_TEMPLATE_PATH)
    set(_QT_CONF_GENERATOR_TEMPLATE_PATH "${PROJECT_SOURCE_DIR}/qt.conf.in")
  endif()

  if(NOT _QT_CONF_GENERATOR_PLUGINS_LOCATION)
    set(_QT_CONF_GENERATOR_PLUGINS_LOCATION ".")
  endif()

  set(_out_file_path "${CMAKE_CURRENT_BINARY_DIR}/qt.conf")
  configure_file("${_QT_CONF_GENERATOR_TEMPLATE_PATH}" "${_out_file_path}")
  set(${arg_generated_file_path_variable} "${_out_file_path}" PARENT_SCOPE)
endfunction()

function(meetup_install_system_runtime_dependencies arg_component_to_install)
  if(MINGW)
    set(_exe_flags ${CMAKE_EXE_LINKER_FLAGS})
    list(APPEND _exe_flags "-static")
    set(CMAKE_EXE_LINKER_FLAGS ${_exe_flags} PARENT_SCOPE)
    return()
  endif()
  set(CMAKE_INSTALL_SYSTEM_RUNTIME_DESTINATION ".")
  set(CMAKE_INSTALL_SYSTEM_RUNTIME_COMPONENT "${arg_component_to_install}")
  include( InstallRequiredSystemLibraries )
endfunction()
