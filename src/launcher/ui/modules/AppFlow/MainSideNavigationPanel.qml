import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.3

import AppFlow 1.0

Popup {
    id: wrapper

    property alias importAction : importControl.action
    property int listTopPadding: 8

    parent: Overlay.overlay
    x: 0
    y: 0
    width: 400
    height: root.height
    padding: 0
    modal: true
    enter: Transition {
        NumberAnimation {
            duration: 150
            property: "x"
            from: -wrapper.width
            to: 0
            easing.type: Easing.OutSine
        }
    }
    exit: Transition {
        NumberAnimation {
            duration: 150
            property: "x"
            from: 0
            to: -wrapper.width
            easing.type: Easing.OutSine
        }
    }

    Column {
        id: actionsLayout
        anchors {
            fill: parent
            topMargin: wrapper.listTopPadding
        }
        ItemDelegate {
            id: importControl
            anchors {
                left: parent.left
                right: parent.right
            }

            font {
                family: FontStyle.listFont
                pixelSize: 16
            }
        }
    }
}
