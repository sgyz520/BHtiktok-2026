TARGET := iphone:clang:16.5
INSTALL_TARGET_PROCESSES = TikTok
THEOS_DEVICE_IP = 192.168.100.246
THEOS_DEVICE_USER = root
include $(THEOS)/makefiles/common.mk

TWEAK_NAME = BHTikTok

BHTikTok_FILES = Tweak.x $(wildcard *.m JGProgressHUD/*.m Settings/*.m)
BHTikTok_FRAMEWORKS = UIKit Foundation CoreGraphics Photos CoreServices SystemConfiguration SafariServices Security QuartzCore
BHTikTok_CFLAGS = -fobjc-arc -Wno-unused-variable -Wno-unused-value -Wno-deprecated-declarations -Wno-nullability-completeness -Wno-unused-function -Wno-incompatible-pointer-types

# 包含本地化文件
BHTikTok_INSTALL_PATH = /Library/MobileSubstrate/DynamicLibraries
BHTikTok_RESOURCE_DIRS = zh-Hans.lproj

include $(THEOS_MAKE_PATH)/tweak.mk

# 确保本地化文件被包含在包中，并放在正确位置
after-stage::
	$(ECHO_NOTHING)mkdir -p "$(THEOS_STAGING_DIR)/Library/Application Support/BHTikTok"$(ECHO_END)
	$(ECHO_NOTHING)cp -r zh-Hans.lproj "$(THEOS_STAGING_DIR)/Library/Application Support/BHTikTok/"$(ECHO_END)
	# 将本地化文件复制到TikTok应用bundle中
	$(ECHO_NOTHING)mkdir -p "$(THEOS_STAGING_DIR)/var/mobile/Containers/Data/Application/TikTok.app"$(ECHO_END)
	$(ECHO_NOTHING)cp -r zh-Hans.lproj "$(THEOS_STAGING_DIR)/var/mobile/Containers/Data/Application/TikTok.app/"$(ECHO_END)