# Copyright (C) 2009 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
#
LOCAL_PATH := $(call my-dir)
ROOT_PATH := $(LOCAL_PATH)

BUILD_SHARED_EXECUTABLE := $(LOCAL_PATH)/build-shared-executable.mk

########################################################
## libancillary
########################################################

include $(CLEAR_VARS)

ANCILLARY_SOURCE := fd_recv.c fd_send.c

LOCAL_MODULE := libancillary
LOCAL_CFLAGS += -I$(LOCAL_PATH)/libancillary

LOCAL_SRC_FILES := $(addprefix libancillary/, $(ANCILLARY_SOURCE))

include $(BUILD_STATIC_LIBRARY)

########################################################
## tun2socks
########################################################

include $(CLEAR_VARS)

LOCAL_CFLAGS := -std=gnu99
LOCAL_CFLAGS += -DBADVPN_THREADWORK_USE_PTHREAD -DBADVPN_LINUX -DBADVPN_BREACTOR_BADVPN -D_GNU_SOURCE
LOCAL_CFLAGS += -DBADVPN_USE_SIGNALFD -DBADVPN_USE_EPOLL
LOCAL_CFLAGS += -DBADVPN_LITTLE_ENDIAN -DBADVPN_THREAD_SAFE
LOCAL_CFLAGS += -DNDEBUG -DANDROID
# LOCAL_CFLAGS += -DTUN2SOCKS_JNI

LOCAL_STATIC_LIBRARIES := libancillary

LOCAL_C_INCLUDES:= \
		$(LOCAL_PATH)/libancillary \
        $(LOCAL_PATH)/badvpn/lwip/src/include/ipv4 \
        $(LOCAL_PATH)/badvpn/lwip/src/include/ipv6 \
        $(LOCAL_PATH)/badvpn/lwip/src/include \
        $(LOCAL_PATH)/badvpn/lwip/custom \
        $(LOCAL_PATH)/badvpn/

TUN2SOCKS_SOURCES := \
        base/BLog_syslog.c \
        system/BReactor_badvpn.c \
        system/BSignal.c \
        system/BConnection_common.c \
        system/BConnection_unix.c \
        system/BTime.c \
        system/BUnixSignal.c \
        system/BNetwork.c \
        flow/StreamRecvInterface.c \
        flow/PacketRecvInterface.c \
        flow/PacketPassInterface.c \
        flow/StreamPassInterface.c \
        flow/SinglePacketBuffer.c \
        flow/BufferWriter.c \
        flow/PacketBuffer.c \
        flow/PacketStreamSender.c \
        flow/PacketPassConnector.c \
        flow/PacketProtoFlow.c \
        flow/PacketPassFairQueue.c \
        flow/PacketProtoEncoder.c \
        flow/PacketProtoDecoder.c \
        socksclient/BSocksClient.c \
        tuntap/BTap.c \
        lwip/src/core/udp.c \
        lwip/src/core/memp.c \
        lwip/src/core/init.c \
        lwip/src/core/pbuf.c \
        lwip/src/core/tcp.c \
        lwip/src/core/tcp_out.c \
        lwip/src/core/netif.c \
        lwip/src/core/def.c \
        lwip/src/core/ip.c \
        lwip/src/core/mem.c \
        lwip/src/core/tcp_in.c \
        lwip/src/core/stats.c \
        lwip/src/core/inet_chksum.c \
        lwip/src/core/timeouts.c \
        lwip/src/core/ipv4/icmp.c \
        lwip/src/core/ipv4/igmp.c \
        lwip/src/core/ipv4/ip4_addr.c \
        lwip/src/core/ipv4/ip4_frag.c \
        lwip/src/core/ipv4/ip4.c \
        lwip/src/core/ipv4/autoip.c \
        lwip/src/core/ipv6/ethip6.c \
        lwip/src/core/ipv6/inet6.c \
        lwip/src/core/ipv6/ip6_addr.c \
        lwip/src/core/ipv6/mld6.c \
        lwip/src/core/ipv6/dhcp6.c \
        lwip/src/core/ipv6/icmp6.c \
        lwip/src/core/ipv6/ip6.c \
        lwip/src/core/ipv6/ip6_frag.c \
        lwip/src/core/ipv6/nd6.c \
        lwip/custom/sys.c \
        tun2socks/tun2socks.c \
        base/DebugObject.c \
        base/BLog.c \
        base/BPending.c \
		system/BDatagram_unix.c \
        flowextra/PacketPassInactivityMonitor.c \
        tun2socks/SocksUdpGwClient.c \
        udpgw_client/UdpGwClient.c

LOCAL_MODULE := tun2socks

LOCAL_LDLIBS := -ldl -llog

LOCAL_SRC_FILES := $(addprefix badvpn/, $(TUN2SOCKS_SOURCES))

include $(BUILD_SHARED_EXECUTABLE)

########################################################
## libevent
########################################################

include $(CLEAR_VARS)

LIBEVENT_SOURCES := \
	buffer.c bufferevent.c event.c \
	bufferevent_sock.c bufferevent_ratelim.c \
	evthread.c log.c evutil.c evutil_rand.c evutil_time.c evmap.c epoll.c poll.c signal.c select.c \
	http.c listener.c

LOCAL_MODULE := event
LOCAL_SRC_FILES := $(addprefix libevent/, $(LIBEVENT_SOURCES))
LOCAL_CFLAGS := -I$(LOCAL_PATH)/libevent \
	-I$(LOCAL_PATH)/libevent/include \

include $(BUILD_STATIC_LIBRARY)

########################################################
## tunsocks
########################################################

include $(CLEAR_VARS)

LOCAL_MODULE := tunsocks
LOCAL_MODULE_TAGS := optional
LOCAL_UNINSTALLABLE_MODULE := true

LOCAL_SRC_FILES := \
tunsocks_SOURCES = \
	tunsocks/lwip/src/api/err.c \
	tunsocks/lwip/src/core/init.c \
	tunsocks/lwip/src/core/def.c \
	tunsocks/lwip/src/core/mem.c \
	tunsocks/lwip/src/core/memp.c \
	tunsocks/lwip/src/core/netif.c \
	tunsocks/lwip/src/core/pbuf.c \
	tunsocks/lwip/src/core/stats.c \
	tunsocks/lwip/src/core/ip.c \
	tunsocks/lwip/src/core/dns.c \
	tunsocks/lwip/src/core/udp.c \
	tunsocks/lwip/src/core/raw.c \
	tunsocks/lwip/src/core/sys.c \
	tunsocks/lwip/src/core/tcp.c \
	tunsocks/lwip/src/core/tcp_in.c \
	tunsocks/lwip/src/core/tcp_out.c \
	tunsocks/lwip/src/core/inet_chksum.c \
	tunsocks/lwip/src/core/ipv4/etharp.c \
	tunsocks/lwip/src/core/ipv4/icmp.c \
	tunsocks/lwip/src/core/ipv4/ip4.c \
	tunsocks/lwip/src/core/ipv4/ip4_addr.c \
	tunsocks/lwip/src/core/ipv4/ip4_frag.c \
	tunsocks/lwip/src/netif/ethernet.c \
	tunsocks/lwip-udhcpd/udhcp_packet.c \
	tunsocks/lwip-udhcpd/udhcp_common.c \
	tunsocks/lwip-udhcpd/dhcpd.c \
	tunsocks/lwip-udhcpd/domain_codec.c \
	tunsocks/lwip-libevent/netif/fdif.c \
	tunsocks/lwip-libevent/netif/slirpif.c \
	tunsocks/lwip-libevent/netif/slirpif_tcp.c \
	tunsocks/lwip-libevent/netif/slirpif_udp.c \
	tunsocks/lwip-libevent/netif/udptapif.c \
	tunsocks/lwip-libevent/netif/tunif.c \
	tunsocks/lwip-libevent/netif/vdeportif.c \
	tunsocks/lwip-libevent/netif/vdeswitchif.c \
	tunsocks/lwip-libevent/util/sockaddr.c \
	tunsocks/lwip-libevent/util/lwipevbuf.c \
	tunsocks/lwip-libevent/util/lwipevbuf_bev_join.c \
	tunsocks/lwip-libevent/util/host.c \
	tunsocks/lwip-libevent/util/pbuf_iovec.c \
	tunsocks/lwip-libevent/util/nettest.c \
	tunsocks/lwip-libevent/libevent.c \
	tunsocks/lwip-nat/ip4_prerouting_hook.c \
	tunsocks/lwip-nat/ip4_input_nat.c \
	tunsocks/lwip-nat/nat_proto_tcp.c \
	tunsocks/lwip-nat/nat_proto_udp.c \
	tunsocks/lwip-nat/nat_proto_icmp4.c \
	tunsocks/lwip-nat/nat_proto_ip4.c \
	tunsocks/lwip-nat/nat.c \
	tunsocks/src/socks4.c \
	tunsocks/src/socks5.c \
	tunsocks/src/socks.c \
	tunsocks/src/forward_local.c \
	tunsocks/src/forward_remote.c \
	tunsocks/src/nat.c \
	tunsocks/src/dhcp_server.c \
	tunsocks/src/http/http.c \
	tunsocks/src/http/server.c \
	tunsocks/src/http/evhttp_extra.c \
	tunsocks/src/main.c \
	tunsocks/src/reallocarray.c

LOCAL_C_INCLUDES := \
	$(LOCAL_PATH)/tunsocks/lwip/src/include \
	$(LOCAL_PATH)/tunsocks/lwip/src/include/ipv4 \
	$(LOCAL_PATH)/tunsocks/lwip/src/include/ipv6 \
	$(LOCAL_PATH)/tunsocks/lwip-libevent/include \
	$(LOCAL_PATH)/tunsocks/lwip-libevent/include/util \
	$(LOCAL_PATH)/tunsocks/lwip-nat/include \
	$(LOCAL_PATH)/tunsocks/lwip-udhcpd \
	$(LOCAL_PATH)/tunsocks/include

LOCAL_C_INCLUDES += \
	$(LOCAL_PATH)/libevent/include

LOCAL_SHARED_LIBRARIES := \
	event

include $(BUILD_SHARED_EXECUTABLE)
