################################################################################
#
# python-usagedata
#
################################################################################

PYTHON_USAGEDATA_VERSION = 88739cc5ad4ad9d407bb0254af1e79bde1f5fdee
PYTHON_USAGEDATA_SITE = $(call github,hifiberry,usagecollector,$(PYTHON_USAGEDATA_VERSION))
PYTHON_USAGEDATA_SETUP_TYPE = setuptools
PYTHON_USAGEDATA_LICENSE = MIT
PYTHON_USAGEDATA_LICENSE_FILES = LICENSE.md

define PYTHON_USAGEDATA_POST_INSTALL_TARGET_CMD
	mkdir -p $(TARGET_DIR)/var/lib/hifiberry
	mkdir -p $(TARGET_DIR)/opt/hifiberry/bin
	$(INSTALL) -D -m 0755 $(BR2_EXTERNAL_HIFIBERRY_PATH)/package/python-usagedata/report-usage \
	        $(TARGET_DIR)/opt/hifiberry/bin/
	$(INSTALL) -D -m 0755 $(BR2_EXTERNAL_HIFIBERRY_PATH)/package/python-usagedata/report-activation \
		$(TARGET_DIR)/opt/hifiberry/bin/
	$(INSTALL) -D -m 0755 $(BR2_EXTERNAL_HIFIBERRY_PATH)/package/python-usagedata/report-deactivation \
		$(TARGET_DIR)/opt/hifiberry/bin/
	$(INSTALL) -D -m 0755 $(BR2_EXTERNAL_HIFIBERRY_PATH)/package/python-usagedata/report-dump \
		$(TARGET_DIR)/opt/hifiberry/bin/
	$(INSTALL) -D -m 0644 $(BR2_EXTERNAL_HIFIBERRY_PATH)/package/python-usagedata/privacy.html \
                $(TARGET_DIR)/opt/hifiberry/etc/privacy-usagedata.html
endef

PYTHON_USAGEDATA_POST_INSTALL_TARGET_HOOKS += PYTHON_USAGEDATA_POST_INSTALL_TARGET_CMD

define PYTHON_USAGEDATA_INSTALL_INIT
	mkdir -p $(TARGET_DIR)/etc/systemd/system/timers.target.wants
	mkdir -p $(TARGET_DIR)/etc/systemd/system/multi-user.target.wants
	$(INSTALL) -D -m 0644 $(BR2_EXTERNAL_HIFIBERRY_PATH)/package/python-usagedata/datacollector.service \
		$(TARGET_DIR)/usr/lib/systemd/system/datacollector.service
	if [ -d $(TARGET_DIR)/etc/systemd/system/multi-user.target.wants ]; then \
		ln -fs ../../../../usr/lib/systemd/system/datacollector.service \
			$(TARGET_DIR)/etc/systemd/system/multi-user.target.wants/datacollector.service; \
	fi
        $(INSTALL) -D -m 0644 $(BR2_EXTERNAL_HIFIBERRY_PATH)/package/python-usagedata/pushdata.service \
                $(TARGET_DIR)/usr/lib/systemd/system/pushdata.service
        $(INSTALL) -D -m 0644 $(BR2_EXTERNAL_HIFIBERRY_PATH)/package/python-usagedata/pushdata.timer \
                $(TARGET_DIR)/usr/lib/systemd/system/pushdata.timer
        [ -d $(TARGET_DIR)/etc/systemd/system/timers.target.wants ] || mkdir $(TARGET_DIR)/etc/systemd/system/timers.target.wants
        ln -fs ../../../../usr/lib/systemd/system/pushdata.timer \
                $(TARGET_DIR)/etc/systemd/system/timers.target.wants/pushdata.timer
endef

PYTHON_USAGEDATA_POST_INSTALL_TARGET_HOOKS += PYTHON_USAGEDATA_INSTALL_INIT

$(eval $(python-package))
