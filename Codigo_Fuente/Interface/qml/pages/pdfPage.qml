import QtQuick 2.0
import QtQuick.Controls 2.15
import "../controls"
import QtQuick.Layouts 1.11
import QtQuick.Dialogs 1.3


Item {
    property var index: 1
    property var urls: []
    function basename(str){
        return (String(str).slice(String(str).lastIndexOf("/")+1))
    }
    function addFileToLabel(fileName){
        if(urlsLabel.text == ""){
            urlsLabel.text += "["+index+"] "+fileName
        }else{
            urlsLabel.text += ", ["+index+"] "+fileName
        }
        index++
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
            clip: true
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
                            placeholderTextColor: "#ffffff"
                            placeholderText: "Ingrese el nombre el nuevo PDF"
                            Layout.fillWidth: true
                            Layout.fillHeight: false
                        }


                        CustomButton {
                            id: addPdfBtn
                            width: 50
                            text: "Add"
                            btnColorMouseOver: "#78ede7"
                            btnColorDefault: "#009aeb"
                            btnColorClicked: "#4ef573"
                            Layout.maximumHeight: 65535
                            Layout.maximumWidth: 50
                            Layout.fillWidth: true
                            Layout.preferredHeight: 40
                            Layout.preferredWidth: 250

                            onClicked: {
                                mergeInfoLabel.text = ""
                                fileOpen.open()
                            }

                            FileDialog {
                                id: fileOpen
                                title: "Please Choose a file"
                                selectMultiple: false
                                nameFilters: ["PDF File (*.pdf)"]

                                onAccepted: {

                                    var url = fileOpen.fileUrl
                                    var fileName = basename(url)
                                    addFileToLabel(fileName)
                                    urls.push(url)

                                }
                            }

                        }

                        CustomButton {
                            id: clearMergeBtn
                            width: 50
                            text: "Clear"
                            Layout.preferredWidth: 250
                            Layout.maximumWidth: 50
                            btnColorMouseOver: "#fc3636"
                            Layout.maximumHeight: 65535
                            btnColorClicked: "#ec0606"
                            btnColorDefault: "#fa1212"
                            Layout.fillWidth: true
                            Layout.preferredHeight: 40
                            onClicked: {
                                urls = []
                                index = 1
                                urlsLabel.text = ""
                                mergeInfoLabel.text = ""
                                mergePdfText.text = ""
                            }
                        }

                        CustomButton {
                            id: mergePdfBtn1
                            width: 50
                            visible: true
                            text: "Unir"
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
                                    index = 1
                                    urls = []

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
                    height: 200
                    color: "#ffffff"
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: rectangleTop.bottom
                    anchors.rightMargin: 10
                    anchors.leftMargin: 10
                    anchors.topMargin: 10
                    radius: 12

                    ScrollView {
                        id: scrollView
                        anchors.fill: parent

                        Label {
                            id: urlsLabel
                            color: "#0797bd"
                            text: qsTr("")
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.top: parent.top
                            anchors.bottom: parent.bottom
                            anchors.rightMargin: 10
                            anchors.leftMargin: 10
                            anchors.bottomMargin: 118
                            anchors.topMargin: 5
                            font.pointSize: 15

                            DropArea {
                                id: dropArea;
                                y: -84
                                anchors.left: parent.left
                                anchors.right: parent.right
                                anchors.top: parent.top
                                anchors.bottom: parent.bottom
                                anchors.leftMargin: 600
                                anchors.rightMargin: 0
                                anchors.bottomMargin: 0
                                anchors.topMargin: 0
                                onEntered: {
                                    drag.accept (Qt.LinkAction);
                                }
                                onDropped: {

                                    for(var i = 0; i<drop.urls.length; i++){
                                        urls.push(drop.urls[i])
                                        addFileToLabel(basename(drop.urls[i]))
                                    }

                                }
                                onExited: {
                                }

                                Rectangle {
                                    id: rectangle1
                                    x: 0
                                    y: 0
                                    color: "#c1e4fd"
                                    radius: 10
                                    border.color: "#0797bd"
                                    border.width: 1
                                    anchors.left: parent.left
                                    anchors.right: parent.right
                                    anchors.top: parent.top
                                    anchors.bottom: parent.bottom
                                    anchors.rightMargin: 0
                                    anchors.leftMargin: 0
                                    anchors.bottomMargin: 0
                                    anchors.topMargin: 0

                                    Image {
                                        id: image
                                        anchors.left: parent.left
                                        anchors.right: parent.right
                                        anchors.top: parent.top
                                        anchors.bottom: parent.bottom
                                        source: "../../images/icons/drag-and-drop.png"
                                        anchors.rightMargin: 19
                                        anchors.leftMargin: 20
                                        anchors.bottomMargin: 13
                                        anchors.topMargin: 13
                                        fillMode: Image.PreserveAspectFit
                                    }
                                }
                            }
                        }

                        Label {
                            id: mergeInfoLabel
                            color: "#000000"
                            text: qsTr("")
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.top: urlsLabel.bottom
                            anchors.bottom: parent.bottom
                            anchors.leftMargin: 10
                            font.pointSize: 9
                            anchors.topMargin: -32
                            anchors.bottomMargin: 150
                            anchors.rightMargin: 10
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
    D{i:0;autoSize:true;height:480;width:800}D{i:10}D{i:17}D{i:16}D{i:15}
}
##^##*/
