import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.11
import "../controls"
import Qt.labs.qmlmodels 1.0
import QtGraphicalEffects 1.0

Item{
    id: root

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
            anchors.fill: parent
            currentIndex: 0
            anchors.rightMargin: 10
            anchors.leftMargin: 10
            anchors.bottomMargin: 10
            anchors.topMargin: 10

            Item {
                id: index
                Rectangle {
                    id: indexBg
                    color: "#97d4f0"
                    radius: 12
                    border.color: "#ffffff"
                    border.width: 2
                    anchors.fill: parent
                    ColumnLayout {
                        id: indexColumn1
                        width: indexBg.width
                        anchors.top: parent.top
                        anchors.topMargin: 5
                        spacing: 50



                        Rectangle {
                            id: indexTitle
                            width: 850
                            height: 63
                            color: "#05608c"
                            radius: 5
                            Text {
                                color: "#ffffff"
                                text: "AYUDA"
                                anchors.fill: parent
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                wrapMode: Text.WordWrap
                                minimumPixelSize: 12
                                minimumPointSize: 12
                                font.pointSize: 20
                                anchors.rightMargin: 0
                                font.bold: true
                            }
                            Layout.fillWidth: false
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                            anchors.bottomMargin: 6
                            Layout.fillHeight: false
                        }
                        Rectangle {
                            id: indexContent
                            width: 900
                            height: 360
                            color: "#05608c"
                            radius: 5
                            Layout.fillWidth: false
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                            anchors.bottomMargin: 6
                            Layout.fillHeight: false

                            RowLayout {
                                id: rowLayout
                                anchors.fill: parent
                                spacing: 5.3

                                CustomCard {
                                    id: consultantCard
                                    width: 200
                                    height: 200
                                    color: "#ff872b"
                                    border.color: "#ee8311"
                                    gradColor: "#ff7a11"
                                    title: "Consultor"
                                    desc: "Aplicación que te hará tu vida académica mucho más sencilla, en esta herramienta podrás hacer consultas en diferentes motores de busqueda y la obtendrás resumida. además de tener las palabras claves del texto."
                                    bgColor: "#de6108"
                                    imagen: "../../images/icons/search_icon.svg"
                                    Layout.topMargin: 10
                                    Layout.fillHeight: true
                                    Layout.bottomMargin: 10
                                    Layout.fillWidth: true
                                    Layout.leftMargin: 10
                                    ColorAnimation on gradColor{
                                        id: consultAnimation
                                        from: consultantCard.bgColor
                                        to: "#FFAC42"
                                        duration: 500
                                        running: false
                                    }

                                    ColorAnimation on gradColor{
                                        id: consultAnimation1
                                        from: "#FFAC42"
                                        to: consultantCard.bgColor
                                        duration: 1000
                                        running: !consultorArea.containsMouse
                                    }

                                    MouseArea {
                                        id: consultorArea
                                        anchors.fill: parent
                                        hoverEnabled: true
                                        onHoveredChanged: {
                                            consultAnimation.running = !consultAnimation.running
                                        }
                                        onClicked: {
                                            stackLayout.currentIndex = 1
                                        }
                                    }
                                }

                                CustomCard {
                                    id: pdfsCard
                                    width: 200
                                    height: 200
                                    color: "#e10000"
                                    txtColor: "#e4dbdb"
                                    bgColor: "#720909"
                                    title: "PDF's Editor"
                                    desc: "Aplicación que te permitirá modificar tus archivos PDF, además de poder unir distintos archivos en uno."
                                    gradColor: "#720909"
                                    imagen: "../../images/icons/pdf.svg"
                                    Layout.topMargin: 10
                                    Layout.fillHeight: true
                                    Layout.bottomMargin: 10
                                    Layout.fillWidth: true
                                    Layout.leftMargin: 0
                                    ColorAnimation on gradColor{
                                        id: pdfsAnimation
                                        from: "#720909"
                                        to: "#e10000"
                                        duration: 500
                                        running: false
                                    }

                                    ColorAnimation on gradColor{
                                        id: pdfsAnimation1
                                        from: "#e10000"
                                        to: "#720909"
                                        duration: 1000
                                        running: !pdfsArea.containsMouse
                                    }
                                    MouseArea {
                                        id: pdfsArea
                                        anchors.fill: parent
                                        hoverEnabled: true
                                        onHoveredChanged: {
                                            pdfsAnimation.running = !pdfsAnimation.running
                                        }
                                        onClicked: {
                                            stackLayout.currentIndex = 2
                                        }
                                    }
                                }

                                CustomCard {
                                    id: sorterCard
                                    width: 200
                                    height: 200
                                    color: "#c700f6"
                                    bgColor: "#37017a"
                                    title: "Folders Sorter"
                                    desc: "Aplicación que organiza en distintas carpetas tus archivos a tu gusto ya sea por la extensión de los mismos, o una etiqueta asignada por ti."
                                    gradColor: "#37017a"
                                    imagen: "../../images/icons/sortIcon.png"
                                    txtColor: "white"
                                    Layout.topMargin: 10
                                    Layout.fillHeight: true
                                    Layout.bottomMargin: 10
                                    Layout.fillWidth: true
                                    Layout.leftMargin: 0
                                    ColorAnimation on gradColor{
                                        id: sorterAnimation
                                        from: "#37017a"
                                        to: "#c700f6"
                                        duration: 500
                                        running: false
                                    }

                                    ColorAnimation on gradColor{
                                        id: sorterAnimation1
                                        from: "#c700f6"
                                        to: "#37017a"
                                        duration: 1000
                                        running: !sorterArea.containsMouse
                                    }
                                    MouseArea {
                                        id: sorterArea
                                        anchors.fill: parent
                                        hoverEnabled: true
                                        onHoveredChanged: {
                                            sorterAnimation.running = !sorterAnimation.running
                                        }
                                        onClicked: {
                                            //stackLayout.currentIndex = 3
                                            console.log("En Construcción")
                                        }
                                    }
                                }

                                CustomCard {
                                    id: generatorCard
                                    width: 200
                                    height: 200
                                    color: "#14d1e7"
                                    txtColor: "#f7f6f6"
                                    bgColor: "#0633a8"
                                    Layout.rightMargin: 10
                                    title: "Format Documents"
                                    desc: "Aplicación que generará tus documentos con un formato específico dado por tí y un perfil que dará los datos y permitrá generar varios a la vez."
                                    gradColor: "#0633a8"
                                    imagen: "../../images/icons/docx_icon.png"
                                    Layout.topMargin: 10
                                    Layout.fillHeight: true
                                    Layout.bottomMargin: 10
                                    Layout.fillWidth: true
                                    Layout.leftMargin: 0
                                    ColorAnimation on gradColor{
                                        id: generatorAnimation
                                        from: "#0633a8"
                                        to: "#14d1e7"
                                        duration: 500
                                        running: false
                                    }

                                    ColorAnimation on gradColor{
                                        id: generatorAnimation1
                                        from: "#14d1e7"
                                        to: "#0633a8"
                                        duration: 1000
                                        running: !generatorArea.containsMouse
                                    }
                                    MouseArea {
                                        id: generatorArea
                                        anchors.fill: parent
                                        hoverEnabled: true
                                        onHoveredChanged: {
                                            generatorAnimation.running = !generatorAnimation.running
                                        }
                                        onClicked: {
                                            //stackLayout.currentIndex = 4
                                            console.log("En Construcción")
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }

            Item {
                id: consultorHelp

                Rectangle {
                    id: consultorContainer
                    color: "#97d4f0"
                    radius: 12
                    anchors.fill: parent
                    anchors.bottomMargin: 5
                    clip: true
                    anchors.leftMargin: 5
                    anchors.topMargin: 5
                    anchors.rightMargin: 5


                    ScrollView {
                        id: consScrollView
                        x: 0
                        y: 0
                        anchors.fill: parent
                        anchors.bottomMargin: 0
                        anchors.leftMargin: 0
                        anchors.topMargin: 0

                        ColumnLayout {
                            id: contentLayout
                            anchors.fill: parent
                            anchors.bottomMargin: 10
                            anchors.leftMargin: 10
                            anchors.topMargin: 10
                            spacing: 6
                            anchors.rightMargin: 10
                            CustomButton {
                                id: back
                                width: 40
                                height: 40
                                Layout.minimumHeight: 40
                                Layout.minimumWidth: 40
                                btnColorMouseOver: "#00000000"
                                btnColorClicked: "#00000000"
                                btnColorDefault: "#00000000"
                                Image {
                                    anchors.fill: parent
                                    source: "../../images/icons/previous.svg"
                                    fillMode: Image.PreserveAspectFit
                                }
                                onClicked: {
                                    stackLayout.currentIndex = 0
                                    console.log('back')
                                }
                            }

                            Rectangle {
                                id: consultTitle
                                width: 850
                                height: 50
                                color: "#06384f"
                                radius: 5
                                Text {
                                    color: "#ffffff"
                                    text: qsTr("CONSULTOR")
                                    anchors.fill: parent
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                    wrapMode: Text.WordWrap
                                    minimumPixelSize: 12
                                    minimumPointSize: 12
                                    font.pointSize: 24
                                    anchors.rightMargin: 0
                                    font.bold: true
                                }
                                Layout.fillWidth: false
                                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                anchors.bottomMargin: 6
                                Layout.fillHeight: false
                            }

                            ToolSeparator {
                                id: toolSeparator0
                                wheelEnabled: true
                                orientation: Qt.Horizontal
                                Layout.fillWidth: true
                                spacing: 1
                                contentItem: Rectangle {
                                    color: "#fa801e"
                                    implicitHeight: parent.vertical ? 24 : 2
                                    implicitWidth: parent.vertical ? 2 : 24
                                }
                            }

                            Rectangle {
                                id: ques1
                                width: 850
                                height: 50
                                color: "#06384f"
                                radius: 5
                                Text {
                                    color: "#ffffff"
                                    text: qsTr("¿CÓMO SELECCIONAR EL MOTOR DE BÚSQUEDA?")
                                    anchors.fill: parent
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                    wrapMode: Text.WordWrap
                                    minimumPixelSize: 12
                                    minimumPointSize: 12
                                    font.pointSize: 15
                                    anchors.rightMargin: 0
                                    font.bold: true
                                }
                                Layout.fillWidth: false
                                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                anchors.bottomMargin: 6
                                Layout.fillHeight: false
                            }
                            Rectangle {
                                id: imgRes1
                                width: 770
                                height: 200
                                color: "#06384f"
                                radius: 5
                                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                Layout.fillHeight: false
                                Layout.fillWidth: false

                                AnimatedImage {
                                    id: options
                                    width: parent.width-10
                                    height: parent.height
                                    source: "../../images/helpPage/searchOptions.gif"
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    Layout.fillHeight: true
                                    autoTransform: false
                                    asynchronous: false
                                    Layout.fillWidth: true
                                    playing: false
                                    cache: true
                                    speed: 2
                                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                    fillMode: Image.PreserveAspectFit

                                    MouseArea {
                                        id: mouseArea
                                        anchors.fill: parent
                                        hoverEnabled: true
                                        onHoveredChanged: {
                                            options.playing = !options.playing
                                        }
                                    }
                                }
                            }

                            Rectangle {
                                id: ans1
                                width: 850
                                height: 63
                                color: "#06384f"
                                radius: 5
                                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                Layout.fillHeight: false
                                Layout.fillWidth: false
                                Text {
                                    color: "#ffffff"
                                    text: qsTr("En la zona superior puede seleccionar el motor de búsqueda mediante el cual desea realizar la consulta y recibir el resúmen.")
                                    anchors.fill: parent
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                    wrapMode: Text.WordWrap
                                    anchors.rightMargin: 0
                                    font.pointSize: 10.5
                                    font.bold: true
                                }
                                anchors.bottomMargin: 6
                            }

                            ToolSeparator {
                                id: toolSeparator
                                wheelEnabled: true
                                orientation: Qt.Horizontal
                                Layout.fillWidth: true
                                spacing: 1
                                contentItem: Rectangle {
                                    color: "#fa801e"
                                    implicitHeight: parent.vertical ? 24 : 2
                                    implicitWidth: parent.vertical ? 2 : 24
                                }
                            }
                            Rectangle {
                                id: ques2
                                width: 850
                                height: 50
                                color: "#06384f"
                                radius: 5
                                Text {
                                    color: "#ffffff"
                                    text: qsTr("¿CÓMO CONSULTAR?")
                                    anchors.fill: parent
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                    wrapMode: Text.WordWrap
                                    minimumPixelSize: 12
                                    minimumPointSize: 12
                                    font.pointSize: 15
                                    anchors.rightMargin: 0
                                    font.bold: true
                                }
                                Layout.fillWidth: false
                                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                anchors.bottomMargin: 6
                                Layout.fillHeight: false
                            }
                            Rectangle {
                                id: imgRes2
                                width: 550
                                height: 300
                                color: "#06384f"
                                radius: 5
                                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                Layout.fillHeight: false
                                Layout.fillWidth: false

                                AnimatedImage {
                                    id: consult
                                    anchors.fill: parent
                                    source: "../../images/helpPage/searchHelp.gif"
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                    playing: false
                                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                    fillMode: Image.PreserveAspectFit
                                    MouseArea {
                                        id: mouseArea1
                                        anchors.left: parent.left
                                        anchors.top: parent.top
                                        anchors.bottom: parent.bottom
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        hoverEnabled: true
                                        onHoveredChanged: {
                                            consult.playing = !consult.playing
                                        }
                                    }
                                }
                            }

                            ToolSeparator {
                                id: toolSeparator1
                                wheelEnabled: true
                                orientation: Qt.Horizontal
                                spacing: 1
                                Layout.fillWidth: true
                                contentItem: Rectangle {
                                    color: "#fa801e"
                                    implicitHeight: parent.vertical ? 24 : 2
                                    implicitWidth: parent.vertical ? 2 : 24
                                }
                            }
                            Rectangle {
                                id: ques3
                                width: 850
                                height: 50
                                color: "#06384f"
                                radius: 5
                                Text {
                                    color: "#ffffff"
                                    text: qsTr("No recibo la respuesta esperada en la búsqueda por Google")
                                    anchors.fill: parent
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                    wrapMode: Text.WordWrap
                                    minimumPixelSize: 12
                                    minimumPointSize: 12
                                    font.pointSize: 15
                                    anchors.rightMargin: 0
                                    font.bold: true
                                }
                                Layout.fillWidth: false
                                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                anchors.bottomMargin: 6
                                Layout.fillHeight: false
                            }
                            Rectangle {
                                id: ans3
                                width: 860
                                height: 60
                                color: "#06384f"
                                radius: 5
                                Text {
                                    color: "#ffffff"
                                    text: qsTr('Debe recordar que como está especificado en la aplicación, este motor busca en modo "me siento con suerte", por lo tanto al buscar una página aleatoria, puede obtener una sin información sustancial o resumible.')
                                    anchors.fill: parent
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                    wrapMode: Text.WordWrap
                                    minimumPixelSize: 12
                                    minimumPointSize: 12
                                    font.pointSize: 10.5
                                    anchors.rightMargin: 0
                                    font.bold: true
                                }
                                Layout.fillWidth: false
                                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                anchors.bottomMargin: 6
                                Layout.fillHeight: false
                            }

                            ToolSeparator {
                                id: toolSeparator2
                                wheelEnabled: true
                                orientation: Qt.Horizontal
                                spacing: 1
                                Layout.fillWidth: true
                                contentItem: Rectangle {
                                    color: "#fa801e"
                                    implicitHeight: parent.vertical ? 24 : 2
                                    implicitWidth: parent.vertical ? 2 : 24
                                }
                            }
                            Rectangle {
                                id: ques4
                                width: 850
                                height: 50
                                color: "#06384f"
                                radius: 5
                                Text {
                                    color: "#ffffff"
                                    text: qsTr('¿Cómo hago uso del GPT-3 de Open AI?')
                                    anchors.fill: parent
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                    wrapMode: Text.WordWrap
                                    minimumPixelSize: 12
                                    minimumPointSize: 12
                                    font.pointSize: 15
                                    anchors.rightMargin: 0
                                    font.bold: true
                                }
                                Layout.fillWidth: false
                                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                anchors.bottomMargin: 6
                                Layout.fillHeight: false
                            }
                            Rectangle {
                                id: imgRes4
                                width: 550
                                height: 300
                                color: "#06384f"
                                radius: 5
                                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                Layout.fillHeight: false
                                Layout.fillWidth: false

                                AnimatedImage {
                                    id: openAI
                                    width: parent.width
                                    height: parent.height
                                    source: "../../images/helpPage/Open AI.gif"
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                    playing: false
                                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                    fillMode: Image.PreserveAspectFit
                                    MouseArea {
                                        id: mouseArea2
                                        anchors.fill: parent
                                        hoverEnabled: true
                                        onHoveredChanged: {
                                            openAI.playing = !openAI.playing
                                        }
                                    }
                                }
                            }
                            Rectangle {
                                id: ans4
                                width: 850
                                height: 50
                                color: "#06384f"
                                radius: 5
                                Text {
                                    color: "#ffffff"
                                    text: qsTr("Es tan simple como activar la opción de usar Open AI y tanto el resumen como las palabras clave serán obtenidor mediante la tecnológia GPT-3 de Open AI.")
                                    anchors.fill: parent
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                    wrapMode: Text.WordWrap
                                    minimumPixelSize: 12
                                    minimumPointSize: 12
                                    font.pointSize: 10.5
                                    anchors.rightMargin: 0
                                    font.bold: true
                                }
                                Layout.fillWidth: false
                                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                anchors.bottomMargin: 6
                                Layout.fillHeight: false
                            }

                            ToolSeparator {
                                id: toolSeparator3
                                wheelEnabled: true
                                orientation: Qt.Horizontal
                                spacing: 1
                                Layout.fillWidth: true
                                contentItem: Rectangle {
                                    color: "#fa801e"
                                    implicitHeight: parent.vertical ? 24 : 2
                                    implicitWidth: parent.vertical ? 2 : 24
                                }
                            }
                            Rectangle {
                                id: ques5
                                width: 850
                                height: 65
                                color: "#06384f"
                                radius: 5
                                Text {
                                    color: "#ffffff"
                                    text: qsTr("¿Por qué recibo una respuesta incorrecta o extraña cuando uso Open AI?")
                                    anchors.fill: parent
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                    wrapMode: Text.WordWrap
                                    minimumPixelSize: 12
                                    minimumPointSize: 12
                                    font.pointSize: 20
                                    anchors.rightMargin: 0
                                    font.bold: true
                                }
                                Layout.fillWidth: false
                                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                anchors.bottomMargin: 6
                                Layout.fillHeight: false
                            }
                            Rectangle {
                                id: ans5
                                width: 850
                                height: 80
                                color: "#06384f"
                                radius: 5
                                Text {
                                    color: "#ffffff"
                                    text: qsTr("Cabe resaltar que esta tecnología de inteligencia artificial está en fase Beta, por lo que aún comete ciertos errores, sin embargo puede volver a intentar y la misma tratará de darle una mejor respuesta. Además la misma trabaja con comprensión de textos por lo que a veces realiza análisis erróneos.")
                                    anchors.fill: parent
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                    wrapMode: Text.WordWrap
                                    minimumPixelSize: 12
                                    minimumPointSize: 12
                                    font.pointSize: 10.5
                                    anchors.rightMargin: 0
                                    font.bold: true
                                }
                                Layout.fillWidth: false
                                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                anchors.bottomMargin: 6
                                Layout.fillHeight: false
                            }


                        }

                        anchors.rightMargin: 0
                        contentWidth: parent.width - 10
                    }
                }
            }

            Item {
                id: pdfHelp

                Rectangle {
                    id: rectangle6
                    x: 0
                    y: 0
                    color: "#97d4f0"
                    radius: 5
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.topMargin: 0
                    anchors.bottomMargin: 0
                    anchors.rightMargin: 0
                    anchors.leftMargin: 0

                    ScrollView {
                        id: scrollView
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.topMargin: 10
                        anchors.bottomMargin: 10
                        anchors.rightMargin: 10
                        anchors.leftMargin: 10
                        wheelEnabled: true
                        spacing: 0
                        clip: true
                        ScrollBar.vertical.policy: ScrollBar.AlwaysOn

                        ColumnLayout {
                            id: columnLayout
                            width: scrollView.width

                            CustomButton {
                                id: back2
                                width: 40
                                height: 40
                                Layout.minimumHeight: 40
                                Layout.minimumWidth: 40
                                btnColorMouseOver: "#00000000"
                                btnColorClicked: "#00000000"
                                btnColorDefault: "#00000000"
                                Image {
                                    anchors.fill: parent
                                    source: "../../images/icons/previous.svg"
                                    fillMode: Image.PreserveAspectFit
                                }
                                onClicked: {
                                    stackLayout.currentIndex = 0
                                    console.log('back')
                                }
                            }

                            Rectangle {
                                id: rectangle19
                                width: 850
                                height: 63
                                color: "#06384f"
                                radius: 5
                                Text {
                                    color: "#ffffff"
                                    text: "PDF APP"
                                    anchors.fill: parent
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                    wrapMode: Text.WordWrap
                                    minimumPixelSize: 12
                                    minimumPointSize: 12
                                    font.pointSize: 20
                                    anchors.rightMargin: 0
                                    font.bold: true
                                }
                                Layout.fillWidth: false
                                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                anchors.bottomMargin: 6
                                Layout.fillHeight: false
                            }


                            Rectangle {
                                id: rectangle47
                                width: 850
                                height: 63
                                color: "#06384f"
                                radius: 5
                                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                Layout.fillHeight: false
                                Layout.fillWidth: false
                                Text {
                                    color: "#ffffff"
                                    text: "Para agregar PDFs en nuestra aplicacion seleccionelos o arrastelos en el area destinada la cual esta ubicada en la parte derecha, en el caso de modificar un pdf arratre un solo pdf en la segunda herramienta y esta cargara las paginas automaticamente"
                                    anchors.fill: parent
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                    wrapMode: Text.WordWrap
                                    anchors.rightMargin: 0
                                    font.pointSize: 10.5
                                    font.bold: true
                                }
                                anchors.bottomMargin: 6
                            }

                            Rectangle {
                                id: rectangle5
                                width: 744
                                height: 516
                                color: "#06384f"
                                radius: 5
                                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                Layout.fillHeight: false
                                Layout.fillWidth: false

                                AnimatedImage {
                                    id: animatedImage1
                                    anchors.fill: parent
                                    source: "../../images/gifs/Pdf Page/dragPdfsHelp.gif"
                                    anchors.rightMargin: 8
                                    anchors.bottomMargin: 8
                                    anchors.leftMargin: 8
                                    anchors.topMargin: 8
                                }
                            }


                            Rectangle {
                                id: rectangle7
                                width: 850
                                height: 63
                                color: "#06384f"
                                radius: 5
                                Text {
                                    color: "#ffffff"
                                    text: "Las paginas o PDFs pueden ser ordenados al mantener presionado uno de ellos y arrastarlo a la posicion deseada, y tambien pueden ser eliminados dandole click al boton en la esquina superior izquierda de cada recuadro"
                                    anchors.fill: parent
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                    wrapMode: Text.WordWrap
                                    font.pointSize: 10.5
                                    anchors.rightMargin: 0
                                    font.bold: true
                                }
                                Layout.fillWidth: false
                                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                anchors.bottomMargin: 6
                                Layout.fillHeight: false
                            }

                            Rectangle {
                                id: rectangle8
                                width: 744
                                height: 195
                                color: "#06384f"
                                radius: 5
                                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                AnimatedImage {
                                    id: animatedImage2
                                    anchors.fill: parent
                                    source: "../../images/gifs/Pdf Page/organizePdfHelp.gif"
                                    anchors.topMargin: 8
                                    anchors.bottomMargin: 8
                                    anchors.rightMargin: 8
                                    anchors.leftMargin: 8
                                }
                                Layout.fillWidth: false
                                Layout.fillHeight: false
                            }


                            Rectangle {
                                id: rectangle9
                                width: 850
                                height: 78
                                color: "#06384f"
                                radius: 5
                                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                Text {
                                    color: "#ffffff"
                                    text: "Si desea extraer solo algunas paginas de un PDF ingrese estas paginas separadas por espacios en la parte inferior, puede incluir formatos n-m donde n es la pagina de inicio y m la pagina final\nEjemplo: 3 5 7-15 20"
                                    anchors.fill: parent
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                    wrapMode: Text.WordWrap
                                    font.pointSize: 10.5
                                    anchors.rightMargin: 0
                                    font.bold: true
                                }
                                Layout.fillWidth: false
                                anchors.bottomMargin: 6
                                Layout.fillHeight: false
                            }

                            Rectangle {
                                id: rectangle10
                                width: 744
                                height: 228
                                color: "#06384f"
                                radius: 5
                                AnimatedImage {
                                    id: animatedImage3
                                    anchors.fill: parent
                                    source: "../../images/gifs/Pdf Page/extracPagesHelp.gif"
                                    anchors.topMargin: 8
                                    anchors.bottomMargin: 8
                                    anchors.rightMargin: 8
                                    anchors.leftMargin: 8
                                }
                                Layout.fillWidth: false
                                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                Layout.fillHeight: false
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
    D{i:0;autoSize:true;formeditorZoom:0.9;height:613;width:988}
}
##^##*/
