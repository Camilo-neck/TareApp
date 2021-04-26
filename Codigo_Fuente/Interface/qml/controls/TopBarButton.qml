import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

Button {
    id:btnTopBar 

    //CUSTOM PROPERTIES
    property url btnIconSource: "../../images/icons/icon_minimize.png"
    property color btnColorDefault: "#48DEF5"
    property color btnColorMouseOver: "#F53623"
    property color btnColorClicked: "#FF2500"

    QtObject {
        id: internal

        // MOUSE OVER AND MOUSE CLICK
        property var dynamicColor: if(btnTopBar.down) {
                                       btnTopBar.down ? btnColorClicked : btnColorDefault
                                   } else {
                                       btnTopBar.hovered ? btnColorMouseOver : btnColorDefault
                                   }
    }

    width: 35
    height: 35
    background: Rectangle {
        id: bgBtn
        color: "#1c1d20"

        Image {
            id: iconBtn
            source: btnIconSource
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            height: 20
            width: 20
            visible: false
            fillMode: Image.PreserveAspectFit
            antialiasing: false
        }

        ColorOverlay {
            anchors.fill: iconBtn
            source: iconBtn
            color: internal.dynamicColor
            antialiasing: false
        }
    }

    anchors.left: parent.left
    anchors.top: parent.top
    anchors.leftMargin: 0
    anchors.topMargin: 0
}

/*##^##
Designer {
    D{i:0;height:35;width:35}
}
##^##*/
