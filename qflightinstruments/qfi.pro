#-------------------------------------------------
#
# Project created by QtCreator 2013-09-19T16:09:01
#
#-------------------------------------------------

QT += svg

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = qfi
TEMPLATE = lib

#-------------------------------------------------

DEFINES += QFI_LIBRARY

win32: DEFINES += WIN32 _WINDOWS _USE_MATH_DEFINES

win32:CONFIG(release, debug|release):    DEFINES += NDEBUG
else:win32:CONFIG(debug, debug|release): DEFINES += _DEBUG

#-------------------------------------------------

INCLUDEPATH += ./

#-------------------------------------------------

HEADERS += \
    src/qfi_ADI.h \
    src/qfi_HSI.h \
    src/qfi_NAV.h \
    src/qfi_PFD.h \
    src/qfi_VSI.h \
    src/qfi_SI.h \
    src/qfi_ALT.h \
    src/qfi_TC.h

SOURCES += \
    src/qfi_ADI.cpp \
    src/qfi_HSI.cpp \
    src/qfi_NAV.cpp \
    src/qfi_PFD.cpp \
    src/qfi_VSI.cpp \
    src/qfi_SI.cpp \
    src/qfi_ALT.cpp \
    src/qfi_TC.cpp

RESOURCES += \
    src/qfi.qrc

#-------------------------------------------------


headers.files = src/*.h
headers.path = /usr/include
python.files = python3.5/qfi/*
python.path = /usr/lib/python3/dist-packages/qfi

INSTALLS += headers
unix:!symbian {
    maemo5 {
        target.path = /opt/usr/lib
    } else {
        target.path = /usr/lib
    }
    INSTALLS += target
}

INSTALLS += python
