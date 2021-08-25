import QtQuick 2.0
import QtQuick.Controls 2.15
import "../controls"
import QtQuick.Layouts 1.11
import QtGraphicalEffects 1.15


Item {
    id: win
    property bool run : false

    function changeStack(){
        if (wikiRadio.checked){
            return 0
        }else if (googleRadio.checked) {
            return 1
        }else if(textRadio.checked) {
            return 2
        }else if (urlRadio.checked){
            return 3
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

        CustomTopBar{
            id: bar
            x: 0
            y: 5
            height: 40
            //anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width/2
            spacing: 0
            itemColor : rectangle.color
            barStyle: 0
            radio: 4
            currentIndex: 0
            repeaterModel: [{text:"Wikipedia",imgSource:"../../images/icons/wikipedia_icon.png"},
                             {text:"Google",imgSource:"../../images/icons/google_icon.png"},
                             {text:"Text",imgSource:"../../images/icons/text_icon.png"},
                             {text:"Url",imgSource:"../../images/icons/url_icon.svg"}]
        }

        StackLayout {
            id: stackLayout
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: bar.bottom
            anchors.bottom: parent.bottom
            currentIndex: bar.currentIndex

            Item {
                anchors.fill : parent

                Rectangle {
                    id: rectangle
                    color: "#97d4f0"
                    radius:12
                    anchors.fill: parent

                    Column {
                        id: columnLayout1
                        anchors.fill: parent
                        anchors.rightMargin: 10
                        anchors.leftMargin: 10
                        anchors.bottomMargin: 10
                        anchors.topMargin: 10

                        Rectangle {
                            id: rectangleTop
                            color: "#03738c"
                            height: 69
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.top: label1.bottom
                            anchors.rightMargin: 50
                            anchors.leftMargin: 50
                            anchors.topMargin: 7
                            radius: 12


                            GridLayout {
                                anchors.fill: parent
                                anchors.rightMargin: 10
                                anchors.leftMargin: 10
                                rows: 1
                                columns:  3
                                CustomTextField {
                                    id: inputText
                                    font.pointSize: 10
                                    font.family: "Sans Serif"
                                    fontColor: "#151212"
                                    placeholderTextColor: "#121314"
                                    bgColor: "#ffffff"
                                    Layout.fillWidth: true
                                    Layout.fillHeight: false
                                    Keys.onEnterPressed: {
                                        backend.startSearch(inputText.text, responseType.checked, "W")
                                        inputText.text = ""
                                    }
                                    Keys.onReturnPressed: {
                                        backend.startSearch(inputText.text, responseType.checked, "W")
                                        inputText.text = ""
                                    }

                                }


                                CustomButton {
                                    id: customBtn
                                    text: "Buscar"
                                    font.pointSize: 10
                                    font.family: "Sans Serif"
                                    btnColorMouseOver: "#fb9850"
                                    btnColorClicked: "#009925"
                                    Layout.maximumHeight: 65535
                                    btnColorDefault: "#f98125"
                                    Layout.maximumWidth: 150
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 40
                                    Layout.preferredWidth: 250

                                    onClicked: {
                                        if (inputText.text === ""){
                                            inputText.placeholderText = "Ingrese un texto válido"
                                            inputText.placeholderTextColor = "#f00"
                                            inputText.borderColor = "#f00"
                                        }else {
                                            textWiki.text = ""
                                            wordsWiki.text = ""
                                            wikiBusy.timerFunction = () => backend.startSearch(String(inputText.text), responseType.checked, "W")
                                            wikiBusy.start()
                                            inputText.placeholderText = "Ingrese un texto válido"
                                            inputText.placeholderTextColor = "#121314"
                                            inputText.borderColor = "#00000000"
                                        }
                                        
                                    }

                                }

                                Switch {
                                    id: responseType
                                    text: "Use Open AI"
                                    font.capitalization: Font.MixedCase
                                    Layout.maximumWidth: 200
                                    Layout.fillHeight: false
                                    Layout.fillWidth: false
                                    checked: false
                                    Layout.preferredHeight: 40
                                    Layout.preferredWidth: 140
                                }
                            }


                        }

                        Rectangle {
                            id: rectangleVisible
                            color: "#ffffff"
                            radius: 12
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.top: rectangleTop.bottom
                            anchors.bottom: parent.bottom
                            anchors.rightMargin: 50
                            anchors.bottomMargin: 150
                            anchors.leftMargin: 50
                            anchors.topMargin: 28
                            Flickable {
                                id: flickable
                                clip: true
                                anchors.left: parent.left
                                anchors.right: parent.right
                                anchors.top: parent.top
                                anchors.bottom: parent.bottom
                                anchors.topMargin: 10
                                anchors.bottomMargin: 17
                                anchors.rightMargin: 10
                                anchors.leftMargin: 10

                                TextArea.flickable: TextArea {
                                    id: textWiki
                                    padding: 10
                                    wrapMode: Text.WordWrap
                                    font.capitalization: Font.MixedCase
                                    font.family: "Sans Serif"
                                    placeholderTextColor: "#0c1012"
                                    textFormat: Text.AutoText
                                    selectByMouse: true
                                    selectedTextColor: "#ffffff"
                                    selectionColor: "#ff007f"
                                    color: "#000000"
                                    font.pixelSize: 14
                                    text: ""
                                }

                                ScrollBar.vertical: ScrollBar{}
                            }

                            CustomBusyIndicator{
                                id: wikiBusy
                                anchors.centerIn: parent
                                implicitWidth: 96
                                implicitHeight: 96
                                running: false
                                mainColor: '#38A1DB'
                                secondaryColor: '#33E2F2'
                            }
                        }

                        Column {
                            id: column
                            width: 200
                            anchors.top: rectangleVisible5.bottom
                            anchors.bottom: parent.bottom
                            anchors.horizontalCenterOffset: 5
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.bottomMargin: 7
                            anchors.topMargin: 7

                            Label {
                                id: label
                                color: "#000000"
                                text: qsTr("Powered by ")
                                anchors.left: parent.left
                                anchors.right: parent.right
                                anchors.top: parent.top
                                anchors.bottom: parent.bottom
                                font.family: "Sans Serif"
                                font.pointSize: 11
                                anchors.bottomMargin: 0
                                anchors.topMargin: 0
                                anchors.rightMargin: 130
                                anchors.leftMargin: 0
                            }

                            Image {
                                id: image
                                anchors.left: label.right
                                anchors.right: parent.right
                                anchors.top: parent.top
                                anchors.bottom: parent.bottom
                                source: "../../images/icons/OpenAI_Logo.svg"
                                antialiasing: true
                                anchors.topMargin: 0
                                anchors.bottomMargin: 0
                                anchors.rightMargin: 0
                                anchors.leftMargin: 5
                                fillMode: Image.PreserveAspectFit
                            }
                        }

                        Label {
                            id: label1
                            color: "#000000"
                            text: qsTr("BUSCA UNA DEFINICIÓN EN WIKIPEDA")
                            anchors.left: parent.left
                            anchors.top: parent.top
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            font.pointSize: 15
                            anchors.leftMargin: 80
                            anchors.topMargin: 20
                        }

                        Image {
                            id: image1
                            width: 40
                            anchors.left: parent.left
                            anchors.top: parent.top
                            anchors.bottom: rectangleTop.top
                            source: "../../images/icons/wikipedia_icon.png"
                            anchors.bottomMargin: 5
                            anchors.leftMargin: 30
                            anchors.topMargin: 10
                            fillMode: Image.PreserveAspectFit
                            antialiasing: false
                        }

                        Rectangle {
                            id: rectangleVisible5
                            color: "#ffffff"
                            radius: 12
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.top: rectangleVisible.bottom
                            anchors.bottom: parent.bottom
                            Flickable {
                                id: flickable5
                                anchors.left: parent.left
                                anchors.right: parent.right
                                anchors.top: parent.top
                                anchors.bottom: parent.bottom
                                anchors.bottomMargin: 17
                                clip: true
                                anchors.topMargin: 10
                                anchors.leftMargin: 10
                                TextArea.flickable: TextArea {
                                    id: wordsWiki
                                    color: "#000000"
                                    text: ""
                                    font.pixelSize: 20
                                    wrapMode: Text.WordWrap
                                    font.bold: true
                                    selectByMouse: true
                                    placeholderTextColor: "#0c1012"
                                    textFormat: Text.AutoText
                                    selectedTextColor: "#ffffff"
                                    selectionColor: "#ff007f"
                                    padding: 10
                                    font.capitalization: Font.MixedCase
                                    font.family: "Sans Serif"
                                }
                                anchors.rightMargin: 10
                                ScrollBar.vertical: ScrollBar {
                                }
                            }
                            anchors.bottomMargin: 31
                            anchors.topMargin: 5
                            anchors.leftMargin: 60
                            anchors.rightMargin: 60
                        }
                    }

                }
            }
            Item {
                Rectangle {
                    id: rectangle3
                    color: "#97d4f0"
                    radius: 12
                    anchors.fill: parent

                    Column {
                        id: columnLayout2
                        anchors.fill: parent
                        Rectangle {
                            id: rectangleTop1
                            height: 69
                            color: "#03738c"
                            radius: 12
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.top: label3.bottom
                            GridLayout {
                                anchors.fill: parent
                                CustomTextField {
                                    id: inputText1
                                    Layout.fillHeight: false
                                    Keys.onReturnPressed: {
                                        backend.startSearch(inputText1.text, responseType1.checked, "G")
                                        inputText1.text = ""
                                    }
                                    font.family: "Sans Serif"
                                    bgColor: "#ffffff"
                                    fontColor: "#151212"
                                    font.pointSize: 10
                                    Keys.onEnterPressed: {
                                        backend.startSearch(inputText1.text, responseType1.checked, "G")
                                        inputText1.text = ""
                                    }
                                    placeholderTextColor: "#121314"
                                    Layout.fillWidth: true
                                }

                                CustomButton {
                                    id: customBtn1
                                    text: "Buscar"
                                    btnColorDefault: "#f98125"
                                    Layout.preferredHeight: 40
                                    Layout.maximumHeight: 65535
                                    font.family: "Sans Serif"
                                    Layout.preferredWidth: 250
                                    onClicked: {
                                        if (inputText1.text === ""){
                                            inputText1.placeholderText = "Ingrese un texto válido"
                                            inputText1.placeholderTextColor = "#f00"
                                            inputText1.borderColor = "#f00"
                                        }else {
                                            textGoogle.text = ""
                                            wordsGoogle.text = ""
                                            googleBusy.timerFunction = () => backend.startSearch(inputText1.text, responseType1.checked, "G")
                                            googleBusy.start()
                                            inputText1.placeholderText = "Ingrese un texto válido"
                                            inputText1.placeholderTextColor = "#121314"
                                            inputText1.borderColor = "#00000000"
                                        }
                                    }
                                    font.pointSize: 10
                                    Layout.maximumWidth: 150
                                    btnColorMouseOver: "#fb9850"
                                    btnColorClicked: "#009925"
                                    Layout.fillWidth: true
                                }

                                Switch {
                                    id: responseType1
                                    text: "Use Open AI"
                                    Layout.preferredHeight: 40
                                    Layout.fillHeight: false
                                    Layout.preferredWidth: 140
                                    checked: false
                                    Layout.maximumWidth: 200
                                    Layout.fillWidth: false
                                }
                                rows: 1
                                columns: 3
                                anchors.rightMargin: 10
                                anchors.leftMargin: 10
                            }
                            anchors.rightMargin: 50
                            anchors.leftMargin: 50
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
                            Flickable {
                                id: flickable1
                                anchors.left: parent.left
                                anchors.right: parent.right
                                anchors.top: parent.top
                                anchors.bottom: parent.bottom
                                anchors.rightMargin: 10
                                TextArea.flickable: TextArea {
                                    id: textGoogle
                                    color: "#000000"
                                    text: ""
                                    font.pixelSize: 14
                                    wrapMode: Text.WordWrap
                                    font.family: "Sans Serif"
                                    textFormat: Text.AutoText
                                    selectByMouse: true
                                    selectionColor: "#ff007f"
                                    placeholderTextColor: "#0c1012"
                                    selectedTextColor: "#ffffff"
                                    padding: 10
                                }
                                clip: true
                                anchors.leftMargin: 10
                                anchors.topMargin: 10
                                anchors.bottomMargin: 17
                                ScrollBar.vertical: ScrollBar {
                                }
                            }
                            anchors.rightMargin: 50
                            anchors.leftMargin: 50
                            anchors.bottomMargin: 150
                            anchors.topMargin: 28

                            CustomBusyIndicator{
                                id: googleBusy
                                anchors.centerIn: parent
                                implicitWidth: 96
                                implicitHeight: 96
                                running: false
                                mainColor: '#38A1DB'
                                secondaryColor: '#33E2F2'
                            }
                        }

                        Column {
                            id: column1
                            width: 200
                            anchors.top: rectangleVisible6.bottom
                            anchors.bottom: parent.bottom
                            anchors.horizontalCenterOffset: 5
                            Label {
                                id: label2
                                color: "#000000"
                                text: qsTr("Powered by ")
                                anchors.left: parent.left
                                anchors.right: parent.right
                                anchors.top: parent.top
                                anchors.bottom: parent.bottom
                                font.family: "Sans Serif"
                                anchors.rightMargin: 130
                                font.pointSize: 11
                                anchors.leftMargin: 0
                                anchors.bottomMargin: 0
                                anchors.topMargin: 0
                            }

                            Image {
                                id: image2
                                anchors.left: label2.right
                                anchors.right: parent.right
                                anchors.top: parent.top
                                anchors.bottom: parent.bottom
                                source: "../../images/icons/OpenAI_Logo.svg"
                                antialiasing: true
                                fillMode: Image.PreserveAspectFit
                                anchors.rightMargin: 0
                                anchors.leftMargin: 5
                                anchors.topMargin: 0
                                anchors.bottomMargin: 0
                            }
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.bottomMargin: 7
                            anchors.topMargin: 7
                        }

                        Label {
                            id: label3
                            color: "#000000"
                            text: qsTr("REALIZA TU BÚSQUEDA EN GOOGLE (ME SIENTO CON SUERTE)")
                            anchors.left: parent.left
                            anchors.top: parent.top
                            anchors.leftMargin: 80
                            font.pointSize: 15
                            anchors.topMargin: 20
                        }

                        Image {
                            id: image3
                            width: 40
                            anchors.left: parent.left
                            anchors.top: parent.top
                            anchors.bottom: rectangleTop1.top
                            source: "../../images/icons/google_icon.png"
                            antialiasing: false
                            fillMode: Image.PreserveAspectFit
                            anchors.leftMargin: 30
                            anchors.topMargin: 10
                            anchors.bottomMargin: 5
                        }

                        Rectangle {
                            id: rectangleVisible6
                            color: "#ffffff"
                            radius: 12
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.top: rectangleVisible1.bottom
                            anchors.bottom: parent.bottom
                            Flickable {
                                id: flickable6
                                anchors.left: parent.left
                                anchors.right: parent.right
                                anchors.top: parent.top
                                anchors.bottom: parent.bottom
                                anchors.bottomMargin: 17
                                clip: true
                                anchors.topMargin: 10
                                anchors.leftMargin: 10
                                TextArea.flickable: TextArea {
                                    id: wordsGoogle
                                    color: "#000000"
                                    text: ""
                                    font.pixelSize: 20
                                    wrapMode: Text.WordWrap
                                    font.bold: true
                                    selectByMouse: true
                                    placeholderTextColor: "#0c1012"
                                    textFormat: Text.AutoText
                                    selectedTextColor: "#ffffff"
                                    selectionColor: "#ff007f"
                                    padding: 10
                                    font.family: "Sans Serif"
                                }
                                anchors.rightMargin: 10
                                ScrollBar.vertical: ScrollBar {
                                }
                            }
                            anchors.bottomMargin: 31
                            anchors.topMargin: 5
                            anchors.leftMargin: 60
                            anchors.rightMargin: 60
                        }
                        anchors.rightMargin: 10
                        anchors.leftMargin: 10
                        anchors.topMargin: 10
                        anchors.bottomMargin: 10
                    }
                }
            }

            Item {
                Rectangle {
                    id: rectangle1
                    color: "#97d4f0"
                    radius: 12
                    anchors.fill: parent

                    Column {
                        id: columnLayout3
                        anchors.fill: parent
                        anchors.rightMargin: 10
                        Rectangle {
                            id: rectangleTop2
                            height: 69
                            color: "#03738c"
                            radius: 12
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.top: parent.top
                            anchors.rightMargin: 120
                            GridLayout {
                                anchors.fill: parent
                                columnSpacing: 0
                                rowSpacing: 3
                                anchors.rightMargin: 10

                                Label {
                                    id: label5
                                    color: "#ffffff"
                                    text: qsTr("INGRESA Y RESUME TU PROPIO TEXTO")
                                    Layout.fillWidth: true
                                    font.pointSize: 15
                                }

                                CustomButton {
                                    id: customBtn2
                                    text: "Resumir"
                                    Layout.minimumHeight: 40
                                    Layout.minimumWidth: 150
                                    font.family: "Sans Serif"
                                    Layout.preferredWidth: 150
                                    Layout.fillWidth: true
                                    Layout.maximumHeight: 200
                                    onClicked: {
                                        if (usrText.text === ""){
                                            usrText.placeholderText = "Ingrese un texto válido"
                                        }else {
                                            usrResult.text = ""
                                            usrWords.text = ""
                                            textBusy.timerFunction = () => backend.startSearch(usrText.text, responseType2.checked, "T")
                                            textBusy.start()
                                            usrText.placeholderText = "Tu texto aquí..."
                                            usrText.borderColor = "#00000000"
                                        }
                                    }
                                    font.pointSize: 10
                                    btnColorMouseOver: "#fb9850"
                                    btnColorDefault: "#f98125"
                                    Layout.preferredHeight: 40
                                    btnColorClicked: "#009925"
                                    Layout.maximumWidth: 500
                                }

                                Switch {
                                    id: responseType2
                                    text: "Use Open AI"
                                    Layout.preferredWidth: 140
                                    Layout.fillWidth: true
                                    checked: false
                                    Layout.preferredHeight: 40
                                    Layout.fillHeight: false
                                    Layout.maximumWidth: 200
                                }

                                anchors.leftMargin: 10
                                rows: 1
                                columns: 3
                            }
                            anchors.topMargin: 31
                            anchors.leftMargin: 120
                        }

                        Column {
                            id: column2
                            width: 200
                            anchors.top: rowLayout.bottom
                            anchors.bottom: parent.bottom
                            Label {
                                id: label4
                                color: "#000000"
                                text: qsTr("Powered by ")
                                anchors.left: parent.left
                                anchors.right: parent.right
                                anchors.top: parent.top
                                anchors.bottom: parent.bottom
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                anchors.rightMargin: 115
                                font.family: "Sans Serif"
                                anchors.topMargin: 0
                                anchors.leftMargin: 0
                                font.pointSize: 11
                                anchors.bottomMargin: 0
                            }

                            Image {
                                id: image4
                                anchors.left: label4.right
                                anchors.right: parent.right
                                anchors.top: parent.top
                                anchors.bottom: parent.bottom
                                source: "../../images/icons/OpenAI_Logo.svg"
                                anchors.rightMargin: 0
                                anchors.topMargin: 0
                                anchors.leftMargin: 5
                                fillMode: Image.PreserveAspectFit
                                anchors.bottomMargin: 0
                                antialiasing: true
                            }
                            anchors.topMargin: 7
                            anchors.horizontalCenterOffset: 5
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.bottomMargin: 7
                        }

                        Image {
                            id: image5
                            anchors.left: parent.left
                            anchors.right: rectangleTop2.left
                            anchors.top: parent.top
                            anchors.bottom: rowLayout.top
                            source: "../../images/icons/text_icon.png"
                            anchors.bottomMargin: 17
                            anchors.rightMargin: 20
                            anchors.topMargin: 40
                            anchors.leftMargin: 30
                            fillMode: Image.PreserveAspectFit
                            antialiasing: false
                        }
                        ColorOverlay {
                            anchors.fill: image5
                            source: image5
                            color: "#f6b851"
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: parent.left
                            antialiasing: true
                            width: iconWidth
                            height: iconHeight
                        }

                        RowLayout {
                            id: rowLayout
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.top: rectangleTop2.bottom
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: 31
                            anchors.rightMargin: 20
                            anchors.leftMargin: 20
                            anchors.topMargin: 10

                            Rectangle {
                                id: rectangleVisible2
                                width: 398
                                height: 372
                                color: "#ffffff"
                                radius: 12
                                Layout.fillHeight: true
                                Layout.fillWidth: true
                                Layout.maximumHeight: 5000
                                Layout.maximumWidth: 6000
                                Layout.minimumHeight: 372
                                Layout.minimumWidth: 398
                                Layout.preferredHeight: 372
                                Layout.preferredWidth: 398
                                Flickable {
                                    id: flickable2
                                    anchors.left: parent.left
                                    anchors.right: parent.right
                                    anchors.top: parent.top
                                    anchors.bottom: parent.bottom
                                    anchors.rightMargin: 10
                                    clip: true
                                    anchors.topMargin: 10
                                    TextArea.flickable: TextArea {
                                        id: usrText
                                        color: "#000000"
                                        text: ""
                                        font.pixelSize: 14
                                        wrapMode: Text.WordWrap
                                        placeholderText: "TU TEXTO AQUÍ..."
                                        font.family: "Sans Serif"
                                        selectionColor: "#ff007f"
                                        placeholderTextColor: "#61002a39"
                                        selectByMouse: true
                                        padding: 10
                                        textFormat: Text.AutoText
                                        selectedTextColor: "#ffffff"
                                    }
                                    anchors.leftMargin: 10
                                    ScrollBar.vertical: ScrollBar {}
                                    anchors.bottomMargin: 17
                                }
                            }

                            Column {
                                id: column4
                                width: 200
                                height: 400
                                Layout.maximumHeight: 5000
                                Layout.maximumWidth: 6000
                                Layout.minimumHeight: 372
                                Layout.minimumWidth: 398
                                Layout.preferredHeight: 372
                                Layout.preferredWidth: 398
                                Layout.fillHeight: true
                                Layout.fillWidth: true

                                Rectangle {
                                    id: rectangleVisible3
                                    color: "#ffffff"
                                    radius: 12
                                    anchors.left: parent.left
                                    anchors.right: parent.right
                                    anchors.top: parent.top
                                    anchors.bottom: parent.bottom
                                    anchors.bottomMargin: 150
                                    anchors.rightMargin: 0
                                    anchors.leftMargin: 0
                                    anchors.topMargin: 0
                                    Layout.fillHeight: true
                                    Layout.maximumHeight: 5000
                                    Layout.maximumWidth: 6000
                                    Layout.minimumHeight: 372
                                    Layout.preferredHeight: 372
                                    Layout.minimumWidth: 398
                                    Layout.preferredWidth: 398
                                    Layout.fillWidth: true
                                    Flickable {
                                        id: flickable3
                                        anchors.left: parent.left
                                        anchors.right: parent.right
                                        anchors.top: parent.top
                                        anchors.bottom: parent.bottom
                                        anchors.rightMargin: 10
                                        clip: true
                                        anchors.topMargin: 10
                                        TextArea.flickable: TextArea {
                                            id: usrResult
                                            color: "#000000"
                                            text: ""
                                            font.pixelSize: 14
                                            wrapMode: Text.WordWrap
                                            font.family: "Sans Serif"
                                            selectionColor: "#ff007f"
                                            placeholderTextColor: "#0c1012"
                                            selectByMouse: true
                                            padding: 10
                                            selectedTextColor: "#ffffff"
                                            textFormat: Text.AutoText
                                        }
                                        anchors.leftMargin: 10
                                        ScrollBar.vertical: ScrollBar {
                                        }
                                        anchors.bottomMargin: 17
                                    }

                                    CustomBusyIndicator{
                                        id: textBusy
                                        x: -279
                                        y: 148
                                        anchors.centerIn: parent
                                        implicitWidth: 96
                                        implicitHeight: 96
                                        running: false
                                        mainColor: '#38A1DB'
                                        secondaryColor: '#33E2F2'
                                    }
                                }

                                Rectangle {
                                    id: rectangleVisible8
                                    color: "#ffffff"
                                    radius: 12
                                    anchors.left: parent.left
                                    anchors.right: parent.right
                                    anchors.top: rectangleVisible3.bottom
                                    anchors.bottom: parent.bottom
                                    Flickable {
                                        id: flickable8
                                        anchors.left: parent.left
                                        anchors.right: parent.right
                                        anchors.top: parent.top
                                        anchors.bottom: parent.bottom
                                        anchors.bottomMargin: 17
                                        clip: true
                                        anchors.topMargin: 10
                                        anchors.leftMargin: 10
                                        TextArea.flickable: TextArea {
                                            id: usrWords
                                            color: "#000000"
                                            text: ""
                                            font.pixelSize: 20
                                            wrapMode: Text.WordWrap
                                            font.bold: true
                                            selectByMouse: true
                                            placeholderTextColor: "#0c1012"
                                            textFormat: Text.AutoText
                                            selectedTextColor: "#ffffff"
                                            selectionColor: "#ff007f"
                                            padding: 10
                                            font.family: "Sans Serif"
                                        }
                                        anchors.rightMargin: 10
                                        ScrollBar.vertical: ScrollBar {
                                        }
                                    }
                                    Layout.minimumWidth: 398
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                    anchors.bottomMargin: 0
                                    Layout.preferredHeight: 372
                                    anchors.leftMargin: 5
                                    anchors.rightMargin: 5
                                    Layout.maximumWidth: 6000
                                    anchors.topMargin: 5
                                    Layout.minimumHeight: 372
                                    Layout.preferredWidth: 398
                                    Layout.maximumHeight: 5000
                                }
                            }
                        }
                        anchors.topMargin: 10
                        anchors.leftMargin: 10
                        anchors.bottomMargin: 10
                    }
                }
            }

            Item {
                Rectangle {
                    id: rectangle2
                    color: "#97d4f0"
                    radius: 12
                    anchors.fill: parent

                    Column {
                        id: columnLayout4
                        anchors.fill: parent
                        anchors.rightMargin: 10
                        anchors.topMargin: 10
                        Rectangle {
                            id: rectangleTop3
                            height: 69
                            color: "#03738c"
                            radius: 12
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.top: label7.bottom
                            anchors.rightMargin: 50
                            anchors.topMargin: 7
                            GridLayout {
                                anchors.fill: parent
                                anchors.rightMargin: 10
                                columns: 3
                                CustomTextField {
                                    id: inputText2
                                    placeholderText: "Introduce tu URL..."
                                    font.pointSize: 10
                                    Keys.onReturnPressed: {
                                        backend.startSearch(inputText2.text, responseType3.checked, "U")
                                        inputText2.text = ""
                                    }
                                    Keys.onEnterPressed: {
                                        backend.startSearch(inputText2.text, responseType3.checked, "U")
                                        inputText2.text = ""
                                    }
                                    fontColor: "#151212"
                                    font.family: "Sans Serif"
                                    Layout.fillWidth: true
                                    placeholderTextColor: "#121314"
                                    bgColor: "#ffffff"
                                    Layout.fillHeight: false
                                }

                                CustomButton {
                                    id: customBtn3
                                    text: "Buscar"
                                    font.pointSize: 10
                                    btnColorDefault: "#f98125"
                                    Layout.preferredWidth: 250
                                    onClicked: {
                                        if (inputText2.text === ""){
                                            inputText2.placeholderText = "Ingrese un texto válido"
                                            inputText2.placeholderTextColor = "#f00"
                                            inputText2.borderColor = "#f00"
                                        }else {
                                            textUrl.text = ""
                                            wordsUrl.text = ""
                                            urlBusy.timerFunction = () => backend.startSearch(String(inputText2.text), responseType3.checked, "U")
                                            urlBusy.start()
                                            inputText2.placeholderText = "Ingrese un texto válido"
                                            inputText2.placeholderTextColor = "#121314"
                                            inputText2.borderColor = "#00000000"
                                        }
                                    }
                                    font.family: "Sans Serif"
                                    Layout.fillWidth: true
                                    btnColorClicked: "#009925"
                                    Layout.preferredHeight: 40
                                    Layout.maximumHeight: 65535
                                    Layout.maximumWidth: 150
                                    btnColorMouseOver: "#fb9850"
                                }

                                Switch {
                                    id: responseType3
                                    text: "Use Open AI"
                                    checked: false
                                    Layout.preferredWidth: 140
                                    font.capitalization: Font.MixedCase
                                    Layout.fillWidth: false
                                    Layout.preferredHeight: 40
                                    Layout.maximumWidth: 200
                                    Layout.fillHeight: false
                                }
                                rows: 1
                                anchors.leftMargin: 10
                            }
                            anchors.leftMargin: 50
                        }

                        Rectangle {
                            id: rectangleVisible4
                            color: "#ffffff"
                            radius: 12
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.top: rectangleTop3.bottom
                            anchors.bottom: parent.bottom
                            anchors.rightMargin: 50
                            anchors.topMargin: 28
                            Flickable {
                                id: flickable4
                                anchors.left: parent.left
                                anchors.right: parent.right
                                anchors.top: parent.top
                                anchors.bottom: parent.bottom
                                TextArea.flickable: TextArea {
                                    id: textUrl
                                    color: "#000000"
                                    text: ""
                                    font.pixelSize: 14
                                    wrapMode: Text.WordWrap
                                    selectedTextColor: "#ffffff"
                                    font.capitalization: Font.MixedCase
                                    padding: 10
                                    font.family: "Sans Serif"
                                    textFormat: Text.AutoText
                                    selectByMouse: true
                                    selectionColor: "#ff007f"
                                    placeholderTextColor: "#0c1012"
                                }
                                ScrollBar.vertical: ScrollBar {
                                }
                                anchors.topMargin: 10
                                anchors.rightMargin: 10
                                clip: true
                                anchors.leftMargin: 10
                                anchors.bottomMargin: 17
                            }
                            CustomBusyIndicator{
                                id: urlBusy
                                anchors.centerIn: parent
                                implicitWidth: 96
                                implicitHeight: 96
                                running: false
                                mainColor: '#38A1DB'
                                secondaryColor: '#33E2F2'
                            }
                            anchors.leftMargin: 50
                            anchors.bottomMargin: 150
                        }

                        Column {
                            id: column3
                            width: 200
                            anchors.top: rectangleVisible7.bottom
                            anchors.bottom: parent.bottom
                            anchors.topMargin: 7
                            anchors.horizontalCenterOffset: 5
                            Label {
                                id: label6
                                color: "#000000"
                                text: qsTr("Powered by ")
                                anchors.left: parent.left
                                anchors.right: parent.right
                                anchors.top: parent.top
                                anchors.bottom: parent.bottom
                                font.pointSize: 11
                                anchors.topMargin: 0
                                anchors.rightMargin: 130
                                font.family: "Sans Serif"
                                anchors.leftMargin: 0
                                anchors.bottomMargin: 0
                            }

                            Image {
                                id: image6
                                anchors.left: label6.right
                                anchors.right: parent.right
                                anchors.top: parent.top
                                anchors.bottom: parent.bottom
                                source: "../../images/icons/OpenAI_Logo.svg"
                                anchors.topMargin: 0
                                anchors.rightMargin: 0
                                antialiasing: true
                                fillMode: Image.PreserveAspectFit
                                anchors.leftMargin: 5
                                anchors.bottomMargin: 0
                            }
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.bottomMargin: 7
                        }

                        Label {
                            id: label7
                            color: "#000000"
                            text: qsTr("Resume una página web")
                            anchors.left: parent.left
                            anchors.top: parent.top
                            font.pointSize: 15
                            anchors.topMargin: 20
                            anchors.leftMargin: 80
                        }

                        Image {
                            id: image7
                            width: 40
                            anchors.left: parent.left
                            anchors.top: parent.top
                            anchors.bottom: rectangleTop3.top
                            source: "../../images/icons/url_icon.svg"
                            anchors.topMargin: 10
                            antialiasing: false
                            fillMode: Image.PreserveAspectFit
                            anchors.leftMargin: 30
                            anchors.bottomMargin: 5
                        }

                        Rectangle {
                            id: rectangleVisible7
                            color: "#ffffff"
                            radius: 12
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.top: rectangleVisible4.bottom
                            anchors.bottom: parent.bottom
                            Flickable {
                                id: flickable7
                                anchors.left: parent.left
                                anchors.right: parent.right
                                anchors.top: parent.top
                                anchors.bottom: parent.bottom
                                anchors.bottomMargin: 17
                                clip: true
                                anchors.topMargin: 10
                                anchors.leftMargin: 10
                                TextArea.flickable: TextArea {
                                    id: wordsUrl
                                    color: "#000000"
                                    text: ""
                                    font.pixelSize: 20
                                    wrapMode: Text.WordWrap
                                    font.bold: true
                                    selectByMouse: true
                                    placeholderTextColor: "#0c1012"
                                    textFormat: Text.AutoText
                                    selectedTextColor: "#ffffff"
                                    selectionColor: "#ff007f"
                                    padding: 10
                                    font.capitalization: Font.MixedCase
                                    font.family: "Sans Serif"
                                }
                                anchors.rightMargin: 10
                                ScrollBar.vertical: ScrollBar {
                                }
                            }
                            anchors.bottomMargin: 31
                            anchors.topMargin: 5
                            anchors.leftMargin: 60
                            anchors.rightMargin: 60
                        }
                        anchors.leftMargin: 10
                        anchors.bottomMargin: 10
                    }
                }
            }


        }


        CustomBusyIndicator{
            id: busy
            anchors.centerIn: parent
            implicitWidth: 96
            implicitHeight: 96
            running: false
            mainColor: '#38A1DB'
            secondaryColor: '#33E2F2'
        }
    }

    Connections {
        target: backend

        function onResponse(text) {
            switch (bar.currentIndex){
                case 0:
                    textWiki.text = text
                    break;
                case 1:
                    textGoogle.text = text
                    break;
                case 2:
                    usrResult.text = text
                    break;
                case 3:
                   textUrl.text = text
                    break;
            }
        }
        function onKeys(text) {
            switch (bar.currentIndex){
                case 0:
                    wordsWiki.text = text
                    break;
                case 1:
                    wordsGoogle.text = text
                    break;
                case 2:
                    usrWords.text = text
                    break;
                case 3:
                    wordsUrl.text = text
            }
        }
    }


}

/*##^##
Designer {
    D{i:0;autoSize:true;height:613;width:988}
}
##^##*/
