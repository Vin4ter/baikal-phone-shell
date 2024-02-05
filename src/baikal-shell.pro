QT += quick
CONFIG += c++17

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        alsacontroller.cpp \
        battery_handler.cpp \
        display_brightness.cpp \
        examplethreads.cpp \
        globalparams.cpp \
        hwbuttons.cpp \
        image_provider.cpp \
        main.cpp \
        networkbinder.cpp \
        networkmanager.cpp \
        process.cpp \
        sleeper.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

HEADERS += \
    alsacontroller.h \
    battery_handler.h \
    display_brightness.h \
    examplethreads.h \
    globalparams.h \
    hwbuttons.h \
    image_provider.h \
    networkbinder.h \
    networkmanager.h \
    process.h \
    sleeper.h

QMAKE_POST_LINK += cp -rv ../src/Resources/ ~/.fluid/

DISTFILES += \
    icons/baikal.jpg
