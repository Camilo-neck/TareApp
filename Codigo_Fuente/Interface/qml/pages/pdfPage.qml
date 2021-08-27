import QtQuick 2.0
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.11
import QtQuick.Dialogs 1.3
import Qt.labs.folderlistmodel 2.12
import Qt.labs.animation 1.0
import Qt.labs.platform 1.1
import "../controls"


Item {
    id: pdfPage
    property var urls: pdfsList.urls
    property var pdfBuildUrl: filesArea2.filePaths
    property var pages: pagesList.urls
    property var defaultFolder: String(StandardPaths.standardLocations(StandardPaths.DocumentsLocation)[0]).replace("file:///","")
    property var folderLocation: defaultFolder
    property var folderLocation2: defaultFolder

    function addPDFs(fileUrls,fileNames){
        console.log("FILEURLS:",fileUrls)
        console.log("FILENAMES;",fileNames)
        for(var i in fileUrls){
            urls.push(String(fileUrls[i]))
            pdfsList.createListObject(fileNames[i], fileUrls[i]);
        }
        pdfsList.updateUrlsList()
    }

    function addPages(fileUrl){

        pagesList.clearModel()

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
                        anchors.bottomMargin: 19
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

                            CustomButton {
                                id: selectFolderbtn
                                x: 671
                                width: 29
                                height: 35
                                //text: "📁"
                                anchors.right: parent.right
                                anchors.top: parent.top
                                anchors.bottom: parent.bottom
                                btnColorMouseOver: "#00000000"
                                btnColorClicked: "#00000000"
                                btnColorDefault: "#00000000"

                                onClicked: {
                                    selectFolder1.open()
                                }

                                FolderDialog {
                                    id: selectFolder1
                                    onAccepted: {
                                        folderLocation = String(selectFolder1.folder).replace("file:///","")
                                        folderLabel.text = "Guardar en: "+ folderLocation
                                    }
                                    //selectFolder: true
                                    title: "Select Folder"

                                }
                                highlighted: false
                                Layout.maximumHeight: 65535
                                Layout.preferredHeight: 40
                                font.family: "Sans Serif"
                                Layout.preferredWidth: 250
                                anchors.topMargin: 3
                                Layout.fillWidth: true
                                anchors.bottomMargin: 2
                                anchors.rightMargin: 8
                                font.pointSize: 10
                                Layout.maximumWidth: 70

                                Image {
                                    id: iconBtn
                                    source: "../../images/icons/folder.png"
                                    anchors.verticalCenter: parent.verticalCenter
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    height: 23
                                    width: 29
                                    fillMode: Image.PreserveAspectFit
                                    visible: true
                                }
                            }
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
                                folderLocation = defaultFolder
                                folderLabel.text = "Guardar en: "+defaultFolder
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

                                    backend.mergePdf(urls, folderLocation+"/"+mergePdfText.text)

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
                                    }else{
                                        mergeInfoLabel.text = ""
                                    }
                                }

                            }

                            Layout.maximumWidth: 100
                            Layout.preferredHeight: 40
                            Layout.fillWidth: true
                        }



                    }

                    Label {
                        id: folderLabel
                        x: 10
                        y: 48
                        width: 708
                        height: 21
                        color: "#777777"
                        text: qsTr("Guardar en: "+folderLocation)
                        anchors.left: parent.left
                        anchors.right: dropFiles1.left
                        anchors.top: parent.to
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 10
                        anchors.bottomMargin: 0
                        font.pointSize: 9
                        anchors.rightMargin: 10
                        anchors.topMargin: 48
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

                    Rectangle {
                        id: dropFiles1
                        x: 733
                        width: 162
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.rightMargin: 13
                        anchors.bottomMargin: 8
                        anchors.topMargin: 6

                        color: "#aaecff"
                        radius: 5
                        border.color: "#0797bd"
                        border.width: 2

                        DropFilesArea{
                            id: filesArea
                            anchors.fill: parent

                            multipleFiles: true
                            fileExtensions: ["pdf"]

                            onFileDropped: (fileUrls,fileNames) => {
                                               dropFiles1.color = '#aaecff'
                                               addPDFs(fileUrls,fileNames)}
                            onFileDroppedFailed: () => dropFiles1.color = '#aaecff'
                            onFileEntered: () => dropFiles1.color = '#66c3dd'
                            onFileExited: () => dropFiles1.color = '#aaecff'
                        }

                        ColumnLayout {
                            id: dragDropRow
                            anchors.fill: parent
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
                                Layout.preferredHeight: 50
                                Layout.preferredWidth: 50
                                Layout.fillWidth: false
                                asynchronous: false
                                sourceSize.width: 0
                                fillMode: Image.PreserveAspectFit
                            }
                            Label {
                                id: dargDropDesc
                                x: 10
                                text: "Escoja PDFS o arrastrelos aqui"
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
                        anchors.bottomMargin: 19
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

                            CustomButton {
                                id: selectFolderbtn2
                                x: 671
                                width: 29
                                height: 35
                                //text: "📁"
                                anchors.right: parent.right
                                anchors.top: parent.top
                                anchors.bottom: parent.bottom
                                btnColorClicked: "#00000000"
                                btnColorMouseOver: "#00000000"
                                btnColorDefault: "#00000000"
                                anchors.rightMargin: 8
                                anchors.bottomMargin: 2
                                anchors.topMargin: 3
                                highlighted: false
                                Layout.maximumWidth: 70
                                Layout.fillWidth: true
                                font.pointSize: 10
                                Layout.maximumHeight: 65535
                                Layout.preferredWidth: 250
                                Layout.preferredHeight: 40
                                font.family: "Sans Serif"
                                onPressed: {
                                    selectFolder2.open()
                                }

                                FolderDialog {
                                    id: selectFolder2
                                    title: "Select Folder"
                                    //folder: shortcuts.home
                                    //nameFilters: ["Pdf File (*.pdf)"]
                                    //selectFolder: true
                                    onAccepted: {
                                        folderLocation2 = String(selectFolder2.folder).replace("file:///","")
                                        folderLabel2.text = "Guardar en: "+ folderLocation2
                                    }
                                }

                                Image {
                                    id: iconBtn2
                                    source: "../../images/icons/folder.png"
                                    anchors.verticalCenter: parent.verticalCenter
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    height: 23
                                    width: 29
                                    fillMode: Image.PreserveAspectFit
                                    visible: true
                                }
                            }
                        }

                        CustomButton {
                            id: clearModifyBttn
                            width: 50
                            text: "Limpiar"
                            onClicked: {

                                pagesList.clearModel()
                                dropFiles2.filePaths = []
                                folderLocation2 = defaultFolder
                                folderLabel2.text = "Guardar en: "+defaultFolder

                                //urls = []
                                modifyInfoLabel.text = ""
                                modifyPdfText.text = ""
                                modifyPdfText.placeholderTextColor = "#ffffff"
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
                                if(modifyPdfText.text != "" && pages.length>0){

                                    backend.buildPdf(pdfBuildUrl,pagesList.urls ,folderLocation2+"/"+modifyPdfText.text)

                                    modifyPdfText.placeholderTextColor = "#c3d3e1"
                                    modifyInfoLabel.text = "PDFS MODIFICADO SATISFACTORIAMENTE"
                                    modifyPdfText.text = ""

                                    //index = 1
                                    //urls = []

                                }
                                else{

                                    if(modifyPdfText.text == "") {
                                        modifyPdfText.placeholderTextColor = "#FF0000"
                                    }
                                    if(pages.length<=0){
                                        modifyInfoLabel.text = "DEBE AGREGAR POR LO MENOS 1 PAGINA"
                                    }else{
                                        modifyInfoLabel.text = ""
                                    }

                                }

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

                    Label {
                        id: folderLabel2
                        x: 10
                        y: 63
                        width: 708
                        color: "#777777"
                        text: qsTr("Guardar en: "+folderLocation2)
                        anchors.left: parent.left
                        anchors.right: dropFiles1.left
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 0
                        anchors.topMargin: 48
                        anchors.leftMargin: 10
                        font.pointSize: 9
                        anchors.rightMargin: 10
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
                        height: 100
                        anchors.left: parent.left
                        anchors.right: dropFiles2.left
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 16
                        anchors.bottomMargin: 38
                        anchors.rightMargin: 6
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

                    Rectangle {
                        id: dropFiles2
                        x: 732
                        y: -345
                        width: 163
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.rightMargin: 13
                        anchors.bottomMargin: 8
                        anchors.topMargin: 6

                        color: "#aaecff"
                        radius: 5
                        border.color: "#0797bd"
                        border.width: 2

                        DropFilesArea{
                            id: filesArea2
                            anchors.fill: parent

                            fileExtensions: ["pdf"]
                            multipleFiles: false

                            onFileDropped: (fileUrl,fileName) => {
                                               dropFiles2.color = '#aaecff'
                                               addPages(fileUrl)}
                            onFileDroppedFailed: () => dropFiles2.color = '#aaecff'
                            onFileEntered: () => dropFiles2.color = '#66c3dd'
                            onFileExited: () => dropFiles2.color = '#aaecff'
                        }

                        ColumnLayout {
                            id: dragDropRow2
                            anchors.fill: parent
                            transformOrigin: Item.Center
                            Image {
                                id: image2
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
                                Layout.preferredHeight: 50
                                Layout.preferredWidth: 50
                                Layout.fillWidth: false
                                asynchronous: false
                                sourceSize.width: 0
                                fillMode: Image.PreserveAspectFit
                            }
                            Label {
                                id: dargDropDesc2
                                x: 10
                                text: "Escoja un PDF o arrastrelo aqui"
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


                Rectangle {
                    id: rectangleTop3
                    x: 14
                    y: 29
                    width: 269
                    height: 53
                    color: "#ffffff"
                    radius: 12
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.leftMargin: 12
                    anchors.topMargin: 464
                    GridLayout {
                        anchors.fill: parent
                        anchors.leftMargin: 10
                        rows: 1
                        anchors.rightMargin: 10
                        CustomTextField {
                            id: extractPagesInput
                            width: 590
                            Layout.minimumWidth: 65
                            placeholderTextColor: "#ffffff"
                            Layout.fillHeight: false
                            Layout.fillWidth: true
                            font.family: "Sans Serif"
                            bgColor: "#03a678"
                            font.pointSize: 10
                            placeholderText: "Ingrese las paginas a escojer"
                        }

                        CustomButton {
                            id: extractBtn
                            width: 50
                            text: "Get"
                            onClicked: {
                                pages = extractPagesInput.text.split(' ')
                                console.log(pages)
                                for(var p of pages){
                                    console.log(p)
                                    if(p.indexOf("-")!==-1){
                                        pages.splice(pages.indexOf(p),1)
                                        var splitedP = p.split('-')
                                        var from = Number(splitedP[0])
                                        var to = Number(splitedP[1])
                                        for(var i = from;i<=to;i++){
                                            pages.push(String(i))
                                        }
                                        //pages.splice(pages.indexOf(p),1)
                                    }
                                }
                                console.log(pages)
                                pagesList.extractPages(pages.map((pag) => String(parseInt(pag)-1))).sort((pag1,pag2) => {return parseInt(pag1)-parseInt(pag2)})

                                //"2 11 5 15-18" -> ["2","11","5","15-18"] -> ["1","10","4","14","15","16","17"] -> ["1","4","10","14","15","16","17"]
                                //pagesList.extractPages((extractPagesInput.text.split(' ').map((pag) => String(parseInt(pag)-1))).sort((pag1,pag2) => {return parseInt(pag1)-parseInt(pag2)}))
                            }
                            Layout.fillWidth: true
                            font.family: "Sans Serif"
                            btnColorMouseOver: "#78ede7"
                            btnColorDefault: "#009aeb"
                            Layout.maximumHeight: 65535
                            Layout.preferredHeight: 40
                            Layout.maximumWidth: 70
                            Layout.preferredWidth: 250
                            font.pointSize: 10
                            btnColorClicked: "#ec0606"
                        }
                        columns: 4
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
