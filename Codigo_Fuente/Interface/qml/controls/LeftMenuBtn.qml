import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

Button {
    id: leftMenuBtn
    text:  qsTr("Left Menu Text")

    //CUSTOM PROPERTIES
    property url btnIconSource: "../../images/icons/home_icon.svg"
    property color btnColorDefault: "#04bfbf"
    property color btnColorMouseOver: "#23272e"
    property color btnColorClicked: "#00a1f1"
    property int iconWidth: 18
    property int iconHeight: 18
    property color activeMenuColor: "#dc560a"
    property color activeMenuColorRight : "#89c2db"
    property bool isActiveMenu: false

    QtObject {
        id: internal

        // MOUSE OVER AND MOUSE CLICK
        property var dynamicColor: if(leftMenuBtn.down) {
                                       leftMenuBtn.down ? btnColorClicked : btnColorDefault
                                   } else {
                                       leftMenuBtn.hovered ? btnColorMouseOver : btnColorDefault
                                   }
    }

    implicitWidth: 250
    implicitHeight: 60
    background: Rectangle {
        id: bgBtn
        color: internal.dynamicColor

        Rectangle {
            anchors {
                top: parent.top
                left: parent.left
                bottom: parent.bottom
            }
            color: activeMenuColor
            width: 4
            visible: isActiveMenu
        }

        Rectangle {
            anchors {
                top: parent.top
                right: parent.right
                bottom: parent.bottom
            }
            color: activeMenuColorRight
            width: 5
            visible: isActiveMenu
        }

    }
    contentItem: Item {
        id: content
        anchors.fill: parent
        Image {
            id: iconBtn
            source: btnIconSource
            sourceSize.height: 25
            sourceSize.width: 25
            anchors.leftMargin: 26
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            height: iconWidth
            width: iconHeight
            fillMode: Image.PreserveAspectFit
            visible: false
            antialiasing: true
        }

        ColorOverlay {
            anchors.fill: iconBtn
            source: iconBtn
            color: "#15d8ee"
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            antialiasing: true
            width: iconWidth
            height: iconHeight
        }

        Text {
            color: "#ffffff"
            id: texto
            text: leftMenuBtn.text
            font: leftMenuBtn.font
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 75
        }
    }
}
/*##^##
Designer {
    D{i:0;formeditorZoom:1.25;height:60;width:250}
}
##^##*/
