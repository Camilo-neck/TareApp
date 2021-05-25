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
                color: "#03738c"
                radius: 12
                anchors.fill: parent
                anchors.rightMargin: 30
                anchors.bottomMargin: 30
                anchors.leftMargin: 30
                anchors.topMargin: 30
                //Title background
                Rectangle {
                    id: titleRectangle
                    x: 228
                    y: 31
                    height: 56
                    color: "#04a6c6"
                    radius: 12
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.leftMargin: 210
                    anchors.rightMargin: 198
                    //Page title label
                    Label {
                        id: pdfGenLabel
                        x: -194
                        y: 6
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
                //Background rectangle for all fields and buttons in this view
                Rectangle {
                    id: mainContainer0
                    x: 236
                    y: 104
                    height: 407
                    color: "#04a6c6"
                    radius: 12
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.leftMargin: 210
                    anchors.rightMargin: 198
                    //Button to browse and select the save dir
                    CustomButton {
                        id: selectFolderbtn0
                        height: 34
                        anchors.left: parent.left
                        //text: "📁"
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 242
                        btnColorMouseOver: "#00000000"
                        btnColorClicked: "#00000000"
                        btnColorDefault: "#00000000"
                        //When the folder select button is clicked,
                        //a Folder Dialog is initiated
                        onClicked: {
                            selectFolder0.open()
                        }
                        //This Folder Dialog allows the user to select a save file dir,
                        //being "Documents" the default dir
                        FolderDialog {
                            id: selectFolder0
                            onAccepted: {
                                folderLocation0 = String(selectFolder0.folder).replace("file:///","")
                                folderLabel0.text = "Guardar en: "+ folderLocation0
                            }
                            //selectFolder: true
                            title: "Select Folder"

                        }
                        highlighted: false
                        Layout.maximumHeight: 65535
                        Layout.preferredHeight: 40
                        font.family: "Sans Serif"
                        Layout.preferredWidth: 250
                        anchors.topMargin: 219
                        Layout.fillWidth: true
                        anchors.bottomMargin: 154
                        anchors.rightMargin: 243
                        font.pointSize: 10
                        Layout.maximumWidth: 70

                        Image {
                            id: iconBtn0
                            source: "../../images/icons/folder.png"
                            anchors.verticalCenterOffset: 1
                            anchors.horizontalCenterOffset: 0
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.horizontalCenter: parent.horizontalCenter
                            height: 34
                            width: 35
                            fillMode: Image.PreserveAspectFit
                            visible: true
                        }
                    }
                    //Label to welcome the user and let him/her know when
                    //the process is done
                    Label {
                        id: outputLabel
                        x: 12
                        y: 359
                        height: 31
                        color: "#ffffff"
                        text: qsTr("¡Bienvenido!")
                        anchors.left: parent.left
                        anchors.right: parent.right
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.family: "Sans Serif"
                        anchors.rightMargin: 0
                        anchors.leftMargin: 0
                        font.pointSize: 15
                    }
                    //Label to show the selected save file dir
                    Label {
                        id: folderLabel0
                        x: 12
                        y: 259
                        height: 31
                        color: "#ffffff"
                        text: qsTr("Guardar en: "+folderLocation1)
                        anchors.left: parent.left
                        anchors.right: parent.right
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.family: "Sans Serif"
                        anchors.rightMargin: 0
                        anchors.leftMargin: 2
                        font.pointSize: 15
                    }
                }
                //Button to navigate to the second view: profile creation
                CustomButton {
                    id: createProfile
                    y: 266
                    height: 37
                    visible: true
                    text: "Crear perfil"
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.rightMargin: 250
                    anchors.leftMargin: 250
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
                //Container rectangle for the PdfList element
                //amd the drop area as well
                Rectangle {
                    id: dragContainer0
                    x: 227
                    y: 124
                    height: 120
                    color: "#ffffff"
                    anchors.rightMargin: 250
                    anchors.leftMargin: 250
                    radius: 12
                    anchors.left: parent.left
                    anchors.right: parent.right
                    //PdfList that contains and shows the selected profiles
                    PdfsList {
                        id: profileList
                        x: 16
                        y: 5
                        width: 210
                        height: 100
                        anchors.left: parent.left
                        anchors.right: dropTemplate.left
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.topMargin: 8
                        anchors.bottomMargin: 38
                        anchors.rightMargin: 10
                        anchors.leftMargin: 16
                    }
                    //Drop file area to select or drag&drop profiles
                    DropFilesArea {
                        id : dropProfile
                        x: 232
                        y: 5
                        width: 186
                        height: 111
                        anchors.right: parent.right
                        anchors.rightMargin: 10
                        customText: "Escoja su perfil o arrástrelo aquí"
                        fileExtensions: ["xlsx","xls"]
                        customFunction: (fileUrls,fileNames) => addDocs0(fileUrls,fileNames)

                    }
                }
                //Doc creation button
                CustomButton {
                    id: runBtn
                    y: 416
                    height: 37
                    visible: true
                    text: "Generar documentos"
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.rightMargin: 250
                    anchors.leftMargin: 250
                    font.family: "Sans Serif"
                    Layout.maximumHeight: 65535
                    font.pointSize: 20
                    btnColorDefault: "#ce5a0c"
                    btnColorMouseOver: "#ff8800"
                    Layout.preferredWidth: 250
                    //enabled: enableGenerate()
                    onPressed:{


                        if(urls0.length>0){
                            backend.generateDocuments(urls0[0],folderLocation0+"/")
                            outputLabel.text = qsTr("Documentos generados correctamente")
                            outputLabel.color = "#fff"

                        }else{
                            outputLabel.text = "Debe introducir un perfil"
                            outputLabel.color = "#a20000"
                        }





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
            color: "#89c2db"
            anchors.fill: parent
            anchors.topMargin: 0
            anchors.leftMargin: 0
            anchors.rightMargin: 0
            anchors.bottomMargin: 0
            Rectangle {
                id: rectangleVisible1
                color: "#03738c"
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
                    height: 527
                    color: "#04a6c6"
                    radius: 12
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.leftMargin: 204
                    anchors.rightMargin: 204
                    Label {
                        id: folderLabel1
                        x: 12
                        y: 223
                        height: 34
                        color: "#ffffff"
                        text: qsTr("Guardar en: "+folderLocation1)
                        anchors.left: parent.left
                        anchors.right: parent.right
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.family: "Sans Serif"
                        anchors.rightMargin: 22
                        anchors.leftMargin: 22
                        font.pointSize: 15
                    }

                    CustomButton {
                        id: selectFolderbtn1
                        y: 191
                        height: 35
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.rightMargin: 242
                        //text: "📁"
                        anchors.leftMargin: 245
                        btnColorMouseOver: "#00000000"
                        btnColorClicked: "#00000000"
                        btnColorDefault: "#00000000"

                        onClicked: {
                            selectFolder1.open()
                        }

                        Image {
                            id: iconBtn1
                            y: 0
                            height: 36
                            source: "../../images/icons/folder.png"
                            anchors.rightMargin: 0
                            anchors.leftMargin: 0
                            fillMode: Image.PreserveAspectFit
                            visible: true
                            anchors.left: parent.left
                            anchors.right: parent.right
                        }

                        FolderDialog {
                            id: selectFolder1
                            onAccepted: {
                                folderLocation1 = String(selectFolder1.folder).replace("file:///","")
                                folderLabel1.text = "Guardar en: "+ folderLocation1
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

                    CustomTextField {
                        id: inputProfileName
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.rightMargin: 45
                        anchors.leftMargin: 48
                        anchors.bottomMargin: 342
                        anchors.topMargin: 154
                        Layout.fillHeight: false
                        font.family: "Sans Serif"
                        placeholderTextColor: "#121314"
                        fontColor: "#151212"
                        bgColor: "#ffffff"
                        font.pointSize: 10
                        Layout.fillWidth: true
                        placeholderText: "Ingrese el nombre que desea darle a su perfil"

                    }

                    Label {
                        id: warning1
                        x: 12
                        y: 472
                        height: 31
                        color: "#ffffff"
                        text: qsTr("¡Bienvenido!")
                        anchors.left: parent.left
                        anchors.right: parent.right
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.family: "Sans Serif"
                        anchors.rightMargin: 1
                        anchors.leftMargin: 1
                        font.pointSize: 19
                    }


                }
                //Title label
                Label {
                    id: pdfGenLabel1
                    x: 12
                    y: 8
                    height: 59
                    color: "#ffffff"
                    text: qsTr("Creación de perfil")
                    anchors.left: parent.left
                    anchors.right: parent.right
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    anchors.leftMargin: 10
                    anchors.rightMargin: 6
                    font.family: "Sans Serif"
                    font.pointSize: 25
                }
                //Container rectangle for the PdfList element
                //amd the drop area as well
                Rectangle {
                    id: dragContainer1
                    x: 227
                    y: 63
                    height: 96
                    color: "#ffffff"
                    radius: 12
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.leftMargin: 252
                    anchors.rightMargin: 248
                    //PdfList that contains and shows the selected templates
                    PdfsList {
                        id: docList
                        x: 16
                        y: 5
                        width: 210
                        height: 100
                        anchors.left: parent.left
                        anchors.right: dropTemplate.left
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.topMargin: 8
                        anchors.bottomMargin: 38
                        anchors.rightMargin: 10
                        anchors.leftMargin: 16
                    }
                    //Drop file area to select or drag&drop profiles
                    DropFilesArea {
                        id: dropTemplate
                        x: 232
                        y: 5
                        width: 186
                        height: 85
                        anchors.right: parent.right
                        customText: "Escoja su plantilla o arrástrela aquí"
                        anchors.rightMargin: 10
                        fileExtensions: ["docx"]
                        customFunction: (fileUrls,fileNames) => {addDocs1(fileUrls,fileNames)
                                        enableCrProfile()}
                    }
                }
                //Profile generation button
                CustomButton {
                    id: genProfile
                    y: 272
                    height: 37
                    visible: true
                    text: "Generar perfil"
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.leftMargin: 252
                    Layout.preferredWidth: 250
                    anchors.rightMargin: 248
                    Layout.maximumHeight: 65535
                    font.family: "Sans Serif"
                    btnColorMouseOver: "#296d17"
                    btnColorDefault: "#055b34"
                    font.pointSize: 20
                    //When the button is pressed, the corresponding backend function
                    //is called. Then the xlsx icon turns visible and the name of the
                    //created profile is shown
                    onPressed: {
                        if(urls1.length>0 && inputProfileName.text.length>0){
                            //backend.createProfile(docList.getNames()[0],inputProfileName.text)
                            backend.createProfile(urls1[0],docList.getNames()[0],folderLocation1+"/",inputProfileName.text)
                            docImg.visible = true
                            profileOutputLabel.text = inputProfileName.text+".xlsx"
                            warning1.text = "Perfil generado correctamente"
                            warning1.color = "#fff"
                            inputProfileName.placeholderText="Ingrese el nombre que desea darle a su perfil"
                            inputProfileName.placeholderTextColor = "#1f2021"

                        }else{
                            if(urls1.length==0 && inputProfileName.text.length==0){
                                inputProfileName.placeholderText="Debe introducir una plantilla y un nombre para su perfil"
                                inputProfileName.placeholderTextColor = "#a20000"
                            }else if(urls1.length==0){
                                warning1.text = "Debe introducir una plantilla"
                                warning1.color = "#a20000"
                            }else if(inputProfileName.text.length==0){
                                inputProfileName.placeholderText="Debe introducir un nombre"
                                inputProfileName.placeholderTextColor = "#a20000"
                            }
                        }
                    }
                }
                //Background for the xlsx profile image
                Rectangle {
                    id: xlsxContainer
                    x: 228
                    y: 323
                    height: 96
                    color: "#ffffff"
                    radius: 12
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.leftMargin: 252
                    anchors.rightMargin: 248
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
                        anchors.topMargin: 74
                        anchors.bottomMargin: 8
                        anchors.rightMargin: 0
                        font.family: "Sans Serif"
                        font.pointSize:12
                        anchors.leftMargin: 0
                    }
                }
                //Button that opens the created profile
                CustomButton {
                    id: openExcProfile
                    y: 434
                    height: 37
                    visible: true
                    text: "Abrir perfil"
                    anchors.left: parent.left
                    anchors.right: parent.right
                    Layout.preferredWidth: 250
                    anchors.leftMargin: 252
                    Layout.maximumHeight: 65535
                    anchors.rightMargin: 248
                    btnColorDefault: "#1118a6"
                    btnColorMouseOver: "#1822ea"
                    font.family: "Sans Serif"
                    font.pointSize: 20
                    //When the button is pressed, the corresponding backend function is called
                    onPressed: {
                        if(profileOutputLabel.text.length>0){
                            backend.openProfile(folderLocation1+"/"+profileOutputLabel.text)
                        }
                        else{
                            inputProfileName.placeholderText = "Debe crear un perfil"
                            inputProfileName.placeholderTextColor = "#a20000"
                        }


                    }
                }
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
                    btnColorDefault: "#04a6c6"
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
    D{i:0;formeditorZoom:0.5}
}
##^##*/
