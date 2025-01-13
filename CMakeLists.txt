cmake_minimum_required(VERSION 3.16)

project(dashboard VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick QuickControls2 Core Gui Qml)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(appdashboard
    main.cpp
)

qt_add_qml_module(appdashboard
    URI dashboard
    VERSION 1.0
    QML_FILES
        Main.qml
        InfoPanel.qml
        NavigationLine.qml
        WingSpeedometer.qml
        ModeSelector.qml
        ColoredOverlay.qml
    RESOURCES
        icons/bluetooth.svg
        icons/chevron-left.svg
        icons/chevron-right.svg
        icons/clock.svg
        icons/home.svg
        icons/map.svg
        icons/menu.svg
        icons/music.svg
        icons/phone.svg
        icons/power.svg
        icons/route.svg
        icons/settings.svg
        icons/signal.svg
        icons/speedometer.svg
        icons/thermometer.svg
        icons/user.svg
)

set_target_properties(appdashboard PROPERTIES
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appdashboard
    PRIVATE Qt6::Quick Qt6::QuickControls2 Qt6::Core Qt6::Gui Qt6::Qml
)

include(GNUInstallDirs)
install(TARGETS appdashboard
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
