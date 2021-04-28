import QtQuick 2.0
import QtQuick.Controls 2.15
import "../controls"
import QtQuick.Layouts 1.11
import QtQuick.Dialogs 1.3
Item {
    id: item1
    property var index: 1
    property var urls: pdfsList.urls
    function basename(str){
        return (String(str).slice(String(str).lastIndexOf("/")+1)).slice(0, -4)
    }
    function addFileToLabel(fileName){
        if(urlsLabel.text === ""){
            urlsLabel.text += "["+index+"] "+fileName
        }else{
            urlsLabel.text += ", ["+index+"] "+fileName
        }
        index++
    }
    function formatUrls(str) {
        return str.replace("file:///","")
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
            id: rectangleVisible
            color: "#03738c"
            radius: 12
            anchors.fill: parent
            anchors.rightMargin: 30
            anchors.bottomMargin: 30
            anchors.leftMargin: 30
            anchors.topMargin: 30
            ScrollView {
                id: scrollView1
                anchors.fill: parent
                Label {
                    id: mergePdfLabel
                    x: 12
                    y: 5
                    height: 33
                    color: "#ffffff"
                    text: qsTr("Unir PDF")
                    anchors.left: parent.left
                    anchors.right: parent.right
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                    font.family: "Sans Serif"
                    anchors.rightMargin: 8
                    anchors.leftMargin: 12
                    font.pointSize: 16
                }
                Rectangle {
                    id: rectangleTop
                    x: 10
                    y: 40
                    height: 69
                    color: "#ffffff"
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.topMargin: 40
                    anchors.rightMargin: 10
                    anchors.leftMargin: 10
                    radius: 12
                    GridLayout {
                        anchors.fill: parent
                        anchors.rightMargin: 10
                        anchors.leftMargin: 10
                        rows: 1
                        columns:  4
                        CustomTextField {
                            id: mergePdfText
                            width: 590
                            font.pointSize: 10
                            font.family: "Sans Serif"
                            placeholderTextColor: "#ffffff"
                            placeholderText: "Ingrese el nombre el nuevo PDF"
                            Layout.fillWidth: true
                            Layout.fillHeight: false
                        }
                        CustomButton {
                            id: clearMergeBtn
                            width: 50
                            text: "Limpiar"
                            font.pointSize: 10
                            font.family: "Sans Serif"
                            Layout.preferredWidth: 250
                            Layout.maximumWidth: 70
                            btnColorMouseOver: "#78ede7"
                            Layout.maximumHeight: 65535
                            btnColorClicked: "#ec0606"
                            btnColorDefault: "#009aeb"
                            Layout.fillWidth: true
                            Layout.preferredHeight: 40
                            onClicked: {
                                pdfsList.clearModel()
                                //urls = []
                                urlsLabel.text = ""
                                mergeInfoLabel.text = ""
                                mergePdfText.text = ""
                                mergePdfText.placeholderTextColor = "#ffffff"
                            }
                        }

                        CustomButton {
                            id: mergePdfBtn1
                            width: 50
                            visible: true
                            text: "Unir"
                            font.pointSize: 10
                            font.family: "Sans Serif"
                            btnColorMouseOver: "#fb9b50"
                            btnColorDefault: "#f98125"
                            Layout.preferredWidth: 250
                            Layout.maximumHeight: 65535
                            onClicked: {
                                if(mergePdfText.text != "" && urls.length >= 2){
                                    backend.mergePdf(urls, mergePdfText.text)
                                    mergePdfText.placeholderTextColor = "#c3d3e1"
                                    mergeInfoLabel.text = "PDFS UNIDOS SATISFACTORIAMENTE"
                                    mergePdfText.text = ""
                                    urlsLabel.text = ""
                                    //index = 1
                                    //urls = []
                                }
                                else{
                                    if(mergePdfText.text == "") {
                                        mergePdfText.placeholderTextColor = "#FF0000"
                                    }
                                    if(urls.length < 2) {
                                        mergeInfoLabel.text = "Debe agregar como minimo 2 PDF para unirlos"
                                    }
                                }
                            }
                            Layout.maximumWidth: 100
                            Layout.preferredHeight: 40
                            Layout.fillWidth: true
                        }
                    }
                }
                Rectangle {
                    id: rectangle
                    x: 10
                    y: 119
                    height: 244
                    color: "#ffffff"
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: rectangleTop.bottom
                    anchors.rightMargin: 10
                    anchors.leftMargin: 10
                    anchors.topMargin: 10
                    radius: 12

                    PdfsList {
                        id: pdfsList
                        x: 16
                        y: 5
                        height: 100
                        anchors.left: parent.left
                        anchors.right: dropAreaBg.left
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.topMargin: 5
                        anchors.bottomMargin: 150
                        anchors.rightMargin: 10
                        anchors.leftMargin: 16
                    }

                    Label {
                        id: urlsLabel
                        x: 10
                        y: 164
                        color: "#0797bd"
                        text: qsTr("")
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: mergeInfoLabel.bottom
                        anchors.bottom: parent.bottom
                        anchors.rightMargin: 10
                        anchors.leftMargin: 10
                        anchors.bottomMargin: 30
                        anchors.topMargin: 20
                        font.pointSize: 15
                    }

                    Label {
                        id: mergeInfoLabel
                        x: 10
                        y: 115
                        color: "#000000"
                        text: qsTr("")
                        anchors.left: parent.left
                        anchors.right: dropAreaBg.left
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 10
                        font.pointSize: 9
                        anchors.topMargin: 115
                        anchors.bottomMargin: 100
                        anchors.rightMargin: 10
                    }

                    Rectangle {
                        id: dropAreaBg
                        x: 721
                        y: 0
                        width: 177
                        color: "#c1e4fd"
                        radius: 10
                        border.color: "#0797bd"
                        border.width: 1
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        clip: urlsLabel.font.weight
                        anchors.rightMargin: 10
                        anchors.bottomMargin: 100
                        anchors.topMargin: 0

                        MouseArea {
                            id: chooseFile
                            anchors.fill: parent
                            onClicked: {
                                mergeInfoLabel.text = ""
                                openFile.open()
                            }

                            FileDialog {
                                id: openFile
                                title: "Please Choose a file"
                                selectMultiple: true
                                nameFilters: ["PDF File (*.pdf)"]

                                onAccepted: {

                                    var fileUrls = openFile.fileUrls

                                    for(var i = 0; i<fileUrls.length; i++){
                                        var fileUrl = fileUrls[i]
                                        var fileName = basename(fileUrl)
                                        urls.push(formatUrls(String(fileUrl)))
                                        pdfsList.createListObject(fileName, fileUrl);

                                        //addFileToLabel(fileName)
                                    }

                                }
                            }
                        }

                        DropArea {
                            id: dropArea;
                            x: -550
                            y: 0
                            anchors.fill: parent
                            Layout.fillHeight: false
                            Layout.maximumHeight: 75
                            Layout.maximumWidth: 80
                            Layout.preferredHeight: 100
                            Layout.preferredWidth: 200
                            Layout.fillWidth: true
                            onEntered: {
                                drag.accept (Qt.LinkAction);
                            }
                            onDropped: {
                                for(var i = 0; i<drop.urls.length; i++){
                                    var fileUrl = drop.urls[i]
                                    var fileName = basename(fileUrl)
                                    urls.push(formatUrls(fileUrl))
                                    //addFileToLabel(basename(drop.urls[i]))
                                    pdfsList.createListObject(fileName, fileUrl);
                                }
                                pdfsList.updateUrlsList()

                            }
                            onExited: {
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
                }

            }
        }
    }
    Connections {
        target: backend

    }
}


/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:0.75;height:613;width:988}
}
##^##*/
