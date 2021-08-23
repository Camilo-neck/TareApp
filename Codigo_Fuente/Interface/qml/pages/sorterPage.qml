import QtQuick 2.7
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.11
import QtQml.Models 2.2
import "../controls"
import Qt.labs.platform 1.1
import Qt.labs.animation 1.0

Item{

    property var j : 1
    property var urls : list1.urls
    property var names : list1.names
    property var folderLocation: ""
    // property var fNames : ["Imagenes","Videos","Musica y Audios","Archivos de texto","Carpetas comprimidas","Archivos de Office"]
    // property var fExtensions : ["jpg png jpeg","mp4 avi mov mkv gif","mp3 wab aac ogg","txt pdf","rar zip","docx doc pptx xlsx"]

    property var folderUrl2: ""

    function getMethod(){
        if (extRadio.checked){
            return 0
        }else if (labelRadio.checked) {
            return 1
        }
    }

    function basename(str){
        var extensionLength = - (getExtension(str).length +1)
        return (String(str).slice(String(str).lastIndexOf("\\")+1)).slice(0, extensionLength)
    }

    function getExtension(str){
        return str.split('.').pop();
    }

    function getFilenames(fileUrls){
        return fileUrls.map((url) => basename(url))
    }

    function addFilesFromFolder(folderUrl){

        var fileUrls = backend.getFilesFromFolder(folderUrl)
        //console.log("Files>>>>>"+fileUrls)
        if(fileUrls[0] !== "NULL"){
            var fileNames = getFilenames(fileUrls)
            //console.log("FILEURLS:",fileUrls)
            //console.log("FILENAMES;",fileNames)

            for(var i in fileUrls){
                //console.log('FILENAME>>> '+fileNames[i]+' | URL>>> '+ fileUrls[i].replace('\\','/'))
                urls.push(String(fileUrls[i]))
                list1.createListObject(fileNames[i], fileUrls[i].replace('\\','/'));

            }
            list1.updateUrlsList()
            return true
        }
        return false

    }

    function lAction(){
        if (applyRadio.checked){
            return 0
        }else if (removeRadio.checked) {
            return 1
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
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: bar.bottom
            anchors.bottom: parent.bottom
            anchors.topMargin: -1
            currentIndex: bar.currentIndex
            anchors.bottomMargin: 10
            anchors.leftMargin: 10
            Item {
                id: item1
                Layout.fillWidth: true
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
                        anchors.rightMargin: 10
                        anchors.topMargin: 10
                    }

                    CustomVerticalList2 {
                        id: list2
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.rightMargin: 158
                        anchors.leftMargin: 29
                        anchors.topMargin: 80
                        anchors.bottomMargin: 123
                    }


                    CustomButton {
                        id: bttclear1
                        x: 822
                        y: 256
                        width: 138
                        height: 42
                        text: "Vaciar lista"
                        anchors.right: parent.right
                        anchors.rightMargin: 10
                        Layout.preferredWidth: 250
                        btnColorDefault: "#009aeb"
                        Layout.maximumHeight: 65535
                        btnColorClicked: "#ec0606"
                        btnColorMouseOver: "#78ede7"
                        font.family: "Sans Serif"
                        Layout.maximumWidth: 70
                        onClicked: {
                            switchDefault.checked = false
                            list2.colorIndex = 0
                            list2.clearModel()
                            logLabel.text = ""
                        }
                        font.pointSize: 10
                        Layout.fillWidth: true
                        Layout.preferredHeight: 40
                    }

                    CustomButton {
                        id: organizeBttn
                        x: 29
                        y: 472
                        width: 110
                        height: 42
                        text: "Ordenar"
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 39
                        Layout.preferredWidth: 250
                        btnColorDefault: "#ff9a15"
                        Layout.maximumHeight: 65535
                        btnColorClicked: "#ec0606"
                        btnColorMouseOver: "#78ede7"
                        font.family: "Sans Serif"
                        Layout.maximumWidth: 70
                        onClicked: {
                            {
                            var names = list2.getNames()
                            var extensions = list2.getExtensions()

                            var validFolders = true

                            for(var i in names){
                                if(names[i].length<=0 || extensions[i].length<=0){
                                    validFolders = false
                                    break
                                }
                            }

                            if(folderLocation!=="" && validFolders && list2.getLength()>0){
                                logLabel.text = ""
                                folderLabel.color = "#000000"
                                if (backend.confirm(folderLocation) == true) {
                                    var method = getMethod()
                                    var moveToDefault = switchDefaultFolder.checked
                                    var path = folderLocation
                                    var ignoredExt = [".py"]
                                    var log = backend.organizeFiles(method,path,names,extensions,ignoredExt,moveToDefault)
                                    if(log===''){infoLabel.text = 'Carpeta Ordenada Satisfactoriamente'}
                                    else{logLabel.text = log}
                                }
                            }else{
                                if(folderLocation===""){
                                    folderLabel.color = "#F50000"
                                    rectangleTop.border.color = "#F50000"
                                }
                                if(!validFolders){
                                    infoLabel.text = 'Por favor no deje ningun campo vacio'
                                }
                                else if(list2.getLength()<=0){
                                    infoLabel.text = 'Debe añadir al menos una carpeta para organizar sus archivos'
                                }else{
                                    infoLabel.text = ""
                                }

                                }
                            }
                        }
                        font.pointSize: 10
                        Layout.fillWidth: true
                        Layout.preferredHeight: 40
                    }
                    CustomButton {
                        id: bttadd1
                        x: 766
                        y: 383
                        width: 40
                        height: 42
                        text: "+"
                        anchors.right: parent.right
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 128
                        anchors.rightMargin: 164
                        Layout.preferredWidth: 250
                        btnColorDefault: "#009aeb"
                        Layout.maximumHeight: 65535
                        btnColorClicked: "#ec0606"
                        btnColorMouseOver: "#78ede7"
                        font.family: "Sans Serif"
                        Layout.maximumWidth: 70
                        onClicked: {
                            list2.createListObject("","")
                        }
                        font.pointSize: 20
                        Layout.fillWidth: true
                        Layout.preferredHeight: 40
                    }

                    Rectangle {
                        id: rectangleTop
                        x: 10
                        y: 40
                        height: 33
                        color: "#ffffff"
                        radius: 12
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.topMargin: 34
                        anchors.rightMargin: 10
                        anchors.leftMargin: 29


                        Label {
                            id: folderLabel
                            y: 24
                            width: 708
                            height: 21
                            color: "#777777"
                            text: qsTr("Carpeta Escogida: "+folderLocation)
                            anchors.left: parent.left
                            //anchors.right: dropFiles1.left
                            anchors.top: parent.to
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: 0
                            anchors.rightMargin: 10
                            anchors.topMargin: 48
                            anchors.leftMargin: 8
                            font.pointSize: 9
                        }

                        CustomButton {
                            id: selectFolderbtn
                            x: 890
                            width: 33
                            height: 35
                            anchors.right: parent.right
                            anchors.top: parent.top
                            anchors.bottom: parent.bottom
                            font.pointSize: 10
                            highlighted: false
                            onClicked: {
                                selectFolder1.open()
                            }

                            FolderDialog {
                                id: selectFolder1
                                title: "Select Folder"
                                onAccepted: {
                                    folderLocation = String(selectFolder1.folder).replace("file:///","")
                                    folderLabel.text = "Carpeta seleccionada: "+ folderLocation
                                    folderLabel.color = '#000000'
                                    rectangleTop.border.color = "#FFFFFF"
                                }
                            }

                            Image {
                                id: iconBtn
                                width: 29
                                height: 23
                                visible: true
                                anchors.verticalCenter: parent.verticalCenter
                                source: "../../images/icons/folder.png"
                                anchors.horizontalCenter: parent.horizontalCenter
                                fillMode: Image.PreserveAspectFit
                            }
                            anchors.bottomMargin: 0
                            Layout.preferredHeight: 40
                            anchors.topMargin: 0
                            btnColorMouseOver: "#00000000"
                            font.family: "Sans Serif"
                            btnColorClicked: "#00000000"
                            Layout.preferredWidth: 250
                            Layout.fillWidth: true
                            anchors.rightMargin: 8
                            Layout.maximumHeight: 65535
                            Layout.maximumWidth: 70
                            btnColorDefault: "#00000000"
                        }
                    }

                    Switch {
                        id: switchDefault
                        x: 822
                        y: 197
                        width: 60
                        height: 40
                        anchors.right: parent.right
                        anchors.rightMargin: 88
                        Layout.preferredWidth: 68
                        Layout.fillHeight: false
                        checked: false
                        Layout.fillWidth: false
                        Layout.preferredHeight: 40
                        onClicked: {
                            if(checked){

                                /*
                                list2.colorIndex = 0
                                list2.clearModel()
                                for(var i in fNames){
                                    list2.createListObject(fNames[i],fExtensions[i])
                                }
                                extRadio.checked = true
                                */

                                //////////////////////

                                var url = Qt.resolvedUrl("../../")+"defaultFiles/defaultFolders.xlsx"
                                url = url.replace(/^(file:\/{3})/,"")
                                //console.log(url)
                                var loadList = backend.loadFoldersInfo(url)

                               if (loadList.length <= 1){
                                   var logText = loadList[0]
                                   if (logText === "El archivo no existe en la ruta especificada"){
                                       logText = "No existe un archivo para carpetas por defecto"
                                   }
                                   logLabel.text = logText
                               }

                               else{

                                   var folderNames = loadList[3]
                                   var extTags = loadList[4]

                                   list2.colorIndex = 0
                                   list2.clearModel()
                                   for(var i in folderNames){
                                       list2.createListObject(folderNames[i],extTags[i])
                                   }

                                  extRadio.checked = true
                                  logLabel.text = ""
                               }

                            }else{
                                list2.colorIndex = 0
                                list2.clearModel()
                            }

                        }
                    }

                    Switch {
                        id: switchDefaultFolder
                        x: 425
                        y: 436
                        width: 59
                        height: 40
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 77
                        Layout.preferredWidth: 68
                        Layout.fillHeight: false
                        checked: false
                        Layout.preferredHeight: 40
                        Layout.fillWidth: false
                    }

                    Label {
                        id: label2
                        y: 445
                        width: 390
                        height: 21
                        color: "#000000"
                        text: "Mover archivos no especificados a una carpeta por defecto"
                        anchors.left: parent.left
                        //anchors.right: dropFiles1.left
                        anchors.top: parent.to
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 87
                        anchors.rightMargin: 10
                        anchors.topMargin: 48
                        anchors.leftMargin: 29
                        font.pointSize: 11
                    }

                    RadioButton {
                        id: extRadio
                        x: 818
                        y: 93
                        text: "Por Extension"
                        anchors.right: parent.right
                        anchors.rightMargin: 40
                        display: AbstractButton.TextBesideIcon
                        checked: true
                    }

                    RadioButton {
                        id: labelRadio
                        x: 818
                        y: 129
                        width: 135
                        height: 37
                        text: "Por Etiqueta"
                        anchors.right: parent.right
                        anchors.rightMargin: 17
                    }

                    Label {
                        id: infoLabel
                        y: 524
                        width: 455
                        height: 21
                        color: "#000000"
                        anchors.left: parent.left
                        anchors.top: organizeBttn.bottom
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 8
                        font.pointSize: 11
                        anchors.leftMargin: 29
                        anchors.topMargin: 6
                    }

                    Rectangle {
                        id: logRect
                        color: "#b3a7e3f6"
                        radius: 10
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: list2.bottom
                        anchors.bottom: parent.bottom
                        anchors.rightMargin: 158
                        anchors.leftMargin: 498
                        anchors.topMargin: 6
                        anchors.bottomMargin: 8

                        Label {
                            id: logLabel
                            color: "#000000"
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.top: parent.top
                            anchors.bottom: parent.bottom
                            font.pointSize: 11
                            wrapMode: Text.WordWrap
                            anchors.topMargin: 0
                            anchors.rightMargin: 0
                            anchors.leftMargin: 0
                            anchors.bottomMargin: 0
                            clip: true
                        }
                    }

                    CustomButton {
                        id: btnSave
                        x: 822
                        y: 341
                        width: 138
                        height: 42
                        text: "Guardar"
                        anchors.right: parent.right
                        Layout.preferredHeight: 40
                        Layout.maximumHeight: 65535
                        font.pointSize: 10
                        Layout.fillWidth: true
                        anchors.rightMargin: 10
                        Layout.preferredWidth: 250
                        btnColorMouseOver: "#78ede7"
                        btnColorClicked: "#ec0606"
                        btnColorDefault: "#086291"
                        font.family: "Sans Serif"
                        Layout.maximumWidth: 70
                        onClicked: {
                            var names = list2.getNames()
                            var extensions = list2.getExtensions()
                            var validFolders = true

                            for(var i in names){
                                if(names[i].length<=0 || extensions[i].length<=0){
                                    validFolders = false
                                    break
                                }
                            }

                            if(folderLocation!=="" && validFolders && list2.getLength()>0){
                                logLabel.text = ""
                                folderLabel.color = "#000000"
                                var method = getMethod()
                                var moveToDefault = switchDefaultFolder.checked
                                var path = folderLocation
                                var ignoredExt = [".py"]
                                saveDialog.info = [path,names,extensions,method,moveToDefault]
                                saveDialog.open()

                            }else{
                                if(folderLocation===""){
                                    folderLabel.color = "#F50000"
                                    rectangleTop.border.color = "#F50000"
                                }
                                if(!validFolders){
                                    infoLabel.text = 'Por favor no deje ningun campo vacio'
                                }
                                else if(list2.getLength()<=0){
                                    infoLabel.text = 'Debe añadir al menos una carpeta para Guardar'
                                }else{
                                    infoLabel.text = ""
                                }

                            }

                        }

                        FileDialog {
                            id: saveDialog
                            title: "Guardar info"
                            acceptLabel: 'Guardar'
                            rejectLabel: 'Cancelar'
                            fileMode: FileDialog.SaveFile
                            nameFilters: ['Excel Files (*.xlsx)']
                            property var info: []

                            onAccepted: {
                                var savingPath = String(currentFile).replace('file:///','')
                                backend.saveFoldersInfo(savingPath,info[0],info[1],info[2],info[3],info[4])
                                infoLabel.text = 'Informacion Guardada correctamente'
                            }

                        }

                    }

                    CustomButton {
                        id: btnLoad
                        x: 822
                        y: 389
                        width: 140
                        height: 42
                        text: "Cargar"
                        anchors.right: parent.right
                        anchors.leftMargin: 0
                        Layout.preferredHeight: 40
                        Layout.fillWidth: true
                        Layout.maximumWidth: 70
                        font.family: "Sans Serif"
                        Layout.preferredWidth: 250
                        anchors.bottomMargin: 0
                        anchors.rightMargin: 10
                        Layout.maximumHeight: 65535
                        btnColorClicked: "#ec0606"
                        btnColorDefault: "#086291"
                        font.pointSize: 10
                        btnColorMouseOver: "#78ede7"


                        DropFilesArea {
                            id : dropSaveFile
                            anchors.fill : parent
                            isFolder: false
                            fileExtensions: ["xlsx"]
                            onFileDropped: (url,name) => {
                                               console.log("Entry")
                                               btnLoad.btnColorDefault = "#086291"
                                               //console.log(url)
                                               var loadList = backend.loadFoldersInfo(url)

                                               if (loadList.length <= 1){
                                                   logLabel.text = loadList[0]
                                               }

                                               else if(loadList[0] === "_DEFAULT_FILE"){}

                                               else{
                                                   logLabel.text = ''

                                                   var folderUrl = loadList[0]
                                                   var method = loadList[1]
                                                   var moveToOthers = loadList[2]
                                                   var folderNames = loadList[3]
                                                   var extTags = loadList[4]

                                                   list2.colorIndex = 0
                                                   list2.clearModel()
                                                   for(var i in folderNames){
                                                       list2.createListObject(folderNames[i],extTags[i])
                                                   }

                                                   folderLocation = folderUrl
                                                   folderLabel.text = "Carpeta seleccionada: "+ folderLocation
                                                   folderLabel.color = '#000000'
                                                   rectangleTop.border.color = "#FFFFFF"

                                                   if (method===0){ extRadio.checked=true; labelRadio.checked=false}
                                                   else if (method===1){ extRadio.checked=false; labelRadio.checked=true}


                                                   switchDefaultFolder.checked = moveToOthers

                                                   switchDefault.checked = false

                                                   //console.log(loadList)
                                               }


                                           }

                            onFileEntered: () => {btnLoad.btnColorDefault = '#78ede7'}
                            onFileExited: () => {btnLoad.btnColorDefault = "#086291"}

                        }
                    }

                }

                Label {
                    id: label
                    x: 822
                    y: 182
                    width: 138
                    height: 21
                    color: "#000000"
                    text: "Usar carpetas por defecto"
                    anchors.right: parent.right
                    anchors.top: parent.to
                    anchors.topMargin: 48
                    anchors.rightMargin: 8
                    font.pointSize: 9
                }

                Label {
                    id: label1
                    x: 822
                    y: 77
                    width: 138
                    height: 21
                    color: "#000000"
                    text: "Metodo para ordenar"
                    anchors.right: parent.right
                    anchors.top: parent.to
                    anchors.rightMargin: 8
                    anchors.topMargin: 48
                    font.pointSize: 9
                }
            }

            Item {
                anchors.fill: parent

                Rectangle {
                    id: rectangle4
                    color: "#97d4f0"
                    radius: 12
                    anchors.fill: parent

                    Rectangle {
                        id: dropFiles2
                        x: 28
                        y: 59
                        width: 177
                        height: 128

                        color: "#aaecff"
                        radius: 5
                        border.color: "#0797bd"
                        border.width: 2

                        DropFilesArea{
                            id: filesArea
                            anchors.fill: parent
                            isFolder: true
                            onFileDropped: (folderUrl) => {
                                               dropFiles2.color = '#aaecff'
                                               urls = []
                                               names = []
                                               list1.clearModel()
                                               console.log(folderUrl)


                                               busy1.timerFunction = () => {var isAFolder = addFilesFromFolder(folderUrl)
                                                   if(isAFolder){folderLabel1.text = "Carpeta seleccionada: "+ folderUrl}
                                               }
                                               busy1.start()

                                           }
                            onFileDroppedFailed: () => dropFiles2.color = '#aaecff'
                            onFileEntered: () => dropFiles2.color = '#66c3dd'
                            onFileExited: () => dropFiles2.color = '#aaecff'
                        }

                        ColumnLayout {
                            id: dragDropRow
                            anchors.fill: parent
                            transformOrigin: Item.Center
                            Image {
                                id: image
                                width: 84
                                height: 80
                                horizontalAlignment: Image.AlignHCenter
                                verticalAlignment: Image.AlignVCenter
                                source: "../../images/icons/dropFolder.png"
                                Layout.fillHeight: true
                                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                Layout.maximumHeight: 90
                                Layout.maximumWidth: 100
                                Layout.preferredHeight: 50
                                Layout.preferredWidth: 50
                                Layout.fillWidth: true
                                asynchronous: false
                                sourceSize.width: 0
                                fillMode: Image.PreserveAspectFit
                            }

                            Label {
                                id: dargDropDesc
                                x: 10
                                text: "Escoja o arrastre una carpeta"
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

                    CustomTextField {
                        id: etiquetaLabel
                        x: 28
                        y: 13
                        width: 177
                        height: 40
                        placeholderTextColor: "#ffffff"
                        font.family: "Sans Serif"
                        placeholderText: "Etiqueta o Palabra"
                        bgColor: "#03a678"
                        font.pointSize: 10
                        Layout.fillHeight: false
                        Layout.fillWidth: true
                    }

                    CustomVerticalList {
                        id: list1
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.rightMargin: 120
                        anchors.leftMargin: 226
                        anchors.bottomMargin: 8
                        anchors.topMargin: 61
                        etiqueta: etiquetaLabel.text
                        labelAction: lAction()

                        CustomBusyIndicator{
                            id: busy1
                            x: 293
                            y: 210
                            anchors.verticalCenterOffset: 0
                            anchors.horizontalCenterOffset: 0
                            anchors.centerIn: parent
                            implicitWidth: 96
                            implicitHeight: 96
                            running: false
                            mainColor: '#38A1DB'
                            secondaryColor: '#33E2F2'
                        }
                    }

                    /*
                    CustomButton {
                        id: bttadd
                        x: 884
                        y: 503
                        width: 71
                        height: 42
                        text: "+"
                        anchors.right: parent.right
                        anchors.rightMargin: 15
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
                    */


                    CustomButton {
                        id: bttclear
                        x: 856
                        y: 61
                        width: 99
                        height: 42
                        text: "Vaciar"
                        anchors.right: parent.right
                        anchors.rightMargin: 15
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
                            folderLabel1.text = "Carpeta seleccionada: "
                            selectAllChk.checked = false
                            list1.selectAll = false
                        }
                    }

                    CustomButton {

                        function updateList(){
                            names = []
                            urls = []
                            selectAllChk.checked = false
                            list1.selectAll = false
                            list1.clearModel()
                            busy1.timerFunction = () => addFilesFromFolder(folderUrl2)
                            busy1.start()
                        }

                        id: bttAply
                        x: 28
                        y: 300
                        width: 177
                        height: 42
                        text: "Realizar cambios"
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
                            backend.tagFiles(list1.getCheckedUrls(),etiquetaLabel.text,lAction())
                            updateList()
                        }
                    }

                    RadioButton {
                        id: applyRadio
                        x: 28
                        y: 221
                        text: "Aplicar Etiqueta"
                        display: AbstractButton.TextBesideIcon
                        checked: true
                    }

                    RadioButton {
                        id: removeRadio
                        x: 28
                        y: 257
                        width: 135
                        height: 37
                        text: "Retirar Etiqueta"
                    }

                    CheckBox {
                        id: selectAllChk
                        x: 856
                        y: 109
                        width: 106
                        height: 40
                        text: qsTr("Selccionar todos")
                        anchors.right: parent.right
                        anchors.rightMargin: 8
                        font.pointSize: 6
                        onClicked: { list1.selectAll = this.checked}
                    }

                    Rectangle {
                        id: rectangleTop1
                        x: 10
                        y: 40
                        height: 40
                        color: "#ffffff"
                        radius: 12
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.topMargin: 13
                        anchors.leftMargin: 221
                        clip: true
                        Label {
                            id: folderLabel1
                            y: 11
                            width: 708
                            height: 21
                            color: "#777777"
                            text: qsTr("Carpeta Escogida: "+folderLocation)
                            anchors.left: parent.left
                            anchors.top: parent.to
                            anchors.bottom: parent.bottom
                            anchors.topMargin: 48
                            anchors.bottomMargin: 8
                            anchors.leftMargin: 13
                            font.pointSize: 9
                            anchors.rightMargin: 10
                        }
                        anchors.rightMargin: 15
                    }

                    Rectangle {
                        id: rectC
                        x: 28
                        y: 31
                        width: 177
                        height: 22
                        color: "#ffffff"
                        radius: 12
                        anchors.top: parent.top
                        anchors.topMargin: 193
                        Label {
                            id: countLabel
                            y: 1
                            width: 156
                            height: 21
                            color: "#777777"
                            text: qsTr("cantidad de archivos: "+list1.count())
                            anchors.left: parent.left
                            anchors.top: parent.to
                            anchors.bottom: parent.bottom
                            anchors.topMargin: 48
                            anchors.bottomMargin: 0
                            anchors.leftMargin: 13
                            font.pointSize: 9
                            anchors.rightMargin: 10
                        }
                    }
                }


            }


            anchors.rightMargin: 8
        }

        CustomTopBar {
            id: bar
            x: 18
            y: 0
            width: parent.width/2>375 ? parent.width/2 : 375
            height: 40
            repeaterModel: [{text:"Ordenar carpeta",imgSource:"../../images/icons/carpeta.png"},
                {text:"Etiquetar Archivos",imgSource:"../../images/icons/etiqueta.png"}]
            barStyle: 0
            spacing: 0
            currentIndex: 0
            itemColor: rectangle3.color
        }
    }

    Connections {
        target: backend

    }

}


/*##^##
Designer {
    D{i:0;formeditorZoom:0.9;height:613;width:988}
}
##^##*/
