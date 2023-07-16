ARCHS := arm64
TARGET := iphone:clang:latest:12.0
INSTALL_TARGET_PROCESSES = LiveContainer
include $(THEOS)/makefiles/common.mk

# Build the UI library
LIBRARY_NAME = LiveContainerUI
$(LIBRARY_NAME)_FILES = LCAppDelegate.m LCRootViewController.m
$(LIBRARY_NAME)_CFLAGS = -fobjc-arc
$(LIBRARY_NAME)_FRAMEWORKS = UIKit
$(LIBRARY_NAME)_INSTALL_PATH = /Applications/LiveContainer.app/Frameworks
include $(THEOS_MAKE_PATH)/library.mk

# Build the app
APPLICATION_NAME = LiveContainer
$(APPLICATION_NAME)_FILES = dyld_bypass_validation.m main.m utils.m
$(APPLICATION_NAME)_CODESIGN_FLAGS = -Sentitlements.xml -K/var/mobile/ct.p12 -Upassword
$(APPLICATION_NAME)_CFLAGS = -fobjc-arc
$(APPLICATION_NAME)_LDFLAGS = -e_LiveContainerMain
$(APPLICATION_NAME)_FRAMEWORKS = UIKit
#$(APPLICATION_NAME)_INSTALL_PATH = /Applications/LiveContainer.app
include $(THEOS_MAKE_PATH)/application.mk

# Make the executable name longer so we have space to overwrite it with the guest app's name
before-package::
	@mv .theos/_/Applications/LiveContainer.app/LiveContainer .theos/_/Applications/LiveContainer.app/LiveContainer_PleaseDoNotShortenTheExecutableNameBecauseItIsUsedToReserveSpaceForOverwritingThankYou