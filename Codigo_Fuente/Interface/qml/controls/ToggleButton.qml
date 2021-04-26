import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

Button {
    id: toggleBtn

    //CUSTOM PROPERTIES
    property url btnIconSource: "../../images/icons/menu_icon.svg"
    property color btnColorDefault: "#1c1d20"
    property color btnColorMouseOver: "#23272e"
    property color btnColorClicked: "#00a1f1"

    QtObject {
        id: internal

        // MOUSE OVER AND MOUSE CLICK
        property var dynamicColor: if(toggleBtn.down) {
                                       toggleBtn.down ? btnColorClicked : btnColorDefault
                                   } else {
                                       toggleBtn.hovered ? btnColorMouseOver : btnColorDefault
                                   }
    }

    implicitWidth: 70
    implicitHeight: 60
    background: Rectangle {
        id: bgBtn
        color: internal.dynamicColor

        Image {
            id: iconBtn
            source: btnIconSource
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            height: 25
            width: 25
            fillMode: Image.PreserveAspectFit
            visible: false
        }

        ColorOverlay {
            anchors.fill: iconBtn
            source: iconBtn
            color: "#48DEF4"
            antialiasing: false
        }
    }

    anchors.left: parent.left
    anchors.top: parent.top
    anchors.leftMargin: 0
    anchors.topMargin: 0
}
