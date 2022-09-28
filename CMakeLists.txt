cmake_minimum_required(VERSION 3.16)
project(QQEffectMaker VERSION 1.0 LANGUAGES CXX)
include(FeatureSummary)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

find_package(QT NAMES Qt5 Qt6 REQUIRED COMPONENTS Core)
find_package(Qt${QT_VERSION_MAJOR} REQUIRED COMPONENTS Gui Quick ShaderTools)
find_package(Qt${QT_VERSION_MAJOR} COMPONENTS Quick3DGlslParserPrivate)

set_package_properties(Qt${QT_VERSION_MAJOR}Quick3DGlslParserPrivate PROPERTIES
    TYPE OPTIONAL
    PURPOSE "- Enables Syntax Highlighting"
)
feature_summary(INCLUDE_QUIET_PACKAGES WHAT
    PACKAGES_FOUND PACKAGES_NOT_FOUND
    ENABLED_FEATURES DISABLED_FEATURES
)

qt_standard_project_setup()

qt_add_executable(QQEffectMaker WIN32 MACOSX_BUNDLE
    main.cpp
    src/addnodemodel.cpp src/addnodemodel.h
    src/applicationsettings.cpp src/applicationsettings.h
    src/arrowsmodel.cpp src/arrowsmodel.h
    src/effectmanager.cpp src/effectmanager.h
    src/fpshelper.cpp src/fpshelper.h
    src/nodesmodel.cpp src/nodesmodel.h
    src/nodeview.cpp src/nodeview.h
    src/propertyhandler.cpp src/propertyhandler.h
    src/qsbinspectorhelper.cpp src/qsbinspectorhelper.h
    src/shaderfeatures.cpp src/shaderfeatures.h
    src/syntaxhighlighter.cpp src/syntaxhighlighter.h
    src/syntaxhighlighterdata.cpp src/syntaxhighlighterdata.h
    src/uniformmodel.cpp src/uniformmodel.h
    src/codehelper.cpp src/codehelper.h
    src/codecompletionmodel.cpp src/codecompletionmodel.h
)

add_compile_definitions(QT_USE_QSTRINGBUILDER)

set(APPNAME_DIR "QQEffectMaker")

set(DATA_PATH /tmp/${APPNAME_DIR})
set(DEFAULTNODES_FOLDER "/defaultnodes")
if (WIN32)
    cmake_path(SET LOCAL_NORM $ENV{LOCALAPPDATA})
    set(DATA_PATH ${LOCAL_NORM}/${APPNAME_DIR})
endif ()
if (UNIX AND NOT APPLE)
    set(DATA_PATH /opt/${APPNAME_DIR})
endif ()
if (APPLE)
    set(APPNAME_DIR "QQEffectMaker.app/Contents")
    set(DATA_PATH ${CMAKE_BINARY_DIR}/${APPNAME_DIR})
endif ()

message("Installing application data into: " ${DATA_PATH})

set(nodes_folders
    "nodes/basic"
    "nodes/common"
    "nodes/extra"
    "nodes/images"
    "nodes/nature"
)
file(COPY ${nodes_folders}
    DESTINATION ${DATA_PATH}${DEFAULTNODES_FOLDER}
)

target_compile_definitions(QQEffectMaker PRIVATE
    QQEM_DATA_PATH=\"${DATA_PATH}\"
)

target_link_libraries(QQEffectMaker PRIVATE
    Qt::Core
    Qt::Gui
    Qt::Quick
    Qt::QuickPrivate
    Qt::ShaderToolsPrivate
)

# Resources:
set(qml_resource_files
    "nodes/common/BlurHelper.qml"
    "nodes/common/bluritems.frag"
    "nodes/common/bluritems.frag.qsb"
    "nodes/common/bluritems.vert"
    "nodes/common/bluritems.vert.qsb"
    "qml/AboutDialog.qml"
    "qml/AddNodeDialog.qml"
    "qml/ApplicationSettingsDialog.qml"
    "qml/ClearNodeViewDialog.qml"
    "qml/CodeEditor.qml"
    "qml/CustomDialog.qml"
    "qml/CustomIconButton.qml"
    "qml/CustomImageSelector.qml"
    "qml/CustomModeToggle.qml"
    "qml/CustomPopup.qml"
    "qml/CustomSplitView.qml"
    "qml/CustomTextEdit.qml"
    "qml/CustomTextField.qml"
    "qml/DeleteNodeDialog.qml"
    "qml/EditorView.qml"
    "qml/EffectPreview.qml"
    "qml/EffectPreviewToolbar.qml"
    "qml/ExportEffectDialog.qml"
    "qml/FindBar.qml"
    "qml/HelpView.qml"
    "qml/MainToolbar.qml"
    "qml/MainView.qml"
    "qml/NewProjectDialog.qml"
    "qml/NodeView.qml"
    "qml/OutputView.qml"
    "qml/PlaybackTimeComponent.qml"
    "qml/ProjectSettingsDialog.qml"
    "qml/PropertiesView.qml"
    "qml/PropertyEditDialog.qml"
    "qml/QsbInspectorDialog.qml"
    "qml/RenameNodeDialog.qml"
    "qml/SaveProjectDialog.qml"
    "qml/StatusBar.qml"
    "qml/about_effect/AboutEffect1.qml"
    "qml/about_effect/abouteffect1.frag.qsb"
    "qml/about_effect/abouteffect1.vert.qsb"
    "qml/images/background_colorful.jpg"
    "qml/images/background_dark.jpg"
    "qml/images/background_light.jpg"
    "qml/images/button_qsb.png"
    "qml/images/button_show.png"
    "qml/images/icon_add.png"
    "qml/images/icon_api.png"
    "qml/images/icon_api_on.png"
    "qml/images/icon_arrow.png"
    "qml/images/icon_arrow_down.png"
    "qml/images/icon_arrow_up.png"
    "qml/images/icon_autoplay.png"
    "qml/images/icon_autoplay_on.png"
    "qml/images/icon_borders.png"
    "qml/images/icon_borders_on.png"
    "qml/images/icon_distribute_nodes.png"
    "qml/images/icon_edit.png"
    "qml/images/icon_error.png"
    "qml/images/icon_layout_nodes.png"
    "qml/images/icon_pause.png"
    "qml/images/icon_play.png"
    "qml/images/icon_remove_shadow.png"
    "qml/images/icon_reset.png"
    "qml/images/icon_restart.png"
    "qml/images/icon_settings.png"
    "qml/images/icon_settings_on.png"
    "qml/images/icon_soften.png"
    "qml/images/icon_soften_on.png"
    "qml/images/icon_viewseparator.png"
    "qml/images/icon_visibility_off.png"
    "qml/images/icon_visibility_on.png"
    "qml/images/icon_zoom_auto.png"
    "qml/images/icon_zoom_in.png"
    "qml/images/icon_zoom_out.png"
    "qml/images/item_border.png"
    "qml/images/nodeview_background.jpg"
    "qml/images/toggle_background.png"
    "qml/images/toggle_m1.png"
    "qml/images/toggle_m2.png"
    "qml/main.qml"
    "qqem_help.html"
    "qtquickcontrols2.conf"
    "qml/fonts/SourceCodePro-Bold.ttf"
    "qml/fonts/SourceCodePro-It.ttf"
    "qml/fonts/SourceCodePro-Regular.ttf"
)

qt_add_resources(QQEffectMaker "qml"
    PREFIX
        "/"
    FILES
        ${qml_resource_files}
)

if (Qt${QT_VERSION_MAJOR}Quick3DGlslParserPrivate_FOUND)
    target_compile_definitions(QQEffectMaker PRIVATE
        QQEM_SYNTAX_HIGHLIGHTING_ENABLED
    )
    target_link_libraries(QQEffectMaker PRIVATE
        Qt::Quick3DGlslParserPrivate
    )
else ()
    message(NOTICE "Note: No Quick3DGlslParserPrivate available, building without syntax highlighting")
endif ()

if (APPLE)
    install(TARGETS QQEffectMaker
        BUNDLE DESTINATION .
        RUNTIME DESTINATION ${DATA_PATH}
    )
else ()
    install(TARGETS QQEffectMaker
        BUNDLE DESTINATION .
        RUNTIME DESTINATION ${DATA_PATH}\\${CMAKE_INSTALL_BINDIR}
    )
endif ()

qt_generate_deploy_app_script(
    TARGET QQEffectMaker
    FILENAME_VARIABLE deploy_script
    NO_UNSUPPORTED_PLATFORM_ERROR
)
install(SCRIPT ${deploy_script})
