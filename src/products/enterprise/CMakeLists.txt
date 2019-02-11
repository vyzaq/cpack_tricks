file(GLOB_RECURSE predefined_sources "predefined/*.*")
install(FILES ${predefined_sources} DESTINATION "." COMPONENT EnterpriseProduct)
