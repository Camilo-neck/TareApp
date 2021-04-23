import QtQuick 2.0
import QtQuick.Controls 2.15

Item {
    Rectangle {
        id: bg
        color: "#2c313c"
        anchors.fill: parent

        Label {
            id: label
            x: 371
            y: 217
            width: 107
            height: 25
            color: "#ffffff"
            text: qsTr("SETTINGS PAGE")
            anchors.verticalCenter: parent.verticalCenter
            font.pointSize: 14
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }

}
