import QtQuick 2.0
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.11
import QtQuick.Dialogs 1.3
import Qt.labs.folderlistmodel 2.12
import Qt.labs.animation 1.0
import "../controls"


Item {
    id: pdfPage
    property var urls: pdfsList.urls
    property var pages: pagesList.urls

    /*
    function formatUrls(str) {
        return str.replace("file:///","")
    }
    */

    function addPDFs(fileUrls,fileNames){
        for(var i in fileUrls){
            urls.push(String(fileUrls[i]))
            pdfsList.createListObject(fileNames[i], fileUrls[i]);
        }
        pdfsList.updateUrlsList()
    }

    function addPages(fileUrl){
        var numPages = backend.getPages(fileUrl[0])
        //console.log(numPages)
        for(var i = 0; i<numPages;i++){
            //urls.push(formatUrls(String(fileUrls[i])))
            var pageName = "PAG "+(i+1)

            pagesList.createListObject(pageName, i);
        }
        pagesList.updateUrlsList()
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
                clip: true
                Label {
                    id: mergePdfLabel
                    x: 12
                    y: 5
                    height: 33
                    color: "#ffffff"
                    text: qsTr("Unir PDFs")
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
                            placeholderText: "Ingrese el nombre del nuevo PDF"
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
                    height: 107
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
                        anchors.right: dropFiles1.left
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.topMargin: 8
                        anchors.bottomMargin: 38
                        anchors.rightMargin: 10
                        anchors.leftMargin: 16

                        Label {
                            id: mergeInfoLabel
                            x: 0
                            y: 60
                            width: 756
                            color: "#000000"
                            text: qsTr("")
                            anchors.left: parent.left
                            anchors.right: dropFiles1.left
                            anchors.top: parent.top
                            anchors.bottom: parent.bottom
                            anchors.leftMargin: 0
                            font.pointSize: 9
                            anchors.topMargin: 63
                            anchors.bottomMargin: -31
                            anchors.rightMargin: 10
                        }
                    }

                    DropFilesArea {
                        id : dropFiles1
                        x: 782
                        width: 113
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.rightMargin: 13
                        anchors.bottomMargin: 8
                        anchors.topMargin: 6
                        customText: "Escoja un PDF o arrastrelo aqui"
                        fileExtensions: ["pdf"]
                        //Sintax
                        //customFunction: (fileUrls,fileNames) => myFunction(fileUrls,fileNames)
                        customFunction: (fileUrls,fileNames) => addPDFs(fileUrls,fileNames)
                    }
                }

                Label {
                    id: mergePdfLabel1
                    x: 19
                    y: 232
                    height: 33
                    color: "#ffffff"
                    text: qsTr("Modificar PDF")
                    anchors.left: parent.left
                    anchors.right: parent.right
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                    anchors.leftMargin: 10
                    font.pointSize: 16
                    font.family: "Sans Serif"
                    anchors.rightMargin: 10
                }

                Rectangle {
                    id: rectangleTop2
                    x: 13
                    y: 31
                    height: 69
                    color: "#ffffff"
                    radius: 12
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.leftMargin: 10
                    GridLayout {
                        anchors.fill: parent
                        anchors.leftMargin: 10
                        CustomTextField {
                            id: modifyPdfText
                            width: 590
                            bgColor: "#03a678"
                            placeholderText: "Ingrese el nombre el nuevo PDF"
                            Layout.fillWidth: true
                            font.pointSize: 10
                            Layout.fillHeight: false
                            placeholderTextColor: "#ffffff"
                            font.family: "Sans Serif"
                        }

                        CustomButton {
                            id: clearModifyBttn
                            width: 50
                            text: "Limpiar"
                            onClicked: {
                                //pdfsList.clearModel()
                                //urls = []
                                //mergeInfoLabel.text = ""
                                //mergePdfText1.text = ""
                                //mergePdfText1.placeholderTextColor = "#ffffff"
                            }
                            btnColorMouseOver: "#78ede7"
                            btnColorDefault: "#009aeb"
                            Layout.fillWidth: true
                            Layout.preferredHeight: 40
                            font.pointSize: 10
                            Layout.maximumWidth: 70
                            Layout.maximumHeight: 65535
                            btnColorClicked: "#ec0606"
                            font.family: "Sans Serif"
                            Layout.preferredWidth: 250
                        }

                        CustomButton {
                            id: modifyPdfBtn
                            width: 50
                            visible: true
                            text: "Modificar"
                            onClicked: {
                                console.log(pagesList.urls)

                            }
                            btnColorMouseOver: "#fb9b50"
                            btnColorDefault: "#f98125"
                            Layout.fillWidth: true
                            Layout.preferredHeight: 40
                            font.pointSize: 10
                            Layout.maximumWidth: 100
                            Layout.maximumHeight: 65535
                            font.family: "Sans Serif"
                            Layout.preferredWidth: 250
                        }
                        columns: 4
                        anchors.rightMargin: 10
                        rows: 1
                    }
                    anchors.topMargin: 271
                    anchors.rightMargin: 10
                }

                Rectangle {
                    id: rectangle2
                    x: 10
                    y: 346
                    height: 107
                    color: "#ffffff"
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: rectangleTop.bottom
                    anchors.rightMargin: 10
                    anchors.leftMargin: 10
                    anchors.topMargin: 242
                    radius: 12

                    PdfsList {
                        id: pagesList
                        x: -24
                        y: -373
                        width: 755
                        height: 100
                        anchors.left: parent.left
                        anchors.right: dropFiles1.left
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 16
                        anchors.bottomMargin: 38
                        anchors.rightMargin: 10
                        Label {
                            id: modifyInfoLabel
                            x: 0
                            y: 60
                            width: 756
                            color: "#000000"
                            text: qsTr("")
                            anchors.left: parent.left
                            anchors.right: dropFiles1.left
                            anchors.top: parent.top
                            anchors.bottom: parent.bottom
                            anchors.leftMargin: 0
                            font.pointSize: 9
                            anchors.bottomMargin: -31
                            anchors.rightMargin: 10
                            anchors.topMargin: 63
                        }
                        anchors.topMargin: 8
                    }

                    DropFilesArea {
                        id : dropFiles2
                        x: 792
                        y: -345
                        width: 113
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.rightMargin: 13
                        anchors.bottomMargin: 8
                        anchors.topMargin: 6
                        customText: "Escoja un PDF o arrastrelo aqui"
                        fileExtensions: ["pdf"]
                        //Sintax
                        //customFunction: (fileUrls,fileNames) => myFunction(fileUrls,fileNames)
                        customFunction: (fileUrl,fileName) => {addPages(fileUrl)}
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
    D{i:0;autoSize:true;height:613;width:988}
}
##^##*/
