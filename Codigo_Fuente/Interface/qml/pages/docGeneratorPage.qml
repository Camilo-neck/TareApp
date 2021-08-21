import QtQuick 2.14
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.11
import QtQuick.Dialogs 1.3
import Qt.labs.folderlistmodel 2.12
import Qt.labs.animation 1.0
import Qt.labs.platform 1.1
import QtGraphicalEffects 1.15
import "../controls"



StackLayout {
    id: stackLayout
    x: 0
    y: 0
    width: 988
    height: 613
    currentIndex: 0
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.bottom: parent.bottom
    anchors.top: parent.top

    //Creating custom properties to make PdfsList elements work
    property var urls0: profileList.urls
    property var urls1: docList.urls
    property var pdfBuildUrl0: dropProfile.filePaths
    property var pdfBuildUrl1: dropTemplate.filePaths
    property var defaultFolder: String(StandardPaths.standardLocations(StandardPaths.DocumentsLocation)[0]).replace("file:///","")
    property var folderLocation0: defaultFolder
    property var extensions:[]
    property var folderLocation1: defaultFolder
    property var enableExcel: false

    function basename(str){
        return (str.slice(str.lastIndexOf("/")+1))
    }

    function addDocs0(fileUrls,fileNames){
        for(var i in fileUrls){
            urls0.push(String(fileUrls[i]))
            profileList.createListObject(fileNames[i], fileUrls[i]);
        }
        profileList.updateUrlsList()
    }

    function addDocs1(fileUrls,fileNames){
        for(var i in fileUrls){
            urls1.push(String(fileUrls[i]))
            docList.createListObject(fileNames[i], fileUrls[i]);
        }
        docList.updateUrlsList()
    }

    function getExtension(str){
        return str.split('.').pop();
    }

    //First view: Document generation with profiles as input
    Item {
        id:docGeneration
        //Background for the entire content of this page
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
                color: "#04a3c3"
                radius: 12
                anchors.fill: parent
                anchors.rightMargin: 30
                anchors.bottomMargin: 30
                anchors.leftMargin: 30
                anchors.topMargin: 30
                //Title background
                //Background rectangle for all fields and buttons in this view

                Rectangle {
                    id: mainContainer0
                    x: 210
                    y: 31
                    width: 520
                    height: 368
                    color: "#89c2db"
                    radius: 12
                    anchors.horizontalCenterOffset: 0
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    //Button to browse and select the save dir
                    //Label to welcome the user and let him/her know when
                    //the process is done
                    CustomBusyIndicator{
                        id: docBusy
                        x: 212
                        y: 136
                        anchors.verticalCenterOffset: 136
                        anchors.horizontalCenterOffset: 322
                        anchors.centerIn: parent
                        implicitWidth: 96
                        implicitHeight: 96
                        running: false
                        mainColor: '#38A1DB'
                        secondaryColor: '#33E2F2'
                    }

                    Label {
                        id: outputLabel
                        x: 204
                        y: 320
                        height: 31
                        color: "#ffffff"
                        text: qsTr("¡Bienvenido!")
                        anchors.horizontalCenter: parent.horizontalCenter
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        anchors.horizontalCenterOffset: 1
                        font.family: "Sans Serif"
                        anchors.rightMargin: -2
                        anchors.leftMargin: 2
                        font.pointSize: 15
                    }
                    //Label to show the selected save file dir

                    CustomButton {
                        id: createProfile
                        x: 40
                        y: 199
                        width: 428
                        height: 37
                        visible: true
                        text: "Crear perfil"
                        anchors.horizontalCenterOffset: 1
                        anchors.horizontalCenter: parent.horizontalCenter

                        font.pointSize: 20
                        font.family: "Sans Serif"
                        btnColorMouseOver: "#296d17"
                        btnColorDefault: "#055b34"
                        Layout.preferredWidth: 250
                        Layout.maximumHeight: 65535
                        onPressed: {
                            stackLayout.currentIndex = 1
                        }

                    }

                    Rectangle {
                        id: dragContainer0
                        x: 40
                        y: 61
                        height: 124
                        width: 428
                        color: "#ffffff"
                        radius: 12
                        anchors.horizontalCenterOffset: 0
                        anchors.horizontalCenter: parent.horizontalCenter
                        ExcelList {
                            id: profileList
                            x: 16
                            y: 5
                            width: 210
                            height: 100
                            anchors.left: parent.left
                            anchors.right: dropProfile.left
                            anchors.top: parent.top
                            anchors.bottom: parent.bottom
                            anchors.topMargin: 43
                            anchors.bottomMargin: 42
                            anchors.rightMargin: 53
                            anchors.leftMargin: 8
                        }
                        //Drop file area to select or drag&drop profiles
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
                            DropFilesArea {
                                id: dropProfile
                                x: 229
                                y: 20
                                width: 186
                                height: 85

                                anchors.right: parent.right
                                //customText: "Escoja su perfil o arrástrelo aquí"
                                anchors.rightMargin: 13
                                fileExtensions: ["xlsx","xls"]
                                onFileDropped: (fileUrls,fileNames) => {profileList.clearModel();
                                                    dropFiles1.color = '#aaecff';
                                                    addDocs0(fileUrls,fileNames)}
                                onFileSelected:(fileUrls,fileNames) => {profileList.clearModel();
                                                    addDocs0(fileUrls,fileNames)}
                                onFileDroppedFailed: () => dropFiles1.color = '#aaecff'
                                onFileEntered: () => dropFiles1.color = '#66c3dd'
                                onFileExited: () => dropFiles1.color = '#aaecff'
                            }
                            ColumnLayout {
                                id: profileLayout
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
                                    id: profileLabel
                                    x: 10
                                    text: "Escoja su perfil o arrástrelo aquí"
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                    font.family: "Sans Serif"
                                    font.pointSize: 7
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

                    CustomButton {
                        id: runBtn
                        x: 40
                        y: 262
                        width: 428
                        height: 37
                        visible: true
                        text: "Generar documentos"
                        anchors.horizontalCenterOffset: 1
                        anchors.horizontalCenter: parent.horizontalCenter
                        font.family: "Sans Serif"
                        Layout.maximumHeight: 65535
                        font.pointSize: 20
                        btnColorDefault: "#ce5a0c"
                        btnColorMouseOver: "#ff8800"
                        Layout.preferredWidth: 250
                        //enabled: enableGenerate()
                        onPressed:{


                            if(urls0.length>0){

                                docBusy.timerFunction = () => {var generation = backend.generateDocuments(urls0[0]);
                                                                    outputLabel.text = generation[1];
                                                                    if(generation[0] === 0){
                                                                        outputLabel.color = "#fff"
                                                                    }else if(generation[0] === 1){
                                                                        outputLabel.color = "#a20000"
                                                                    }
                                                               }
                                docBusy.start()

                            }else{
                                outputLabel.text = "Debe introducir un perfil"
                                outputLabel.color = "#a20000"
                            }





                        }
                    }

                    Label {
                        id: pdfGenLabel
                        x: -196
                        y: 13
                        height: 42
                        color: "#ffffff"
                        text: qsTr("Generador de documentos")
                        anchors.left: parent.left
                        anchors.right: parent.right
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.family: "Sans Serif"
                        anchors.rightMargin: 8
                        anchors.leftMargin: 8
                        font.pointSize: 25
                    }

                }
            }
        }
    }
    //Declaring connections to backend

    Connections {
        target: backend

    }
    //Second view: profile creation
    Item {
        id: profileCreation
        //Background rectangle for all the content in this view
        Rectangle {
            id: bg1
            color: "#04a3c3"
            anchors.fill: parent
            anchors.topMargin: 0
            anchors.leftMargin: 0
            anchors.rightMargin: 0
            anchors.bottomMargin: 0
            Rectangle {
                id: rectangleVisible1
                color: "#89c2db"
                radius: 12
                anchors.fill: parent
                anchors.topMargin: 30
                anchors.leftMargin: 30
                anchors.rightMargin: 30
                anchors.bottomMargin: 30
                //Background rectangle for all fields and buttons in this view
                Rectangle {
                    id: mainContainer1
                    x: 236
                    y: 13
                    width: 616
                    height: 527
                    color: "#04a3c3"
                    radius: 12
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter

                    CustomButton {
                        id: selectFolderbtn1
                        y: 194
                        height: 23
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.rightMargin: 376
                        //text: "📁"
                        anchors.leftMargin: 216
                        btnColorMouseOver: "#00000000"
                        btnColorClicked: "#00000000"
                        btnColorDefault: "#00000000"

                        onClicked: {
                            selectFolder1.open()
                        }

                        FolderDialog {
                            id: selectFolder1
                            onAccepted: {
                                folderLocation1 = String(selectFolder1.folder).replace("file:///","")
                                folderLabel1.text = folderLocation1
                            }
                            //selectFolder: true
                            title: "Select Folder"

                        }


                        highlighted: false
                        Layout.maximumHeight: 65535
                        Layout.preferredHeight: 40
                        font.family: "Sans Serif"
                        Layout.preferredWidth: 250
                        Layout.fillWidth: true
                        font.pointSize: 10
                        Layout.maximumWidth: 70
                    }

                    Label {
                        id: folderLabel2
                        x: 20
                        y: 218
                        height: 21
                        color: "#ffffff"
                        text: qsTr(folderLocation0)
                        anchors.left: parent.left
                        anchors.right: parent.right
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        anchors.rightMargin: 76
                        font.family: "Sans Serif"
                        font.pointSize: 17
                        anchors.leftMargin: 76
                    }

                    CustomButton {
                        id: selectFolderbtn2
                        y: 185
                        height: 32
                        anchors.left: parent.left
                        anchors.right: parent.right
                        font.family: "Sans Serif"
                        anchors.rightMargin: 424
                        anchors.leftMargin: 153
                        onClicked: {
                            selectFolder2.open()
                        }
                        Image {
                            id: iconBtn2
                            y: 0
                            height: 32
                            visible: true
                            anchors.left: parent.left
                            anchors.right: parent.right
                            source: "../../images/icons/folder.png"
                            fillMode: Image.PreserveAspectFit
                            anchors.rightMargin: 0
                            anchors.leftMargin: 0
                        }

                        FolderDialog {
                            id: selectFolder2
                            onAccepted: {
                                folderLocation0 = String(selectFolder2.folder).replace("file:///","")
                                folderLabel2.text = folderLocation0
                            }
                            title: "Select Folder"
                        }
                        btnColorClicked: "#00000000"
                        font.pointSize: 10
                        Layout.fillWidth: true
                        btnColorDefault: "#00000000"
                        Layout.preferredWidth: 250
                        Layout.preferredHeight: 40
                        Layout.maximumWidth: 70
                        Layout.maximumHeight: 65535
                        highlighted: false
                        btnColorMouseOver: "#00000000"
                    }


                    Label {
                        id: folderLabel4
                        x: 23
                        y: 190
                        height: 22
                        color: "#ffffff"
                        text: "Guardar documentos en:"
                        anchors.left: parent.left
                        anchors.right: parent.right
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        anchors.rightMargin: 147
                        font.family: "Sans Serif"
                        font.pointSize: 18
                        anchors.leftMargin: 198
                    }

                    Label {
                        id: warning1
                        x: 12
                        y: 488
                        height: 24
                        color: "#ffffff"
                        text: qsTr("¡Bienvenido!")
                        anchors.left: parent.left
                        anchors.right: parent.right
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.family: "Sans Serif"
                        anchors.rightMargin: 2
                        anchors.leftMargin: 2
                        font.pointSize: 20

                    }

                    Label {
                        id: pdfGenLabel1
                        x: -194
                        y: 0
                        height: 51
                        color: "#ffffff"
                        text: qsTr("Creación de perfil")
                        anchors.left: parent.left
                        anchors.right: parent.right
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        anchors.leftMargin: 8
                        anchors.rightMargin: 8
                        font.family: "Sans Serif"
                        font.pointSize: 25
                    }

                    Rectangle {
                        id: dragContainer1

                        x: 46
                        y: 50
                        height: 104
                        width: 428
                        color: "#ffffff"
                        radius: 12
                        anchors.horizontalCenter: parent.horizontalCenter
                        //PdfList that contains and shows the selected templates
                        DocuList {
                            id: docList
                            x: 16
                            y: 5
                            width: 210
                            height: 100
                            anchors.left: parent.left
                            anchors.right: dropTemplate.left
                            anchors.top: parent.top
                            anchors.bottom: parent.bottom
                            anchors.topMargin: 33
                            anchors.bottomMargin: 40
                            anchors.rightMargin: 53
                            anchors.leftMargin: 8
                        }
                        //Drop file area to select or drag&drop profiles
                        Rectangle {
                            id: dropFiles2
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
                            DropFilesArea {
                                id: dropTemplate
                                x: 234
                                y: 8
                                width: 186
                                height: 88
                                anchors.right: parent.right
                                //customText: "Escoja su plantilla o arrástrela aquí"
                                anchors.rightMargin: 8
                                fileExtensions: ["docx"]
                                onFileDropped: (fileUrls,fileNames) => {docList.clearModel();
                                                                        dropFiles2.color = '#aaecff';
                                                                        addDocs1(fileUrls,fileNames)}
                                onFileSelected: (fileUrls,fileNames) => {docList.clearModel();
                                                    addDocs1(fileUrls,fileNames)}
                                onFileDroppedFailed: () => dropFiles2.color = '#aaecff'
                                onFileEntered: () => dropFiles2.color = '#66c3dd'
                                onFileExited: () => dropFiles2.color = '#aaecff'
                            }
                            ColumnLayout {
                                id: templateLayout
                                anchors.fill: parent
                                transformOrigin: Item.Center
                                Image {
                                    id: templateImage
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
                                    id: templateLabel
                                    x: 10
                                    text: "Escoja su plantilla o arrástrela aquí"
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                    font.family: "Sans Serif"
                                    font.pointSize: 7
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
                    FileDialog{
                        id: profileDialog
                        title: "Guardar perfil"
                        acceptLabel: 'Guardar'
                        rejectLabel: 'Cancelar'
                        fileMode: FileDialog.SaveFile
                        folder: defaultFolder
                        nameFilters: ['Excel Files (*.xlsx)']
                        onAccepted: {
                            folderLocation1 = String(currentFile).replace('file:///','')

                            if(urls1.length>0){
                                backend.createProfile(urls1[0],docList.getNames()[0],folderLocation1,folderLocation0)
                                docImg.visible = true
                                profileOutputLabel.text = basename(folderLocation1)
                                warning1.text = "Perfil generado correctamente"
                                warning1.color = "#fff"

                            }
                        }
                    }

                    CustomButton {
                        id: genProfile
                        x: 46
                        y: 272
                        width: 428
                        height: 31
                        visible: true
                        text: "Generar perfil"
                        anchors.horizontalCenterOffset: 0
                        Layout.preferredWidth: 250
                        anchors.horizontalCenter: parent.horizontalCenter
                        Layout.maximumHeight: 65535
                        font.family: "Sans Serif"
                        btnColorMouseOver: "#296d17"
                        btnColorDefault: "#055b34"
                        font.pointSize: 16
                        //When the button is pressed, the corresponding backend function
                        //is called. Then the xlsx icon turns visible and the name of the
                        //created profile is shown
                        onPressed: {
                            if(urls1.length>0){
                                profileDialog.open()
                            }else if(urls1.length===0){
                                warning1.text = "Debe introducir una plantilla"
                                warning1.color = "#a20000"
                            }

                        }
                    }

                    Rectangle {
                        id: xlsxContainer
                        x: 46
                        y: 309
                        width: 428
                        height: 117
                        color: "#ffffff"
                        radius: 12
                        anchors.horizontalCenterOffset: 0
                        anchors.horizontalCenter: parent.horizontalCenter
                        //xlsx icon to show the created profile
                        Image {
                            id: docImg
                            source: "../../images/icons/excel_icon.png"
                            anchors.topMargin: 8
                            anchors.bottomMargin: 28
                            anchors.rightMargin: 34
                            sourceSize.height: 50
                            sourceSize.width: 50
                            anchors.leftMargin: 34
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.top: parent.top
                            anchors.bottom: parent.bottom
                            fillMode: Image.PreserveAspectFit
                            visible: false
                            antialiasing: true
                        }
                        //Labl that shows the name of the created profile along
                        //with the .xlsx extension
                        Label {
                            id: profileOutputLabel
                            x: 12
                            color: "#000000"
                            text: qsTr("")
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.top: parent.top
                            anchors.bottom: parent.bottom
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            anchors.topMargin: 90
                            anchors.bottomMargin: 8
                            anchors.rightMargin: 0
                            font.family: "Sans Serif"
                            font.pointSize:12
                            anchors.leftMargin: 0
                        }
                    }

                    CustomButton {
                        id: openExcProfile
                        x: 46
                        y: 432
                        width: 428
                        height: 31
                        visible: true
                        text: "Abrir perfil"
                        anchors.horizontalCenterOffset: 0
                        anchors.horizontalCenter: parent.horizontalCenter
                        Layout.preferredWidth: 250

                        Layout.maximumHeight: 65535

                        btnColorDefault: "#1118a6"
                        btnColorMouseOver: "#1822ea"
                        font.family: "Sans Serif"
                        font.pointSize: 16
                        //When the button is pressed, the corresponding backend function is called
                        onPressed: {
                            if(profileOutputLabel.text.length>0){
                                backend.openProfile(folderLocation1)
                            }
                            else{
                                warning1.text = "Debe crear un perfil"
                                warning1.color = "#a20000"
                            }


                        }
                    }






                }
                //Title label
                //Container rectangle for the PdfList element
                //amd the drop area as well
                //Profile generation button
                //Background for the xlsx profile image
                //Button that opens the created profile
                //Button to go back to the first view
                CustomButton {
                    id: goBack
                    y: 12
                    width: 49
                    height: 51
                    visible: true
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                    Layout.preferredWidth: 250
                    btnColorDefault: "#04a3c3"
                    Layout.maximumHeight: 65535
                    font.family: "Sans Serif"
                    btnColorMouseOver: "#ea0707"
                    font.pointSize: 20
                    //Icon with a left arrow, symbolizing the
                    //button purpose
                    Image {
                        id: goBackImg
                        y: 7
                        height: 36
                        source: "../../images/icons/back-arrow.png"
                        anchors.rightMargin: 0
                        anchors.leftMargin: 0
                        fillMode: Image.PreserveAspectFit
                        visible: true
                        anchors.left: parent.left
                        anchors.right: parent.right
                    }
                    //White color overlay to apply it to the image
                    ColorOverlay {
                        anchors.fill: goBackImg
                        source: goBackImg
                        color: "#fff"
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        antialiasing: true
                        width: iconWidth
                        height: iconHeight
                    }
                    //When the button is pressed, the view changes to the first one
                    onPressed: {
                        stackLayout.currentIndex = 0
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
    D{i:0;formeditorZoom:0.33}
}
##^##*/
