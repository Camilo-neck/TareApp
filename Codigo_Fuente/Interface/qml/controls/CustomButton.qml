import QtQuick 2.15
import QtQuick.Controls 2.15

Button {
    id: customBtn

    //CUSTOM PROPERTIES
    property color btnColorDefault: "#388de9"
    property color btnColorMouseOver: "#55aaff"
    property color btnColorClicked: "#3f7ebd"
    property int customRadius : 12

    QtObject {
        id: internal

        // MOUSE OVER AND MOUSE CLICK
        property var dynamicColor:
            if(customBtn.down) {
               customBtn.down ? btnColorClicked : btnColorDefault
           } else {
               customBtn.hovered ? btnColorMouseOver : btnColorDefault
           }
    }

    contentItem: Item {
        id: content
        Text {
            id: btnText
            text: customBtn.text
            font: customBtn.font
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            color: "#ffffff"
        }
    }

    background: Rectangle {
        id: bg
        color: internal.dynamicColor
        anchors.fill:parent
        radius: customRadius

    }
}

/*##^##
Designer {
    D{i:0;height:55;width:150}
}
##^##*/
