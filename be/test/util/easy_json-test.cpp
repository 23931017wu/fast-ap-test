// Licensed to the Apache Software Foundation (ASF) under one
// or more contributor license agreements.  See the NOTICE file
// distributed with this work for additional information
// regarding copyright ownership.  The ASF licenses this file
// to you under the Apache License, Version 2.0 (the
// "License"); you may not use this file except in compliance
// with the License.  You may obtain a copy of the License at
//
//   http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

#include "util/easy_json.h"

#include <gtest/gtest-message.h>
#include <gtest/gtest-test-part.h>
#include <rapidjson/allocators.h>
#include <rapidjson/document.h>
#include <rapidjson/rapidjson.h>

#include <string>

#include "gtest/gtest_pred_impl.h"

using rapidjson::SizeType;
using rapidjson::Value;
using std::string;

namespace doris {

class EasyJsonTest : public ::testing::Test {};

TEST_F(EasyJsonTest, TestNull) {
    EasyJson ej;
    EXPECT_TRUE(ej.value().IsNull());
}

TEST_F(EasyJsonTest, TestNested) {
    EasyJson ej;
    ej.SetObject();
    ej.Get("nested").SetObject();
    ej.Get("nested").Set("nested_attr", true);
    EXPECT_EQ(ej.value()["nested"]["nested_attr"].GetBool(), true);

    ej.Get("nested_array").SetArray();
    ej.Get("nested_array").PushBack(1);
    ej.Get("nested_array").PushBack(2);
    EXPECT_EQ(ej.value()["nested_array"][SizeType(0)].GetInt(), 1);
    EXPECT_EQ(ej.value()["nested_array"][SizeType(1)].GetInt(), 2);
}

TEST_F(EasyJsonTest, TestCompactSyntax) {
    EasyJson ej;
    ej["nested"]["nested_attr"] = true;
    EXPECT_EQ(ej.value()["nested"]["nested_attr"].GetBool(), true);

    for (int i = 0; i < 2; i++) {
        ej["nested_array"][i] = i + 1;
    }
    EXPECT_EQ(ej.value()["nested_array"][SizeType(0)].GetInt(), 1);
    EXPECT_EQ(ej.value()["nested_array"][SizeType(1)].GetInt(), 2);
}

TEST_F(EasyJsonTest, TestComplexInitializer) {
    EasyJson ej;
    ej = EasyJson::kObject;
    EXPECT_TRUE(ej.value().IsObject());

    EasyJson nested_arr = ej.Set("nested_arr", EasyJson::kArray);
    EXPECT_TRUE(nested_arr.value().IsArray());

    EasyJson nested_obj = nested_arr.PushBack(EasyJson::kObject);
    EXPECT_TRUE(ej["nested_arr"][0].value().IsObject());
}

TEST_F(EasyJsonTest, TestAllocatorLifetime) {
    EasyJson* root = new EasyJson;
    EasyJson child = (*root)["child"];
    delete root;

    child["child_attr"] = 1;
    EXPECT_EQ(child.value()["child_attr"].GetInt(), 1);
}
} // namespace doris
