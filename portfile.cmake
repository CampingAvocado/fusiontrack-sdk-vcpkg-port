vcpkg_check_linkage()
set(VCPKG_BUILD_TYPE release)

# Download the library - Skip for now because Windows has an installer
# if(VCPKG_TARGET_IS_WINDOWS)
#     vcpkg_download_distfile(ARCHIVE
#         URLS "https://example.com/path/to/library/windows.zip"
#         FILENAME "library-windows.zip"
#         SHA512 <SHA512_HASH>
#     )
# elseif(VCPKG_TARGET_IS_LINUX)
#     vcpkg_download_distfile(ARCHIVE
#         URLS "https://example.com/path/to/library/linux.tar.gz"
#         FILENAME "library-linux.tar.gz"
#         SHA512 <SHA512_HASH>
#     )
# endif()

# Extract the library
# vcpkg_extract_source_archive_ex(
#     OUT_SOURCE_PATH SOURCE_PATH
#     ARCHIVE "${ARCHIVE}"
# )

cmake_path(SET SOURCE_PATH ${CMAKE_CURRENT_LIST_DIR}) # TEMP

# Copy headers
file(GLOB headers "${SOURCE_PATH}/include/*" "${SOURCE_PATH}/atnet"
                  "${SOURCE_PATH}/samples/*.hpp" "${SOURCE_PATH}/advancedAPI/*.hpp")
file(COPY ${headers} DESTINATION "${CURRENT_PACKAGES_DIR}/include")

# Copy binaries
if(VCPKG_TARGET_IS_WINDOWS)
    file(COPY "${SOURCE_PATH}/lib/" DESTINATION "${CURRENT_PACKAGES_DIR}/lib")
    file(COPY "${SOURCE_PATH}/bin/" DESTINATION "${CURRENT_PACKAGES_DIR}/bin")
elseif(VCPKG_TARGET_IS_LINUX) # TODO: rectify
endif()

# Copy sources - this is not normally done but the partially compiled mess that is the Atracsys SDK forces my hands here...
file(GLOB advancedAPI_sources "${SOURCE_PATH}/advancedAPI/*.cpp")
file(COPY ${advancedAPI_sources} DESTINATION "${CURRENT_PACKAGES_DIR}/src/advancedAPI")

# Copy CMake config files
file(COPY "${SOURCE_PATH}/cmake/" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}/")