################################################################################
#
# kad-scripts
#
################################################################################

KAD_SCRIPTS_VERSION =  1967d6a40f3ce6341c1bff4339bb4fa5af56495d
KAD_SCRIPTS_SITE = $(call github,j-schambacher,kad-scripts,$(KAD_SCRIPTS_VERSION))

define KAD_SCRIPTS_INSTALL_TARGET_CMDS
        mkdir -p $(TARGET_DIR)/opt/kad
	cp -rv $(@D)/* $(TARGET_DIR)/opt/kad
endef


define KAD_SCRIPTS_INSTALL_INIT_SYSTEMD
        $(INSTALL) -D -m 0644 $(BR2_EXTERNAL_HIFIBERRY_PATH)/package/kad-scripts/kad-scripts.service \
                $(TARGET_DIR)/usr/lib/systemd/system/kad-scripts.service
        ln -fs ../../../../usr/lib/systemd/system/kad-scripts.service \
		$(TARGET_DIR)/etc/systemd/system/multi-user.target.wants/kad-scripts.service
endef

$(eval $(generic-package))
