add_library(QtQuickEffectMakerDoc INTERFACE)
target_link_libraries(QtQuickEffectMakerDoc INTERFACE Qt::Core)

if(QT_BUILD_ONLINE_DOCS)
    set(DOC_CONF "online/qtquickeffectmaker.qdocconf")
else()
    set(DOC_CONF "qtquickeffectmaker.qdocconf")
endif()

qt_internal_add_docs(QtQuickEffectMakerDoc
    ${DOC_CONF}
)
