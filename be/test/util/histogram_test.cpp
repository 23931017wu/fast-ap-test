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

#include "util/histogram.h"

#include <gtest/gtest-message.h>
#include <gtest/gtest-test-part.h>

#include <cmath>

#include "gtest/gtest_pred_impl.h"

namespace doris {

class HistogramTest : public testing::Test {
public:
    HistogramTest() {}
    virtual ~HistogramTest() {}
};

namespace {
const HistogramBucketMapper bucket_mapper;
const double delta = 0.1;
} // namespace

void populate_histogram(HistogramStat& hist, uint64_t low, uint64_t high, uint64_t loop = 1) {
    for (; loop > 0; loop--) {
        for (uint64_t i = low; i <= high; i++) {
            hist.add(i);
        }
    }
}

TEST_F(HistogramTest, Normal) {
    HistogramStat hist;
    EXPECT_TRUE(hist.is_empty());
    populate_histogram(hist, 1, 110, 10);
    EXPECT_EQ(hist.num(), 1100);

    EXPECT_LE(fabs(hist.percentile(100.0) - 110.0), delta);
    EXPECT_LE(fabs(hist.percentile(99.0) - 108.9), delta);
    EXPECT_LE(fabs(hist.percentile(95.0) - 104.5), delta);
    EXPECT_LE(fabs(hist.median() - 55.0), delta);
    EXPECT_EQ(hist.average(), 55.5);
}

TEST_F(HistogramTest, Merge) {
    HistogramStat hist;
    HistogramStat other;

    populate_histogram(hist, 1, 100);
    populate_histogram(other, 101, 250);
    hist.merge(other);

    EXPECT_LE(fabs(hist.percentile(100.0) - 250.0), delta);
    EXPECT_LE(fabs(hist.percentile(99.0) - 247.5), delta);
    EXPECT_LE(fabs(hist.percentile(95.0) - 237.5), delta);
    EXPECT_LE(fabs(hist.median() - 125.0), delta);
    EXPECT_EQ(hist.average(), 125.5);
}

TEST_F(HistogramTest, Empty) {
    HistogramStat hist;
    EXPECT_EQ(hist.min(), bucket_mapper.last_value());
    EXPECT_EQ(hist.max(), 0);
    EXPECT_EQ(hist.num(), 0);
    EXPECT_EQ(hist.median(), 0.0);
    EXPECT_EQ(hist.percentile(85.0), 0.0);
    EXPECT_EQ(hist.average(), 0.0);
    EXPECT_EQ(hist.standard_deviation(), 0.0);
}

TEST_F(HistogramTest, Clear) {
    HistogramStat hist;
    populate_histogram(hist, 1, 100);

    hist.clear();
    EXPECT_TRUE(hist.is_empty());
    EXPECT_EQ(hist.median(), 0);
    EXPECT_EQ(hist.percentile(85.0), 0.0);
    EXPECT_EQ(hist.average(), 0.0);
}

} // namespace doris
