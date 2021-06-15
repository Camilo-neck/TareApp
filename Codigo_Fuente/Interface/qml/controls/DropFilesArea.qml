import QtQuick 2.0
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.11
import QtQuick.Dialogs 1.3
import "../pages"


DropArea {
    id: dropArea
    //anchors.fill: parent
    property var fileExtensions: ["ALL"]
    property var filePaths: ""
    property var multipleFiles: false
    property var isFolder: false

    property var onFileDropped: function() {}
    property var onFileEntered: function() {}
    property var onFileExited: function() {}

    property var onFileDroppedFailed: function() {}
    property var onFileSelected: onFileDropped

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
        return !(fileExtensions.includes("ALL")) ? fileExtensions.map((ext) => ext = `*.${ext}`).join(' ') : "(*)"
    }

    onEntered: {
        drag.accept (Qt.LinkAction);
        onFileEntered()
    }
    onDropped: {
        if(!isFolder){

            var fileUrls = drop.urls.map((url) => url.replace("file:///",""))

            if(fileUrls.length>1 && multipleFiles==false){onFileDroppedFailed()}

            else{
                filePaths = fileUrls

                if (!(fileExtensions.includes("ALL"))){
                    fileUrls = fileUrls.filter((url) => fileExtensions.includes(getExtension(url)))
                }

                onFileDropped(fileUrls,getFilenames(fileUrls))
            }
        }else{
            var folderUrl = drop.urls
            if(folderUrl.length>1 && multipleFiles==false){onFileDroppedFailed()}
            else{
                folderUrl = folderUrl[0].replace("file:///","")
                onFileDropped(folderUrl)
            }

        }
    }

    onExited: {
        onFileExited()
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
            selectMultiple: multipleFiles
            selectFolder: isFolder

            nameFilters: [getNameFilters()]

            onAccepted: {
                if(!isFolder){
                    var fileUrls = openFile.fileUrls.map((url) => url.replace("file:///",""))
                    filePaths = fileUrls
                    onFileSelected(fileUrls,getFilenames(fileUrls))
                }else{
                    var folderUrl = String(openFile.folder).replace("file:///","")
                    onFileSelected(folderUrl)
                }
            }
        }
    }
}



/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:1.5;height:130;width:160}
}
##^##*/
