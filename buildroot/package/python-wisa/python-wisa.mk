################################################################################
#
# python-wisa
#
################################################################################

#PYTHON_WISA_VERSION = 3.3.1
PYTHON_WISA_FILE = pysummit-3.3.1-py3.8.egg
PYTHON_WISA_EXTRA_DOWNLOADS=http://1XhfXHxPIWvL.schambacher.com/$(PYTHON_WISA_FILE)

define PYTHON_WISA_INSTALL_TARGET_CMDS
        mkdir -p $(TARGET_DIR)/usr/lib/python3.8/site-packages
	cd $(TARGET_DIR)/usr/lib/python3.8/site-packages ; \
          cp $(PYTHON_WISA_DL_DIR)/$(PYTHON_WISA_FILE) . ; \
	  echo "./pysummit-3.3.1-py3.8.egg" >> easy_install.pth
endef

#PYTHON_WISA_SOURCE = pysummit-$(PYTHON_WISA_VERSION)-kad.tar.gz
#PYTHON_WISA_SITE = http://share.schambacher.com/hifiberry
#PYTHON_WISA_SETUP_TYPE = setuptools
#PYTHON_WISA_LICENSE = BSD
#PYTHON_WISA_LICENSE_FILES = LICENSE.txt

$(eval $(generic-package))
