// Copyright (C) 2022 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

CustomDialog {
    id: rootItem

    // Original item padding
    property rect itemPadding
    // Modified item padding
    property rect newItemPadding

    function updatePadding() {
        effectManager.setEffectPadding(newItemPadding);
    }

    title: qsTr("Project Settings")
    width: 400
    height: 340
    modal: true
    focus: true

    onVisibleChanged: {
        if (visible) {
            paddingLeftTextField.text = itemPadding.x;
            paddingTopTextField.text = itemPadding.y;
            paddingRightTextField.text = itemPadding.width;
            paddingBottomTextField.text = itemPadding.height;
        }
    }

    Text {
        id: paddingLabel
        color: mainView.foregroundColor2
        font.pixelSize: 14
        font.bold: true
        text: "Item padding"
    }
    GridLayout {
        anchors.top: paddingLabel.bottom
        anchors.topMargin: 5
        columns: 4
        Text {
            Layout.row: 0
            Layout.column: 0
            Layout.preferredWidth: 50
            color: mainView.foregroundColor2
            font.pixelSize: 14
            text: "left:"
        }
        TextField {
            id: paddingLeftTextField
            Layout.row: 0
            Layout.column: 1
            Layout.preferredWidth: 50
            text: itemPadding.x
            onTextChanged: {
                rootItem.newItemPadding.x = Number(text);
                updatePadding();
            }
        }
        Text {
            Layout.row: 0
            Layout.column: 2
            Layout.preferredWidth: 50
            color: mainView.foregroundColor2
            font.pixelSize: 14
            text: "top:"
        }
        TextField {
            id: paddingTopTextField
            Layout.row: 0
            Layout.column: 3
            Layout.preferredWidth: 50
            text: itemPadding.y
            onTextChanged: {
                rootItem.newItemPadding.y = Number(text);
                updatePadding();
            }
        }
        Text {
            Layout.row: 1
            Layout.column: 0
            Layout.preferredWidth: 50
            color: mainView.foregroundColor2
            font.pixelSize: 14
            text: "right:"
        }
        TextField {
            id: paddingRightTextField
            Layout.row: 1
            Layout.column: 1
            Layout.preferredWidth: 50
            text: itemPadding.width
            onTextChanged: {
                rootItem.newItemPadding.width = Number(text);
                updatePadding();
            }
        }
        Text {
            Layout.row: 1
            Layout.column: 2
            Layout.preferredWidth: 50
            color: mainView.foregroundColor2
            font.pixelSize: 14
            text: "bottom:"
        }
        TextField {
            id: paddingBottomTextField
            Layout.row: 1
            Layout.column: 3
            Layout.preferredWidth: 50
            text: itemPadding.height
            onTextChanged: {
                rootItem.newItemPadding.height = Number(text);
                updatePadding();
            }
        }
    }

    standardButtons: Dialog.Ok | Dialog.Cancel

    onAccepted: {
        effectManager.setEffectPadding(newItemPadding);
    }

    onRejected: {
        effectManager.setEffectPadding(itemPadding);
    }
}
