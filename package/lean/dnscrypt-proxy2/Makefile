#
# Copyright (C) 2015-2016 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v3.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=dnscrypt-proxy2
PKG_VERSION:=2.0.19
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	SECTION:=net
	CATEGORY:=Network
	TITLE:=A flexible DNS proxy, with support for encrypted DNS protocols
	URL:=https://github.com/jedisct1/dnscrypt-proxy
endef

define Package/$(PKG_NAME)/description
A flexible DNS proxy, with support for modern encrypted DNS protocols such as DNSCrypt v2 and DNS-over-HTTPS.
endef

PKG_ARCH:=$(ARCH)
ifeq ($(ARCH),aarch64)
	PKG_ARCH:=arm64
endif

PKG_BIN:=dnscrypt-proxy

define Build/Prepare
	[ ! -f $(PKG_BUILD_DIR)/$(PKG_BIN)-linux_$(PKG_ARCH)-$(PKG_VERSION).tar.gz ] && wget https://github.com/jedisct1/$(PKG_BIN)/releases/download/$(PKG_VERSION)/$(PKG_BIN)-linux_$(PKG_ARCH)-$(PKG_VERSION).tar.gz -O $(PKG_BUILD_DIR)/$(PKG_BIN)-linux_$(PKG_ARCH)-$(PKG_VERSION).tar.gz
	tar -xzf $(PKG_BUILD_DIR)/$(PKG_BIN)-linux_$(PKG_ARCH)-$(PKG_VERSION).tar.gz -C $(PKG_BUILD_DIR)
endef

define Build/Compile
	chmod +x $(PKG_BUILD_DIR)/linux-$(PKG_ARCH)/$(PKG_BIN) && upx --ultra-brute $(PKG_BUILD_DIR)/linux-$(PKG_ARCH)/$(PKG_BIN)
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/linux-$(PKG_ARCH)/$(PKG_BIN) $(1)/usr/bin/$(PKG_BIN)
	$(CP) -a files/* $(1)/
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
