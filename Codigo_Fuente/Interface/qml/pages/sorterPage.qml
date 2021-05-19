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

    function changeStack(){
        if (sortRadio.checked){
            return 0
        }else if (tagRadio.checked) {
            return 1
        }
    }

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

    function addFilesFromFolder(folderUrl){

        var fileUrls = backend.getFilesFromFolder(folderUrl)
        console.log("Files>>>>>"+fileUrls)
        if(fileUrls[0] !== "NULL"){
            var fileNames = getFilenames(fileUrls)
            console.log("FILEURLS:",fileUrls)
            console.log("FILENAMES;",fileNames)

            for(var i in fileUrls){
                urls.push(String(fileUrls[i]))
                list1.createListObject(fileNames[i], fileUrls[i]);
            }
            list1.updateUrlsList()
        }


    }

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
            x: 10
            y: 44
            height: 426
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: row.bottom
            anchors.bottom: parent.bottom
            currentIndex: changeStack()
            anchors.bottomMargin: 10
            anchors.leftMargin: 10
            Item {
                Rectangle {
                    id: rectangle3
                    color: "#97d4f0"
                    radius: 12
                    anchors.fill: parent
                    Column {
                        id: columnLayout2
                        anchors.fill: parent
                        anchors.bottomMargin: 10
                        anchors.leftMargin: 10
                        Rectangle {
                            id: rectangleTop1
                            height: 69
                            color: "#03738c"
                            radius: 12
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.leftMargin: 50
                            GridLayout {
                                anchors.fill: parent
                                anchors.leftMargin: 10
                                rows: 1
                                anchors.rightMargin: 10
                                columns: 3
                            }
                            anchors.rightMargin: 50
                            anchors.topMargin: 7
                        }

                        Rectangle {
                            id: rectangleVisible1
                            color: "#ffffff"
                            radius: 12
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.top: rectangleTop1.bottom
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: 31
                            anchors.leftMargin: 50
                            Flickable {
                                id: flickable1
                                anchors.left: parent.left
                                anchors.right: parent.right
                                anchors.top: parent.top
                                anchors.bottom: parent.bottom
                                anchors.bottomMargin: 17
                                anchors.leftMargin: 10
                                ScrollBar.vertical: ScrollBar {
                                }
                                anchors.rightMargin: 10
                                anchors.topMargin: 10
                                clip: true
                                TextArea.flickable: TextArea {
                                    id: textHome1
                                    color: "#000000"
                                    text: ""
                                    font.pixelSize: 14
                                    wrapMode: Text.WordWrap
                                    selectByMouse: true
                                    padding: 10
                                    font.family: "Sans Serif"
                                    selectionColor: "#ff007f"
                                    placeholderTextColor: "#0c1012"
                                    selectedTextColor: "#ffffff"
                                    textFormat: Text.AutoText
                                }
                            }
                            anchors.rightMargin: 50
                            anchors.topMargin: 28
                        }
                        anchors.rightMargin: 10
                        anchors.topMargin: 10
                    }
                }
            }

            Item {
                anchors.fill: parent

                Rectangle {
                    id: rectangle4
                    color: "#97d4f0"
                    radius: 12
                    anchors.fill: parent

                    DropFilesArea {

                        function testF(fileUrls,fileNames){
                            console.log("Ventana Settings\nURLS: "+fileUrls+"\nNAMES: "+fileNames)
                        }
                        //multipleFiles: true

                        id : dropFiles2
                        x: 28; y: 59
                        width: 177
                        height: 128
                        isFolder: true
                        customText: "Escoja o arrastre una carpeta"
                        customFunction: (folderUrl) => {
                                            urls = []
                                            names = []
                                            list1.clearModel()
                                            addFilesFromFolder(folderUrl)
                                            }
                        //backend.testEtiquetado(fileUrls,etiquetaLabel.text)
                    }

                    CustomTextField {
                        id: etiquetaLabel
                        x: 28
                        y: 13
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

                    CustomVerticalList {
                        id: list1
                        x: 226
                        y: 13
                        width: 447
                        height: 399
                        etiqueta: etiquetaLabel.text
                    }

                    CustomButton {
                        id: bttadd
                        x: 679
                        y: 13
                        width: 71
                        height: 42
                        text: "+"
                        Layout.maximumHeight: 65535
                        btnColorDefault: "#009aeb"
                        Layout.fillWidth: true
                        Layout.maximumWidth: 70
                        font.family: "Sans Serif"
                        Layout.preferredWidth: 250
                        Layout.preferredHeight: 40
                        btnColorClicked: "#ec0606"
                        font.pointSize: 10
                        btnColorMouseOver: "#78ede7"
                        onClicked: {
                            list1.createListObject("Test"+j, "url"+j)
                            //console.log(list1.checkBoxValues)
                            j++
                        }
                    }

                    CustomButton {
                        id: bttclear
                        x: 679
                        y: 61
                        width: 71
                        height: 42
                        text: "Clear"
                        Layout.maximumHeight: 65535
                        btnColorDefault: "#009aeb"
                        Layout.fillWidth: true
                        Layout.maximumWidth: 70
                        font.family: "Sans Serif"
                        Layout.preferredWidth: 250
                        Layout.preferredHeight: 40
                        btnColorClicked: "#ec0606"
                        font.pointSize: 10
                        btnColorMouseOver: "#78ede7"
                        onClicked: {
                            j = 1
                            list1.clearModel()
                            urls = []
                        }
                    }

                    CustomButton {
                        id: bttAply
                        x: 28
                        y: 193
                        width: 177
                        height: 42
                        text: "Aplicar etiqueta"
                        btnColorDefault: "#009aeb"
                        Layout.maximumHeight: 65535
                        Layout.fillWidth: true
                        Layout.maximumWidth: 70
                        Layout.preferredHeight: 40
                        Layout.preferredWidth: 250
                        font.family: "Sans Serif"
                        btnColorClicked: "#ec0606"
                        btnColorMouseOver: "#78ede7"
                        font.pointSize: 10
                        onClicked: {
                            backend.tagFiles(list1.getCheckedUrls(),etiquetaLabel.text)
                            list1.clearModel()
                        }
                    }
                }


            }

            anchors.rightMargin: 8
            anchors.topMargin: 3
        }

        Row {
            id: row
            x: 35
            width: 685
            height: 42
            anchors.top: parent.top

            RadioButton {
                id: sortRadio
                text: "Organizar Archivos"
                display: AbstractButton.TextBesideIcon
                checked: true
            }

            RadioButton {
                id: tagRadio
                text: "Etiquetar Archivos"
            }
            anchors.topMargin: 5
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
