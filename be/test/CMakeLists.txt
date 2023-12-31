# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.

# where to put generated libraries
set(LIBRARY_OUTPUT_PATH "${BUILD_DIR}/test")

# where to put generated libraries
set(EXECUTABLE_OUTPUT_PATH "${BUILD_DIR}/test")

file(GLOB_RECURSE UT_FILES CONFIGURE_DEPENDS *.cpp)

if(NOT DEFINED DORIS_WITH_LZO)
    list(REMOVE_ITEM UT_FILES ${CMAKE_CURRENT_SOURCE_DIR}/exec/plain_text_line_reader_lzop_test.cpp)
endif()

if (OS_MACOSX)
    list(REMOVE_ITEM UT_FILES ${CMAKE_CURRENT_SOURCE_DIR}/util/system_metrics_test.cpp)
endif()

list(REMOVE_ITEM UT_FILES ${CMAKE_CURRENT_SOURCE_DIR}/tools/benchmark_tool.cpp)

# todo: need fix those ut
list(REMOVE_ITEM UT_FILES
    ${CMAKE_CURRENT_SOURCE_DIR}/agent/heartbeat_server_test.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/common/config_validator_test.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/http/metrics_action_test.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/olap/rowset/segment_v2/binary_dict_page_test.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/olap/rowset/segment_v2/binary_plain_page_test.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/olap/rowset/segment_v2/binary_prefix_page_test.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/olap/rowset/segment_v2/bitshuffle_page_test.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/olap/rowset/segment_v2/column_reader_writer_test.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/olap/rowset/segment_v2/frame_of_reference_page_test.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/olap/rowset/segment_v2/plain_page_test.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/olap/rowset/segment_v2/rle_page_test.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/olap/segcompaction_test.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/runtime/decimal_value_test.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/runtime/result_buffer_mgr_test.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/util/decompress_test.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/util/runtime_profile_test.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/util/url_coding_test.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/exprs/hybrid_set_test.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/io/fs/remote_file_system_test.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/olap/remote_rowset_gc_test.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/runtime/jsonb_value_test.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/runtime/large_int_value_test.cpp
)

add_executable(doris_be_test ${UT_FILES})

target_link_libraries(doris_be_test ${TEST_LINK_LIBS})
set_target_properties(doris_be_test PROPERTIES COMPILE_FLAGS "-fno-access-control")

if (OS_MACOSX AND ARCH_ARM)
    find_program(DSYMUTIL NAMES dsymutil)
    message(STATUS "dsymutil found: ${DSYMUTIL}")
    add_custom_command(TARGET doris_be_test POST_BUILD
        COMMAND ${DSYMUTIL} $<TARGET_FILE:doris_be_test>
        COMMAND ${CMAKE_STRIP} -S $<TARGET_FILE:doris_be_test>
    )
endif()

if (BUILD_BENCHMARK_TOOL AND BUILD_BENCHMARK_TOOL STREQUAL "ON")
    add_executable(benchmark_tool
    tools/benchmark_tool.cpp
    testutil/test_util.cpp
    olap/tablet_schema_helper.cpp
    )

    target_link_libraries(benchmark_tool ${TEST_LINK_LIBS})
    set_target_properties(benchmark_tool PROPERTIES COMPILE_FLAGS "-fno-access-control")
endif()
