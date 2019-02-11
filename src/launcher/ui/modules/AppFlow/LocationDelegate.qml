import QtQuick 2.9
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import AppFlow 1.0

ItemDelegate {
    id: wrapper

    signal removeTriggered(int index)
    signal editTriggered(int index, string name, variant position)


    property alias locationName: nameLabel.text
    property alias locationThumbnail: thumbnail.source

    width: parent.width
    contentItem: RowLayout {
        height: 72
        Image {
            id: thumbnail
            Layout.leftMargin: 16
            Layout.rightMargin: 16
            Layout.maximumHeight: 40
            Layout.maximumWidth: 40
            width: 40
            height: 40
            fillMode: Image.Pad
            cache: false
            horizontalAlignment: Image.AlignHCenter
            verticalAlignment: Image.AlignVCenter
        }
        Column {
            Layout.fillWidth: true
            Label {
                id: nameLabel
                Layout.fillWidth: true
                font.family: FontStyle.listFont
                font.pixelSize: 16
            }
            Label {
                id: latitudeLabel
                font.family: FontStyle.listFont
                font.pixelSize: 14
                //TODO: replace toFixed() to locale friendly functions
                //text: qsTr("Latitude: %1 Longitude: %2").arg(wrapper.locationPosition.latitude.toFixed(6)).arg(wrapper.locationPosition.longitude.toFixed(6))
            }
        }

        ToolButton {
            id: itemMenuButton
            width: 72
            height: 72
            contentItem: Image {
                fillMode: Image.Pad
                horizontalAlignment: Image.AlignHCenter
                verticalAlignment: Image.AlignVCenter
                source: "../../icons/more_vert_black_24.png"
            }
            onClicked: itemMenu.open()

            Menu {
                id: itemMenu
                MenuItem {
                    text: qsTr("Edit")
                    onTriggered: wrapper.editTriggered(index, locationName, wrapper.locationPosition)
                }
                MenuItem {
                    text: qsTr("Remove")
                    onTriggered: wrapper.removeTriggered(index)
                }
            }
        }
    }
}
