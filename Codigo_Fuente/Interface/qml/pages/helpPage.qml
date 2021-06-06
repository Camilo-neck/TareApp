import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.11
import "../controls"
import Qt.labs.qmlmodels 1.0

Item{

    Rectangle {
        id: bg
        color: "#89c2db"
        anchors.fill: parent
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0

        StackLayout {
            id: stackLayout
            anchors.fill: parent
            anchors.rightMargin: 10
            anchors.leftMargin: 10
            anchors.bottomMargin: 10
            anchors.topMargin: 10
            currentIndex: 1

            Item {
                DataFormatTable{
                    x: -10
                    y: 126
                    height: 309
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.leftMargin: 22
                    anchors.rightMargin: 22

                }
            }

            Item {

            }
        }

    }

    Connections {
        target: backend
    }

}

/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:0.66;height:613;width:988}
}
##^##*/
