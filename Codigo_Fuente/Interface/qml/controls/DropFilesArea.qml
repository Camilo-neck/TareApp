import QtQuick 2.0
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.11
import QtQuick.Dialogs 1.3
import "../pages"

Rectangle {
    id: root
    color: "#aaecff"
    radius: 5
    border.color: "#0797bd"
    border.width: 2

    property var customFunction: function() {}

    function basename(str){
        return (String(str).slice(String(str).lastIndexOf("/")+1)).slice(0, -4)
    }

    function formatUrls(str) {
        return str.replace("file:///","")
    }

    function getFilenames(fileUrls){
        var fileNames = []

        for(var i = 0; i<fileUrls.length; i++){
            var fileName = basename(fileUrls[i])
            fileNames.push(fileName)
            }

        return fileNames
    }


    MouseArea {
        id: chooseFile
        anchors.fill: parent
        onClicked: {
            openFile.open()
        }

        FileDialog {
            id: openFile
            title: "Please Choose a file"
            selectMultiple: true
            nameFilters: ["PDF File (*.pdf)"]

            onAccepted: {

                var fileUrls = openFile.fileUrls
                customFunction(fileUrls,getFilenames(fileUrls))
                //pdfPage.addPDFs(fileUrls,getFilenames(fileUrls))

            }
        }
    }

    DropArea {
        id: dropArea;
        anchors.fill: parent
        onEntered: {
            root.color = "#7dd3ec";
            drag.accept (Qt.LinkAction);
        }
        onDropped: {

            root.color = "#aaecff"
            var fileUrls = drop.urls
            customFunction(fileUrls,getFilenames(fileUrls))

        }
        onExited: {
            root.color = "#aaecff";
        }

        ColumnLayout {
            id: dragDropRow
            anchors.fill: parent
            anchors.rightMargin: 0
            transformOrigin: Item.Center
            Image {
                id: image
                x: 25
                y: 5
                width: 100
                source: "../../images/icons/drag-and-drop.png"
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                Layout.maximumHeight: 90
                Layout.maximumWidth: 100
                Layout.preferredHeight: 100
                Layout.preferredWidth: 200
                Layout.fillWidth: true
                asynchronous: false
                sourceSize.width: 0
                fillMode: Image.PreserveAspectFit
            }
            Label {
                id: dargDropDesc
                x: 10
                text: "Escoja un PDF o arrestrelo aqui"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.family: "Sans Serif"
                font.pointSize: 8
                font.bold: false
                Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                Layout.fillHeight: false
                Layout.fillWidth: true
                Layout.maximumHeight: 20
                Layout.maximumWidth: 200
                Layout.preferredHeight: 50
                Layout.preferredWidth: 1000
           }
       }
    }
}


/*##^##
Designer {
    D{i:0;autoSize:true;height:130;width:160}
}
##^##*/
