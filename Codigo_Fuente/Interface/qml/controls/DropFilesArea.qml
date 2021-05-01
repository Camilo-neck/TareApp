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
    property var fileExtensions: ["ALL"]
    property var customText: "Select a file or drop it here"

    function basename(str){
        var extensionLength = - (getExtension(str).length +1)
        return (String(str).slice(String(str).lastIndexOf("/")+1)).slice(0, extensionLength)
    }

    function getExtension(str){
        return str.split('.').pop();
    }

    function getFilenames(fileUrls){
        return fileUrls.map((url) => basename(url))
    }

    function getNameFilters(){
        if (!(fileExtensions.includes("ALL"))){
            var nameFilers = "("
            fileExtensions.forEach(ext => {nameFilers += "*."+ext+" "})
            nameFilers += ")"
            return nameFilers
        }

        return "(*)"
    }

    /*
    function getNF(){
        var nf = fileExtensions.reduce((acum, ext) => (acum += '*.'+ext+' '))
        console.log(nf)
        return `(${nf})`
    }
    */


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

            nameFilters: [getNameFilters()]

            onAccepted: {

                var fileUrls = openFile.fileUrls.map((url) => url.replace("file:///",""))
                customFunction(fileUrls,getFilenames(fileUrls))

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

            /*
            for(var j in drop.urls){
                fileUrls.push(drop.urls[j])
            }
            */

            var fileUrls = drop.urls.map((url) => url.replace("file:///",""))
            /*

            var realfileUrls = []

            if (!(fileExtensions.includes("ALL"))){

                for(var i = 0;i<fileUrls.length;i++){

                    var ext = getExtension(fileUrls[i])
                    if(fileExtensions.includes(ext)){
                        realfileUrls.push(fileUrls[i])
                    }
                }
            }else{
                realfileUrls = fileUrls
            }

            */

            if (!(fileExtensions.includes("ALL"))){
                fileUrls = fileUrls.filter((url) => fileExtensions.includes(getExtension(url)))
            }

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
                x: 30
                y: 5
                width: 100
                height: 50
                horizontalAlignment: Image.AlignHCenter
                verticalAlignment: Image.AlignVCenter
                source: "../../images/icons/drag-and-drop.png"
                Layout.fillHeight: false
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                Layout.maximumHeight: 90
                Layout.maximumWidth: 100
                Layout.preferredHeight: 100
                Layout.preferredWidth: 200
                Layout.fillWidth: false
                asynchronous: false
                sourceSize.width: 0
                fillMode: Image.PreserveAspectFit
            }
            Label {
                id: dargDropDesc
                x: 10
                text: customText
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
    D{i:0;autoSize:true;formeditorZoom:1.5;height:130;width:160}
}
##^##*/
