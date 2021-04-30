import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import QtQml.Models 2.2
import "../controls"

Item{
    Rectangle {
        id: bg
        color: "#89c2db"
        anchors.fill: parent
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0
            Rectangle {
                id: content

                anchors { horizontalCenter: parent.horizontalCenter; verticalCenter: parent.verticalCenter }

                width: 100
                height: 40
                opacity: dragArea.held ? 0.8 : 1.0
                border.color: "#0797bd"
                border.width: 2
                radius: 5



                Text{
                    text: "urlText"

                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter

                    font.pixelSize: 20
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                CustomButton {
                    id: delBttn
                    customRadius : 5
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    font.pointSize: 25
                    anchors.rightMargin: 85
                    anchors.bottomMargin: 25
                    anchors.leftMargin: 0
                    anchors.topMargin: 0
                    Layout.preferredWidth: 10
                    Layout.maximumWidth: 10
                    btnColorMouseOver: "#78ede7"
                    Layout.maximumHeight: 65535
                    btnColorClicked: "#ec0606"
                    btnColorDefault: "#0797bd"
                    Layout.fillWidth: true
                    Layout.preferredHeight: 10
                    onClicked: {
                        timelineModel.remove(index,1)
                        updateUrlsList()
                    }

                    Text{
                        color: "#ffffff"
                        text: "-"
                        anchors.fill: parent
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        anchors.bottomMargin: 4
                        font.pointSize: 25
                        minimumPixelSize: 12
                    }
                }

            }

            DropFilesArea {
                id : dropFiles2
                x: 427; y: 29
                width: 177
                height: 128
                //onAcceptedF: function() { console.log("1") }
                //onDropedF: function() { console.log("2") }
            }

    }
}


/*##^##
Designer {
    D{i:0;formeditorZoom:1.1;height:480;width:800}
}
##^##*/
