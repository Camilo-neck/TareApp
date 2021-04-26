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
        color: "#2c313c"
        anchors.fill: parent
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0

        Rectangle {
            id: rectangleVisible
            color: "#1d2129"
            radius: 12
            anchors.fill: parent
            clip: true
            anchors.rightMargin: 30
            anchors.bottomMargin: 30
            anchors.leftMargin: 30
            anchors.topMargin: 30

            Label {
                id: mergePdfLabel
                y: 5
                height: 33
                color: "#6b737a"
                text: qsTr("Unir PDF")
                anchors.left: parent.left
                anchors.right: parent.right
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                anchors.rightMargin: 8
                anchors.leftMargin: 12
                font.pointSize: 16
            }

            ScrollView {
                id: scrollView
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: rectangleTop.bottom
                anchors.bottom: parent.bottom
                anchors.topMargin: 5
                anchors.bottomMargin: 17
                anchors.rightMargin: 10
                anchors.leftMargin: 10

                Label {
                    id: urlsLabel
                    color: "#ffffff"
                    text: qsTr("")
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: mergeInfoLabel.bottom
                    anchors.bottom: parent.bottom
                    anchors.rightMargin: 10
                    anchors.leftMargin: 10
                    anchors.bottomMargin: 236
                    anchors.topMargin: 10
                    font.pointSize: 15
                }

                Label {
                    id: mergeInfoLabel
                    color: "#8a8a8a"
                    text: qsTr("")
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 10
                    font.pointSize: 9
                    anchors.topMargin: 0
                    anchors.bottomMargin: 274
                    anchors.rightMargin: 10
                }
            }

            Rectangle {
                id: rectangleTop
                x: 62
                y: 35
                height: 69
                color: "#5c667d"
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
                        placeholderText: "Ingrese el nombre el nuevo PDF"
                        Layout.fillWidth: true
                        Layout.fillHeight: false
                    }

                    CustomButton {
                        id: addPdfBtn
                        width: 50
                        text: "Add"
                        btnColorMouseOver: "#26fb4a"
                        btnColorDefault: "#09e13a"
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
        }
    }

    Connections {
        target: backend

    }

}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:800}D{i:5}
}
##^##*/
