export ARCHS = armv7 arm64

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = ExactTimePhone
ExactTimePhone_FILES = Tweak.xm
ExactTimePhone_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 MobilePhone"
