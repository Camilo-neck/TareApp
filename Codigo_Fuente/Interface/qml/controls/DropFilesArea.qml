import QtQuick 2.0
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.11
import QtQuick.Dialogs 1.3
import "../pages"

Rectangle {
    id: root

    //property var onAcceptedF: function() {}
    //property var onDropedF: function() {}

    function basename(str){
        return (String(str).slice(String(str).lastIndexOf("/")+1)).slice(0, -4)
    }

    function formatUrls(str) {
        return str.replace("file:///","")
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
                //console.log(String(openFile.fileUrls))

                var fileUrls = openFile.fileUrls
                var fileNames = []
                for(var i = 0; i<fileUrls.length; i++){

                    var fileUrl = fileUrls[i]
                    var fileName = basename(fileUrl)


                    fileNames.push(fileName)

                    }

                item1.oA(fileUrls,fileNames)
            }
        }
    }

    DropArea {
        id: dropArea;
        anchors.fill: parent
        onEntered: {
            root.color = "gray";
            drag.accept (Qt.LinkAction);
        }
        onDropped: {
            var fileUrls = drop.urls
            var fileNames = []
            for(var i = 0; i<fileUrls.length; i++){

                var fileUrl = fileUrls[i]
                var fileName = basename(fileUrl)


                fileNames.push(fileName)

                }

            item1.oA(fileUrls,fileNames)
            root.color = "white"
        }
        onExited: {
            root.color = "white";
        }

        ColumnLayout {
            id: dragDropRow
            anchors.fill: parent
            transformOrigin: Item.Center
            Image {
                id: image
                x: 25
                y: 5
                width: 100
                source: "../../images/icons/drag_drop_icon.svg"
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
                text: "Choose a file or drag it here"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.family: "Sans Serif"
                font.pointSize: 10
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
