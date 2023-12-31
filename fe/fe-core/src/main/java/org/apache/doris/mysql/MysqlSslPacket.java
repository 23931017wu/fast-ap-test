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

package org.apache.doris.mysql;

import org.apache.doris.common.Config;

import java.nio.ByteBuffer;

public class MysqlSslPacket extends MysqlPacket {

    private int maxPacketSize;
    private int characterSet;
    private byte[] randomString;
    private MysqlCapability capability;

    public boolean readFrom(ByteBuffer buffer) {
        // read capability four byte, which CLIENT_PROTOCOL_41 must be set
        capability = new MysqlCapability(MysqlProto.readInt4(buffer));
        if (!capability.isProtocol41()) {
            return false;
        }
        // max packet size
        maxPacketSize = MysqlProto.readInt4(buffer);
        // character set. only support 33(utf-8)
        characterSet = MysqlProto.readInt1(buffer);
        // reserved 23 bytes
        if (new String(MysqlProto.readFixedString(buffer, 3)).equals(Config.proxy_auth_magic_prefix)) {
            randomString = new byte[MysqlPassword.SCRAMBLE_LENGTH];
            buffer.get(randomString);
        } else {
            buffer.position(buffer.position() + 20);
        }
        return true;
    }

    @Override
    public void writeTo(MysqlSerializer serializer) {

    }
}
