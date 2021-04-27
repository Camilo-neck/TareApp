import QtQuick 2.0
import QtQuick.Controls 2.15
import "../controls"
import QtQuick.Layouts 1.11
import QtQuick.Dialogs 1.3


Item {
    property var i: 1
    property var urls: []
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
                        columns:  3
                        CustomTextField {
                            id: mergePdfText
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

                                    function basename(str){
                                        return (String(str).slice(String(str).lastIndexOf("/")+1))
                                    }

                                    var fileName = basename(fileOpen.fileUrl)


                                    if(urlsLabel.text == ""){
                                        urlsLabel.text += "["+i+"] "+fileName
                                    }else{
                                        urlsLabel.text += ", ["+i+"] "+fileName
                                    }

                                    i++

                                    var url = fileOpen.fileUrl
                                    urls.push(url)

                                }
                            }

                        }

                        CustomButton {
                            id: mergePdfBtn1
                            width: 50
                            text: "Unir"
                            btnColorMouseOver: "#fb9b50"
                            btnColorDefault: "#f98125"
                            Layout.preferredWidth: 250
                            Layout.maximumHeight: 65535
                            onClicked: {
                                if(mergePdfText.text != "" && urls.length >= 2){
                                    mergePdfText.placeholderTextColor = "#c3d3e1"
                                    mergeInfoLabel.text = ""
                                    backend.mergePdf(urls, mergePdfText.text)
                                    mergePdfText.text = ""
                                    urlsLabel.text = ""
                                    i = 1
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
                            color: "#000000"
                            text: qsTr("")
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.top: parent.top
                            anchors.bottom: parent.bottom
                            anchors.rightMargin: 10
                            anchors.leftMargin: 10
                            anchors.bottomMargin: 171
                            anchors.topMargin: 5
                            font.pointSize: 15

                            DropArea {
                                id: dropArea;
                                x: 0
                                y: -84
                                anchors.fill: parent
                                anchors.rightMargin: 0
                                anchors.bottomMargin: 0
                                anchors.leftMargin: 0
                                anchors.topMargin: 0
                                onEntered: {
                                    drag.accept (Qt.LinkAction);
                                }
                                onDropped: {
                                    urls = []

                                    function basename(str){
                                        return (String(str).slice(String(str).lastIndexOf("/")+1))
                                    }

                                    var fileNames = ""
                                    for(var i = 0; i<drop.urls.length; i++){
                                        urls.push(drop.urls[i])
                                        fileNames += basename(drop.urls[i]) + " "
                                    }

                                    urlsLabel.text = fileNames
                                }
                                onExited: {
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
                            anchors.topMargin: 0
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
    D{i:0;autoSize:true;height:480;width:800}D{i:3}
}
##^##*/
