import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.3
import QtQuick.XmlListModel 2.0

import DemoAppModels 1.0

ApplicationWindow {
    id: root
    visible: true
    width: 600; height: 900

    XmlListModel {
         id: locationModel
         source: "file:///" + applicationDirPath +"/location_model.xml"
         query: "/locations/location"
         XmlRole { name: "title"; query: "string(@title)" }
         XmlRole { name: "thumbnail"; query: "string(@thumbnail)"}
    }

    StackView {
        id: mainAppStack
        anchors.fill : parent
        initialItem: LocationManagement {
            id: locationList
            model: locationModel //ModelFactory.createLocationModel(locationList)
            onSideNavigationClicked: mainSideNavigation.open()
        }
    }

    MainSideNavigationPanel {
        id: mainSideNavigation
        listTopPadding: (mainAppStack.currentItem && mainAppStack.currentItem.hasOwnProperty("toolBarHeight")) ? mainAppStack.currentItem.toolBarHeight : 48
    }
}
