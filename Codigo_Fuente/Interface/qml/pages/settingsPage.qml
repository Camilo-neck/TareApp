import QtQuick 2.7
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.11
import QtQml.Models 2.2
import "../controls"
import Qt.labs.animation 1.0

Item{

    property var j : 1
    property var urls : list1.urls
    property var names : list1.names

    function addFiles(fileUrls,fileNames){

        //urls = []
        //list1.clearModel()

        for(var i in fileUrls){
            urls.push(String(fileUrls[i]))
            list1.createListObject(fileNames[i], fileUrls[i]);
        }
        list1.updateUrlsList()
    }

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
            //opacity: dragArea.held ? 0.8 : 1.0
            border.color: "#0797bd"
            border.width: 2
            anchors.verticalCenterOffset: -212
            anchors.horizontalCenterOffset: -362
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
                id: bttn1
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




        Rectangle {
            id: content2
            y: 54

            //anchors { horizontalCenter: parent.horizontalCenter; verticalCenter: parent.verticalCenter }

            width: 447
            height: 29
            //opacity: dragArea.held ? 0.8 : 1.0
            border.color: "#0797bd"
            border.width: 2
            anchors.left: parent.left
            anchors.leftMargin: 8
            radius: 5

            color: "#c1e4fd"

            Text{
                width: 175


                text : "TestText"
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                font.pixelSize: 13
                verticalAlignment: Text.AlignTop
                anchors.leftMargin: 8
                anchors.topMargin: 8
                anchors.bottomMargin: 8
                anchors.verticalCenterOffset: 0
            }

            CheckBox {
                id: checkBox
                width: 19
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.leftMargin: 420
                font.pointSize: 4
                checkable: true
                checkState: Qt.Unchecked
                anchors.bottomMargin: 6
                anchors.topMargin: 6
                indicator.width: 20
                indicator.height: 20
            }
        }

        Rectangle {
            id: bg2
            visible: true
            color: "#d1e5ed"
            radius: 8
            anchors.fill: parent
            anchors.leftMargin: 160
            anchors.topMargin: 99
            anchors.rightMargin: 292
            anchors.bottomMargin: 100
        }
    }

    Connections {
        target: backend

    }
}


/*##^##
Designer {
    D{i:0;formeditorZoom:0.9;height:480;width:840}
}
##^##*/
