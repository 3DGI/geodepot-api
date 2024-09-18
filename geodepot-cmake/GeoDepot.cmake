include(FetchContent)
FetchContent_Declare(
  geodepot-api
  GIT_REPOSITORY https://github.com/3DGI/geodepot-api.git
  GIT_TAG        0667404ff96306e26e4e6f4f3c17fd24b4d8575d
)
FetchContent_MakeAvailable(geodepot-api)

try_compile(GEODEPOT_INIT_COMPILE_RESULTS
        PROJECT geodepot-api
        BINARY_DIR ${CMAKE_BINARY_DIR}/geodepot-api-build
        SOURCE_DIR "${CMAKE_BINARY_DIR}/_deps/geodepot-api-src"
        TARGET geodepot-init
        CMAKE_FLAGS -DGD_BUILD_TESTING=OFF -DGD_BUILD_BINDINGS=OFF -DGD_BUILD_APPS=ON
)

try_compile(GEODEPOT_INIT_COMPILE_RESULTS
        PROJECT geodepot-api
        BINARY_DIR ${CMAKE_BINARY_DIR}/geodepot-api-build
        SOURCE_DIR "${CMAKE_BINARY_DIR}/_deps/geodepot-api-src"
        TARGET geodepot-get
        CMAKE_FLAGS -DGD_BUILD_TESTING=OFF -DGD_BUILD_BINDINGS=OFF -DGD_BUILD_APPS=ON
)

function(GeodepotInit URL)
    message(${URL})
    execute_process(
            COMMAND ${CMAKE_BINARY_DIR}/geodepot-api-build/apps/init/geodepot-init ${URL}
            WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
            COMMAND_ERROR_IS_FATAL ANY
    )
    set(GEODEPOT_DIR "${CMAKE_BINARY_DIR}/.geodepot/cases" CACHE PATH "Geodepot cases directory")
endfunction()

function(GeodepotGet CASESPEC)
    message(${CASESPEC})
    execute_process(
            COMMAND ${CMAKE_BINARY_DIR}/geodepot-api-build/apps/get/geodepot-get ${CASESPEC}
            WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
            COMMAND_ERROR_IS_FATAL ANY
    )
endfunction()
