import QtQuick 2.7
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.11
import QtQml.Models 2.2
import "../controls"
import Qt.labs.animation 1.0

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
            //opacity: dragArea.held ? 0.8 : 1.0
            border.color: "#0797bd"
            border.width: 2
            anchors.verticalCenterOffset: 212
            anchors.horizontalCenterOffset: 342
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

            function testF(fileUrls,fileNames){
                console.log("Ventana Settings\nURLS: "+fileUrls+"\nNAMES: "+fileNames)
            }
            multipleFiles: true

            id : dropFiles2
            x: 514; y: 140
            width: 177
            height: 128
            customText: "Arrastre archivos para etiquetar"
            customFunction: (fileUrls,fileNames) => backend.testEtiquetado(fileUrls,etiquetaLabel.text)
        }

        CustomTextField {
            id: etiquetaLabel
            x: 514
            y: 94
            width: 177
            height: 40
            placeholderTextColor: "#ffffff"
            font.family: "Sans Serif"
            placeholderText: "Etiqueta"
            bgColor: "#03a678"
            font.pointSize: 10
            Layout.fillHeight: false
            Layout.fillWidth: true
        }

            Rectangle {
                id: fileListrec
                x: 138
                y: 123
                width: 253
                height: 200
                color: "#ffffff"

            }

        Rectangle {
            id: content2
            x: 473
            y: 432

            //anchors { horizontalCenter: parent.horizontalCenter; verticalCenter: parent.verticalCenter }

            width: 213
            height: 40
            //opacity: dragArea.held ? 0.8 : 1.0
            border.color: "#0797bd"
            border.width: 2
            radius: 5

            color: "#c1e4fd"

            Text{


                text : "TestText"
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                font.pixelSize: 20
                anchors.leftMargin: 8
                anchors.topMargin: 8
                anchors.bottomMargin: 8
                anchors.verticalCenterOffset: 0
            }

            CheckBox {
                id: checkBox
                width: 37
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.leftMargin: 168
                anchors.bottomMargin: 5
                anchors.topMargin: 5
            }
        }

    }

    Connections {
        target: backend

    }
}


/*##^##
Designer {
    D{i:0;formeditorZoom:0.9;height:480;width:800}
}
##^##*/
