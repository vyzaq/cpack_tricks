import QtQuick 2.9
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.3
import QtQml.StateMachine 1.0 as DSM
import DemoAppModels 1.0

import AppFlow 1.0

StackView {
    id: wrapper

    signal locationSelected(int index, variant coordinates)
    signal sideNavigationClicked

    property alias model : locationList.model
    readonly property alias toolBarHeight: toolBar.height

    initialItem: locationListViewer

    Page {
        id: locationListViewer
        header: ToolBar {
            id: toolBar
            RowLayout {
                anchors.fill: parent
                spacing: 16
                ToolButton {
                    contentItem: Image {
                        fillMode: Image.Pad
                        horizontalAlignment: Image.AlignHCenter
                        verticalAlignment: Image.AlignVCenter
                        source: "../../icons/menu_24.png"
                    }
                    onClicked: wrapper.sideNavigationClicked()
                }

                Label {
                    id: titleLabel
                    text: qsTr("Locations")
                    font.pixelSize: 20
                    font.family: FontStyle.titleFont
                    verticalAlignment: Qt.AlignVCenter
                    Layout.fillWidth: true
                }
            }
        }

        ScrollView {
            anchors.fill: parent
            ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
            clip: true
            ListView {
                id: locationList

                signal removeLocation(int index)
                signal editLocation(int index, string name, variant position)

                implicitWidth: parent.width
                model: locationModel
                delegate: LocationDelegate {
                    locationName: title
                    locationThumbnail: thumbnail
                }
            }
        }

        Text {
            id: emptyListText
            anchors.centerIn: parent
            visible: emptyState.active
            text: qsTr("No locations added yet")
            font.pixelSize: 16
            font.family: FontStyle.titleFont
            color: Material.color(Material.Grey, Material.Shade500)
        }

        RoundButton {
            id: addButton
            Material.background: Material.primary
            width: 56
            height: 56
            anchors.margins: 16
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            contentItem: Image {
                fillMode: Image.Pad
                horizontalAlignment: Image.AlignHCenter
                verticalAlignment: Image.AlignVCenter
                source: "../../icons/add_24.png"
            }
        }

    }

    DSM.StateMachine {
        id: locationsDSM

        signal cancel
        signal save

        running: parent.visible
        initialState: quantityCheckState
        DSM.State {
            id: quantityCheckState
            DSM.SignalTransition {
                targetState: emptyState
                signal: quantityCheckState.entered
                guard: locationList.count == 0
            }
            DSM.SignalTransition {
                targetState: showListState
                signal: quantityCheckState.entered
                guard: locationList.count > 0
            }
        }
        DSM.State {
            id: emptyState
        }
        DSM.State {
            id: showListState
        }
        DSM.FinalState {
            id: exitState
        }
    }
}

