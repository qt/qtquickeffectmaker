// Copyright (C) 2022 The Qt Company Ltd.
// SPDX-License-Identifier: BSD-3-Clause

import QtQuick

Item {
    id: rootItem
    property alias blurSrc1: blurredItemSource1
    property alias blurSrc2: blurredItemSource2
    property alias blurSrc3: blurredItemSource3
    property alias blurSrc4: blurredItemSource4
    property alias blurSrc5: blurredItemSource5
    property alias blurSrc6: blurredItemSource6

    component BlurItem : ShaderEffect {
        property vector2d offset: Qt.vector2d((1.0 + rootItem.blurHelperBlurMultiplier) / width,
                                              (1.0 + rootItem.blurHelperBlurMultiplier) / height)
        visible: false
        smooth: true
        vertexShader: "bluritems.vert.qsb"
        fragmentShader: "bluritems.frag.qsb"
    }

    QtObject {
        id: priv
        property bool useBlurItem1: true
        property bool useBlurItem2: true
        property bool useBlurItem3: rootItem.blurMax > 2
        property bool useBlurItem4: rootItem.blurMax > 8
        property bool useBlurItem5: rootItem.blurMax > 16
        property bool useBlurItem6: rootItem.blurMax > 32
    }
    ShaderEffectSource {
        id: blurredItemSource1
        width: Math.ceil(rootItem.width / 64) * 64
        height: Math.ceil(rootItem.height / 64) * 64
        sourceItem: priv.useBlurItem1 ? source : null
        hideSource: rootItem.visible
        visible: false
        smooth: true
    }

    BlurItem {
        id: blurredItem1
        property var source: blurredItemSource1
        anchors.fill: blurredItemSource2
    }

    ShaderEffectSource {
        id: blurredItemSource2
        width: blurredItemSource1.width / 2
        height: blurredItemSource1.height / 2
        sourceItem: priv.useBlurItem2 ? blurredItem1 : null
        hideSource: rootItem.visible
        visible: false
        smooth: true
    }

    BlurItem {
        id: blurredItem2
        property var source: blurredItemSource2
        anchors.fill: blurredItemSource3
    }

    ShaderEffectSource {
        id: blurredItemSource3
        width: blurredItemSource2.width / 2
        height: blurredItemSource2.height / 2
        sourceItem: priv.useBlurItem3 ? blurredItem2 : null
        hideSource: rootItem.visible
        visible: false
        smooth: true
    }

    BlurItem {
        id: blurredItem3
        property var source: blurredItemSource3
        anchors.fill: blurredItemSource4
    }

    ShaderEffectSource {
        id: blurredItemSource4
        width: blurredItemSource3.width / 2
        height: blurredItemSource3.height / 2
        sourceItem: priv.useBlurItem4 ? blurredItem3 : null
        hideSource: rootItem.visible
        visible: false
        smooth: true
    }

    BlurItem {
        id: blurredItem4
        property var source: blurredItemSource4
        anchors.fill: blurredItemSource5
    }

    ShaderEffectSource {
        id: blurredItemSource5
        width: blurredItemSource4.width / 2
        height: blurredItemSource4.height / 2
        sourceItem: priv.useBlurItem5 ? blurredItem4 : null
        hideSource: rootItem.visible
        visible: false
        smooth: true
    }

    BlurItem {
        id: blurredItem5
        property var source: blurredItemSource5
        anchors.fill: blurredItemSource6
    }

    ShaderEffectSource {
        id: blurredItemSource6
        width: blurredItemSource5.width / 2
        height: blurredItemSource5.height / 2
        sourceItem: priv.useBlurItem6 ? blurredItem5 : null
        hideSource: rootItem.visible
        visible: false
        smooth: true
    }
}
