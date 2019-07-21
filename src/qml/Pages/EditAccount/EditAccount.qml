// Copyright 2019 miruka
// This file is part of harmonyqml, licensed under LGPLv3.

import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import "../../Base"
import "../../utils.js" as Utils

HPage {
    id: editAccount
    Component.onCompleted: shortcuts.flickTarget = flickable

    property int avatarPreferredSize: 256

    property string userId: ""
    readonly property var userInfo: users.find(userId)
    readonly property bool ready: userInfo && ! userInfo.loading

    hideHeaderUnderHeight: avatarPreferredSize
    headerLabel.text:
        qsTr("Account settings for %1").arg(
            Utils.coloredNameHtml(userInfo ? userInfo.displayName : "", userId)
        )

    HRectangle {
        color: ready ? theme.box.background : "transparent"
        Behavior on color { HColorAnimation {} }

        Layout.alignment: Qt.AlignCenter

        Layout.maximumWidth: Math.min(parent.width, 640)
        Layout.preferredWidth:
            pageStack.isWide ? parent.width : avatarPreferredSize

        Layout.preferredHeight: childrenRect.height

        Loader {
            width: parent.width
            source: ready ? "Profile.qml" : "../../Base/HBusyIndicator.qml"
        }
    }
}
