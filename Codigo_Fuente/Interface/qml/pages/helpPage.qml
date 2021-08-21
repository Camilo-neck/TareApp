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
                                    txtColor: "white"
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
                                            stackLayout.currentIndex = 3

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
                                            stackLayout.currentIndex = 4
                                            //console.log("En Construcción")
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
                                    Layout.fillWidth: true
                                    playing: false
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
                                    text: qsTr("Es tan simple como activar la opción de usar Open AI y tanto el resumen como las palabras clave serán obtenidos mediante la tecnológia GPT-3 de Open AI.")
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
                                id: ans5
                                width: 850
                                height: 80
                                color: "#06384f"
                                radius: 5
                                Text {
                                    color: "#ffffff"
                                    text: qsTr("Cabe resaltar que esta tecnología de inteligencia artificial está en fase Beta, por lo que aún comete ciertos errores, sin embargo puede volver a intentar y la misma tratará de darle una mejor respuesta. Además que trabaja con comprensión de textos por lo que a veces realiza análisis erróneos.")
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
                                    playing: false
                                    MouseArea {
                                        id: pdf1Area
                                        anchors.fill: parent
                                        hoverEnabled: true
                                        onHoveredChanged: {
                                            animatedImage1.playing = !animatedImage1.playing
                                        }
                                    }
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
                                    playing: false
                                    MouseArea {
                                        id: pdf2Area
                                        anchors.fill: parent
                                        hoverEnabled: true
                                        onHoveredChanged: {
                                            animatedImage2.playing = !animatedImage2.playing
                                        }
                                    }
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
                                    playing: false
                                    MouseArea {
                                        id: pdf3Area
                                        anchors.fill: parent
                                        hoverEnabled: true
                                        onHoveredChanged: {
                                            animatedImage3.playing = !animatedImage3.playing
                                        }
                                    }
                                }

                                Layout.fillWidth: false
                                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                Layout.fillHeight: false
                            }


                        }
                    }
                }


            }

            Item {
                id: sorterHelp
                Rectangle {
                    id: rectangle16
                    x: 0
                    y: 0
                    color: "#97d4f0"
                    radius: 5
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.rightMargin: 0
                    anchors.leftMargin: 0
                    ScrollView {
                        id: scrollView1
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.rightMargin: 10
                        spacing: 0
                        wheelEnabled: true
                        anchors.leftMargin: 10
                        clip: true
                        ColumnLayout {
                            id: columnLayout1
                            width: scrollView1.width
                            CustomButton {
                                id: back3
                                width: 40
                                height: 40
                                btnColorMouseOver: "#00000000"
                                Layout.minimumWidth: 40
                                onClicked: {
                                    stackLayout.currentIndex = 0
                                    console.log('back')
                                }
                                btnColorClicked: "#00000000"
                                btnColorDefault: "#00000000"
                                Image {
                                    anchors.fill: parent
                                    source: "../../images/icons/previous.svg"
                                    fillMode: Image.PreserveAspectFit
                                }
                                Layout.minimumHeight: 40
                            }

                            Rectangle {
                                id: rectangle20
                                width: 850
                                height: 63
                                color: "#06384f"
                                radius: 5
                                Layout.fillHeight: false
                                Layout.fillWidth: false
                                Text {
                                    color: "#ffffff"
                                    text: "FOLDER SORTER"
                                    anchors.fill: parent
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                    wrapMode: Text.WordWrap
                                    anchors.rightMargin: 0
                                    minimumPixelSize: 12
                                    font.pointSize: 20
                                    minimumPointSize: 12
                                    font.bold: true
                                }
                                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                anchors.bottomMargin: 6
                            }


                        }
                        anchors.topMargin: 10
                        anchors.bottomMargin: 10
                    }
                    anchors.topMargin: 0
                    anchors.bottomMargin: 0
                    Item{
                        id:organizer
                    }
                }

            }

            Item{
                id:generatorHelp

                Rectangle {
                    id: backgroundGen
                    color: "#89c2db"
                    anchors.fill: parent
                    anchors.rightMargin: 0
                    anchors.bottomMargin: 0
                    anchors.leftMargin: 0
                    anchors.topMargin: 0

                    StackLayout {
                        id: stackLayoutGen
                        anchors.fill: parent
                        currentIndex: 1
                        anchors.rightMargin: 10
                        anchors.leftMargin: 10
                        anchors.bottomMargin: 10
                        anchors.topMargin: 10

                        Item {
                            DataFormatTable{
                                x: -10
                                y: 126
                                height: 309
                                anchors.left: parent.left
                                anchors.right: parent.right
                                anchors.leftMargin: 22
                                anchors.rightMargin: 22

                            }
                        }
                        Item{
                            id:genHelp

                            StackLayout {
                                id: genHelpLayout
                                anchors.fill: parent
                                currentIndex: 0

                                Item {
                                    id: genHelpHome

                                    Rectangle {
                                        id: genBg
                                        color: "#89c2db"
                                        anchors.right: parent.right
                                        anchors.fill: parent


                                        ScrollView {
                                            id: scrollViewHome
                                            x: 0
                                            y: 0
                                            anchors.fill: parent
                                            anchors.bottomMargin: 0
                                            anchors.leftMargin: 0
                                            anchors.topMargin: 0
                                            anchors.rightMargin: 0
                                            contentWidth: parent.width - 20
                                            clip: true
                                            ColumnLayout {
                                                id: cLayoutHome
                                                anchors.fill: parent
                                                anchors.bottomMargin: 50
                                                anchors.leftMargin: 10
                                                anchors.topMargin: 1
                                                spacing: 6
                                                anchors.rightMargin: 10
                                                Rectangle {
                                                    id: titleRectHome
                                                    width: 850
                                                    height: 50
                                                    color: "#06384f"
                                                    radius: 5
                                                    border.width: 0
                                                    anchors.horizontalCenterOffset: 0
                                                    anchors.horizontalCenter: parent.horizontalCenter

                                                    Label {
                                                        id: titleLabHome
                                                        x: -196
                                                        y: 4
                                                        height: 42
                                                        color: "#fff"
                                                        text: qsTr("Generador de documentos")
                                                        anchors.left: parent.left
                                                        anchors.right: parent.right
                                                        horizontalAlignment: Text.AlignHCenter
                                                        verticalAlignment: Text.AlignVCenter
                                                        font.bold: true
                                                        font.family: "Sans Serif"
                                                        anchors.rightMargin: 8
                                                        anchors.leftMargin: 8
                                                        font.pointSize: 17
                                                        anchors.horizontalCenter: parent.horizontalCenter
                                                    }
                                                    Layout.fillWidth: false
                                                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                                    anchors.bottomMargin: 6
                                                    Layout.fillHeight: false
                                                }

                                                Rectangle {
                                                    id: homeRect1
                                                    x: 40
                                                    y: 63
                                                    width: 850
                                                    height: 50
                                                    color: "#06384f"
                                                    radius: 5
                                                    border.width: 0
                                                    anchors.horizontalCenter: parent.horizontalCenter

                                                    Label {
                                                        id: homeLab1
                                                        x: 20
                                                        y: 2
                                                        width: 816
                                                        height: 40
                                                        color: "#ffffff"
                                                        text: "El generador de documentos ahorra su tiempo al modificar formatos específicos en una plantilla de su preferencia. Un ejemplo de plantilla se muestra a continuación:"
                                                        anchors.left: parent.left
                                                        anchors.right: parent.right
                                                        horizontalAlignment: Text.AlignLeft
                                                        verticalAlignment: Text.AlignVCenter
                                                        wrapMode: Text.Wrap
                                                        anchors.rightMargin: 8
                                                        anchors.leftMargin: 17
                                                        font.pointSize: 14
                                                        font.family: "Sans Serif"
                                                        anchors.horizontalCenter: parent.horizontalCenter
                                                        anchors.horizontalCenterOffset: 0
                                                    }
                                                    Layout.fillWidth: false
                                                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                                    anchors.bottomMargin: 6
                                                    Layout.fillHeight: false
                                                }

                                                Rectangle {
                                                    id: rectangle1
                                                    width: 450
                                                    height: 420
                                                    color: "#06384f"
                                                    radius: 5
                                                    Layout.fillHeight: false
                                                    Layout.fillWidth: false

                                                    Image {
                                                        id: homeImg1
                                                        y: 0
                                                        width: 390
                                                        height: 420

                                                        source: "../../images/gifs/GeneratorPage/templateHelp.png"
                                                        anchors.horizontalCenter: parent.horizontalCenter
                                                        fillMode: Image.PreserveAspectFit
                                                    }
                                                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                                }




                                                Rectangle {
                                                    id: homeRect2
                                                    x: 40
                                                    y: 63
                                                    width: 850
                                                    height: 70
                                                    color: "#06384f"
                                                    radius: 5
                                                    border.width: 0
                                                    Label {
                                                        id: homeLab2
                                                        x: 20
                                                        y: 15
                                                        width: 824
                                                        height: 39
                                                        color: "#ffffff"
                                                        text: "En una plantilla, los formatos son las palabras que se encuentran entre corchetes cuadrados, y son estos formatos los que serán reemplazados al momento de usar el generador de documentos."
                                                        anchors.left: parent.left
                                                        anchors.right: parent.right
                                                        horizontalAlignment: Text.AlignHCenter
                                                        verticalAlignment: Text.AlignVCenter
                                                        wrapMode: Text.Wrap
                                                        font.pointSize: 14
                                                        anchors.rightMargin: 8
                                                        anchors.horizontalCenterOffset: 0
                                                        anchors.horizontalCenter: parent.horizontalCenter
                                                        anchors.leftMargin: 13
                                                        font.family: "Sans Serif"
                                                    }
                                                    anchors.horizontalCenter: parent.horizontalCenter
                                                }

                                                Row {
                                                    id: rowHome1
                                                    width: 100
                                                    height: 100
                                                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                                    spacing:10
                                                    anchors.horizontalCenter: parent.Center

                                                    CustomButton {
                                                        id: profileHelpBtn
                                                        width: 140
                                                        height: 75
                                                        visible: true
                                                        text: "¿Qué es un\nperfil?"
                                                        btnColorMouseOver: "#05d5ff"
                                                        btnColorDefault: "#06384f"
                                                        customRadius: 5
                                                        font.pointSize: 17

                                                        //Layout.preferredWidth: 250
                                                        font.family: "Sans Serif"
                                                        //anchors.horizontalCenter: parent.horizontalCenter


                                                        onPressed: {
                                                            genHelpLayout.currentIndex=1
                                                        }
                                                    }

                                                    CustomButton {
                                                        id: profCreBtn
                                                        width: 140
                                                        height: 75
                                                        visible: true
                                                        text: "¿Cómo creo\nun perfil?"
                                                        btnColorMouseOver: "#05d5ff"
                                                        btnColorDefault: "#06384f"
                                                        customRadius: 5
                                                        font.pointSize: 17
                                                        //Layout.preferredWidth: 250
                                                        font.family: "Sans Serif"
                                                        //anchors.horizontalCenter: parent.horizontalCenter
                                                        //Layout.maximumHeight: 65535
                                                        //anchors.horizontalCenterOffset: 1
                                                        onPressed: {
                                                            genHelpLayout.currentIndex = 2
                                                        }
                                                    }

                                                    CustomButton {
                                                        id: doceGenBtn
                                                        width: 151
                                                        height: 75
                                                        visible: true
                                                        text: "¿Cómo genero\ndocumentos?"
                                                        btnColorMouseOver: "#05d5ff"
                                                        btnColorDefault: "#06384f"
                                                        customRadius: 5
                                                        font.pointSize: 17
                                                        //Layout.preferredWidth: 250
                                                        font.family: "Sans Serif"
                                                        //anchors.horizontalCenter: parent.horizontalCenter
                                                        //Layout.maximumHeight: 65535
                                                        //anchors.horizontalCenterOffset: 191
                                                        onPressed:{
                                                            genHelpLayout.currentIndex = 3
                                                        }
                                                    }
                                                }




                                            }


                                        }

                                        CustomButton {
                                            id: backGen
                                            x: 8
                                            y: 0
                                            width: 40
                                            height: 40
                                            //Layout.minimumHeight: 40
                                            //Layout.minimumWidth: 40
                                            btnColorMouseOver: "#00000000"
                                            btnColorClicked: "#00000000"
                                            btnColorDefault: "#00000000"
                                            Image {
                                                anchors.fill: parent
                                                source: "../../images/icons/previous.svg"
                                                fillMode: Image.PreserveAspectFit
                                            }
                                            onPressed: {

                                                stackLayout.currentIndex = 0
                                                console.log('back')
                                            }
                                        }
                                    }
                                }

                                Item {
                                    id: profileHelp
                                    ScrollView {
                                        id: scrollViewProfiles
                                        x: 0
                                        y: 0
                                        anchors.fill: parent
                                        anchors.bottomMargin: 0
                                        anchors.leftMargin: 0
                                        anchors.topMargin: 0
                                        anchors.rightMargin: 0
                                        contentWidth: parent.width - 20
                                        clip:true

                                        ColumnLayout {
                                            id: cLayoutProfiles
                                            anchors.fill: parent
                                            anchors.bottomMargin: 50
                                            anchors.leftMargin: 10
                                            anchors.topMargin: 1
                                            spacing: 6
                                            anchors.rightMargin: 10



                                            Rectangle {
                                                id: profRect1
                                                width: 850
                                                height: 50
                                                color: "#06384f"
                                                radius: 5
                                                border.width: 0
                                                anchors.horizontalCenter: parent.horizontalCenter
                                                anchors.horizontalCenterOffset: 0

                                                Label {
                                                    id: profLab1
                                                    x: -74
                                                    y: 8
                                                    width: 206
                                                    height: 34
                                                    color: "#ffffff"
                                                    text: "¿Cómo funciona un perfil?"
                                                    anchors.left: parent.left
                                                    anchors.right: parent.right
                                                    horizontalAlignment: Text.AlignHCenter
                                                    verticalAlignment: Text.AlignTop
                                                    wrapMode: Text.Wrap
                                                    font.bold: true
                                                    anchors.rightMargin: 4
                                                    anchors.leftMargin: 4
                                                    font.pointSize: 14
                                                    font.family: "Sans Serif"
                                                    anchors.horizontalCenter: parent.horizontalCenter
                                                    anchors.horizontalCenterOffset: 0
                                                }
                                            }

                                            Rectangle {
                                                id: profRect2
                                                x: -269
                                                y: 119
                                                width: 850
                                                height: 50
                                                color: "#06384f"
                                                radius: 5
                                                border.width: 0
                                                anchors.horizontalCenterOffset: 2
                                                anchors.horizontalCenter: parent.horizontalCenter
                                                Label {
                                                    id: profLab2
                                                    x: -196
                                                    y: 0
                                                    width: 834
                                                    height: 63
                                                    color: "#ffffff"
                                                    text: "El primer paso para empezar a generar documentos consiste en comprender el funcionamiento de los perfiles. Un perfil es un archivo de Excel cuyo contenido tiene el siguiente aspecto:"
                                                    anchors.left: parent.left
                                                    anchors.right: parent.right
                                                    horizontalAlignment: Text.AlignHCenter
                                                    verticalAlignment: Text.AlignTop
                                                    wrapMode: Text.Wrap
                                                    anchors.horizontalCenterOffset: 0
                                                    anchors.rightMargin: 8
                                                    anchors.leftMargin: 8
                                                    font.pointSize: 14
                                                    font.family: "Sans Serif"
                                                    anchors.horizontalCenter: parent.horizontalCenter
                                                }
                                            }

                                            Image {
                                                id: profImg1
                                                x: -261
                                                y: 227
                                                width: 524
                                                height: 268
                                                source: "../../images/gifs/GeneratorPage/excelHelp.png"
                                                sourceSize.height: 250
                                                sourceSize.width: 500
                                                anchors.horizontalCenterOffset: 1
                                                anchors.horizontalCenter: parent.horizontalCenter
                                                fillMode: Image.PreserveAspectFit
                                            }

                                            Rectangle {
                                                id: profRect3
                                                x: -269
                                                y: 520
                                                width: 850
                                                height: 90
                                                color: "#06384f"
                                                radius: 5
                                                border.width: 0
                                                anchors.horizontalCenterOffset: 2
                                                anchors.horizontalCenter: parent.horizontalCenter
                                                Label {
                                                    id: profLab3
                                                    x: -196
                                                    y: 8
                                                    width: 834
                                                    height: 74
                                                    color: "#ffffff"
                                                    text: "Iremos recorriendo esta información para explicar su significado. En esta explicación, se sigue la convención de que cada celda en la columna A tiene asignado un valor (o varios valores a partir de la celda A4) en la celda o en el conjunto de celdas que está a su derecha."
                                                    anchors.left: parent.left
                                                    anchors.right: parent.right
                                                    horizontalAlignment: Text.AlignHCenter
                                                    verticalAlignment: Text.AlignTop
                                                    wrapMode: Text.Wrap
                                                    anchors.horizontalCenterOffset: 0
                                                    anchors.rightMargin: 8
                                                    anchors.leftMargin: 8
                                                    font.pointSize: 14
                                                    font.family: "Sans Serif"
                                                    anchors.horizontalCenter: parent.horizontalCenter
                                                }
                                            }

                                            Rectangle {
                                                id: profRect4
                                                x: -269
                                                y: 667
                                                width: 850
                                                height: 60
                                                color: "#06384f"
                                                radius: 5
                                                border.width: 0
                                                anchors.horizontalCenterOffset: 2
                                                anchors.horizontalCenter: parent.horizontalCenter

                                                Label {
                                                    id: profLab4
                                                    x: 16
                                                    y: 8
                                                    width: 834
                                                    height: 57
                                                    color: "#ffffff"
                                                    text: "La primera celda de un perfil corresponde a \"URL Plantilla\", y su valor es la ruta de acceso a la plantilla que quiera usarse para generar los documentos."
                                                    anchors.left: parent.left
                                                    anchors.right: parent.right
                                                    horizontalAlignment: Text.AlignHCenter
                                                    verticalAlignment: Text.AlignTop
                                                    wrapMode: Text.Wrap
                                                    anchors.horizontalCenterOffset: 0
                                                    anchors.rightMargin: 8
                                                    anchors.leftMargin: 8
                                                    font.pointSize: 14
                                                    font.family: "Sans Serif"
                                                    anchors.horizontalCenter: parent.horizontalCenter
                                                }
                                            }

                                            Image {
                                                id: profImg2
                                                width: 524
                                                height: 80
                                                Layout.maximumWidth:524
                                                source: "../../images/gifs/GeneratorPage/urlopen.png"
                                                sourceSize.width: 597
                                                anchors.horizontalCenterOffset: 2
                                                anchors.horizontalCenter: parent.horizontalCenter
                                                //fillMode: Image.PreserveAspectFit
                                            }

                                            Rectangle {
                                                id: profRect5
                                                x: -269
                                                y: 841
                                                width: 850
                                                height: 50
                                                color: "#06384f"
                                                radius: 5
                                                border.width: 0
                                                anchors.horizontalCenterOffset: 2
                                                anchors.horizontalCenter: parent.horizontalCenter
                                                Label {
                                                    id: profLab5
                                                    x: 16
                                                    y: 0
                                                    width: 834
                                                    height: 50
                                                    color: "#ffffff"
                                                    text: "Similar a \"URL Plantilla\", el valor de la celda \"URL Documentos\" también es una ruta, pero esta vez corresponde al directorio de guardado que se busca para los documentos a generar."
                                                    anchors.left: parent.left
                                                    anchors.right: parent.right
                                                    horizontalAlignment: Text.AlignHCenter
                                                    verticalAlignment: Text.AlignTop
                                                    wrapMode: Text.Wrap
                                                    anchors.horizontalCenterOffset: 0
                                                    anchors.rightMargin: 8
                                                    anchors.leftMargin: 8
                                                    font.pointSize: 14
                                                    font.family: "Sans Serif"
                                                    anchors.horizontalCenter: parent.horizontalCenter
                                                }
                                            }

                                            Image {
                                                id: profImg3
                                                x: -174
                                                y: 935
                                                width: 524
                                                height: 120
                                                Layout.maximumWidth:524
                                                //Layout.maximumHeight:120
                                                source: "../../images/gifs/GeneratorPage/urlsave.png"
                                                anchors.horizontalCenterOffset:0
                                                anchors.horizontalCenter: parent.horizontalCenter
                                                fillMode: Image.PreserveAspectFit
                                            }

                                            Rectangle {
                                                id: profRect6
                                                x: -269
                                                y: 1032
                                                width: 850
                                                height: 50
                                                color: "#06384f"
                                                radius: 5
                                                border.width: 0
                                                anchors.horizontalCenterOffset: 2
                                                anchors.horizontalCenter: parent.horizontalCenter
                                                Label {
                                                    id: profLab6
                                                    x: 16
                                                    y: 0
                                                    width: 834
                                                    height: 50
                                                    color: "#ffffff"
                                                    text: "El valor de \"PLANTILLA\" es sólamente una ayuda visual, y corresponde al nombre de la plantilla que se va a utilizar, esta vez sin la información completa de la ruta de acceso."
                                                    anchors.left: parent.left
                                                    anchors.right: parent.right
                                                    horizontalAlignment: Text.AlignHCenter
                                                    verticalAlignment: Text.AlignTop
                                                    wrapMode: Text.Wrap
                                                    anchors.horizontalCenterOffset: 0
                                                    anchors.rightMargin: 8
                                                    anchors.leftMargin: 8
                                                    font.pointSize: 14
                                                    font.family: "Sans Serif"
                                                    anchors.horizontalCenter: parent.horizontalCenter
                                                }
                                            }

                                            Rectangle {
                                                id: profRect7
                                                x: -269
                                                y: 841
                                                width: 850
                                                height: 50
                                                color: "#06384f"
                                                radius: 5
                                                border.width: 0
                                                anchors.horizontalCenter: parent.horizontalCenter
                                                anchors.horizontalCenterOffset: 2

                                                Label {
                                                    id: profLab7
                                                    x: -13
                                                    y: 0
                                                    width: 850
                                                    height: 50
                                                    color: "#ffffff"
                                                    text: "A partir de la fila 4, las celdas pueden tener uno o más valores, y es esta misma fila la que busca ilustrar dicha convención."
                                                    anchors.left: parent.left
                                                    anchors.right: parent.right
                                                    horizontalAlignment: Text.AlignHCenter
                                                    verticalAlignment: Text.AlignTop
                                                    wrapMode: Text.Wrap
                                                    anchors.horizontalCenterOffset: 0
                                                    anchors.rightMargin: 8
                                                    anchors.leftMargin: 0
                                                    font.pointSize: 14
                                                    font.family: "Sans Serif"
                                                    anchors.horizontalCenter: parent.horizontalCenter
                                                }
                                            }

                                            Rectangle {
                                                id: profRect8
                                                x: -269
                                                y: 841
                                                width: 850
                                                height: 50
                                                color: "#06384f"
                                                radius: 5
                                                border.width: 0
                                                anchors.horizontalCenter: parent.horizontalCenter
                                                anchors.horizontalCenterOffset: 2

                                                Label {
                                                    id: profLab8
                                                    x: 68
                                                    y: 0
                                                    width: 834
                                                    height: 50
                                                    color: "#ffffff"
                                                    text: "Los valores de \"NOMBRE ARCHIVO\" corresponden a los nombres que tendrán los archivos de Word que se quieran crear. Se crearán tantos archivos como valores tenga \"NOMBRE ARCHIVO\"."
                                                    anchors.left: parent.left
                                                    anchors.right: parent.right
                                                    horizontalAlignment: Text.AlignLeft
                                                    verticalAlignment: Text.AlignTop
                                                    wrapMode: Text.Wrap
                                                    anchors.horizontalCenterOffset: 0
                                                    anchors.rightMargin: 8
                                                    anchors.leftMargin: 8
                                                    font.pointSize: 14
                                                    font.family: "Sans Serif"
                                                    anchors.horizontalCenter: parent.horizontalCenter
                                                }
                                            }

                                            Rectangle {
                                                id: profRect9
                                                x: -269
                                                y: 841
                                                width: 850
                                                height: 140
                                                color: "#06384f"
                                                radius: 5
                                                border.width: 0
                                                anchors.horizontalCenter: parent.horizontalCenter
                                                anchors.horizontalCenterOffset: 2

                                                Label {
                                                    id: profLab9
                                                    x: 184
                                                    y: 8
                                                    width: 834
                                                    height: 124
                                                    color: "#ffffff"
                                                    text: "Los valores de \"CREAR PDF\" son palabras entre \"SI\" o \"NO\". Si el valor es \"SI\", la aplicación creará un archivo PDF a partir del documento de Word asociado a la columna en donde se encuentre dicho valor, guardándolo en la ruta designada en \"URL Save\". Si el valor es \"NO\", el archivo PDF no será creado. Los valores de \"NOMBRE PDF\" corresponden al nombre que se dará al archivo PDF si la opción en \"CREAR PDF\" es \"SI\"."
                                                    anchors.left: parent.left
                                                    anchors.right: parent.right
                                                    horizontalAlignment: Text.AlignHCenter
                                                    verticalAlignment: Text.AlignTop
                                                    wrapMode: Text.Wrap
                                                    anchors.horizontalCenterOffset: 0
                                                    anchors.rightMargin: 8
                                                    anchors.leftMargin: 8
                                                    font.pointSize: 14
                                                    font.family: "Sans Serif"
                                                    anchors.horizontalCenter: parent.horizontalCenter
                                                }
                                            }


                                            Rectangle {
                                                id: profRect10
                                                x: -269
                                                y: 841
                                                width: 850
                                                height: 130
                                                color: "#06384f"
                                                radius: 5
                                                border.width: 0
                                                anchors.horizontalCenter: parent.horizontalCenter
                                                anchors.horizontalCenterOffset: 2

                                                Label {
                                                    id: profLab10
                                                    x: 9
                                                    y: 8
                                                    width: 834
                                                    height: 122
                                                    color: "#ffffff"
                                                    text: "A partir de aquí, empiezan a aparecer las celdas de los formatos que la plantilla contiene. Los valores de cada formato reemplazarán cada ocurrencia del formato en la plantilla. Posteriormente, la aplicación creará documentos con los cambios realizados de acuerdo a los valores de los formatos, y los guardará en la ruta designada por \"URL Documentos\" con las opciones de guardado definidas en las demás celdas."
                                                    anchors.left: parent.left
                                                    anchors.right: parent.right
                                                    horizontalAlignment: Text.AlignHCenter
                                                    verticalAlignment: Text.AlignTop
                                                    wrapMode: Text.Wrap
                                                    anchors.horizontalCenterOffset: 0
                                                    anchors.rightMargin: 8
                                                    anchors.leftMargin: 8
                                                    font.pointSize: 14
                                                    font.family: "Sans Serif"
                                                    anchors.horizontalCenter: parent.horizontalCenter
                                                }
                                            }







                                        }


                                    }

                                    CustomButton {
                                        id: goBack1
                                        x: 8
                                        y: 0
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
                                        onPressed: {

                                            genHelpLayout.currentIndex = 0
                                            console.log('back')
                                        }
                                    }

                                }
                                Item{
                                    id: profileCreationHelp

                                    ScrollView {
                                        id: scrollViewCreation
                                        x: 0
                                        y: 0
                                        anchors.fill: parent
                                        anchors.bottomMargin: 0
                                        anchors.leftMargin: 0
                                        anchors.topMargin: 0
                                        anchors.rightMargin: 0
                                        contentWidth: parent.width - 20
                                        clip: true

                                        ColumnLayout {
                                            id: cLayoutCreation
                                            anchors.fill: parent
                                            anchors.bottomMargin: 50
                                            anchors.leftMargin: 10
                                            anchors.topMargin: 1
                                            spacing: 6
                                            anchors.rightMargin: 10
                                            Rectangle {
                                                id: titleRectCreation
                                                width: 850
                                                height: 63
                                                color: "#06384f"
                                                radius: 5
                                                border.width: 0
                                                anchors.horizontalCenter: parent.horizontalCenter
                                                anchors.horizontalCenterOffset: 0

                                                Label {
                                                    id: titleLabCreation
                                                    x: -74
                                                    y: 17
                                                    width: 206
                                                    height: 40
                                                    color: "#ffffff"
                                                    text: "¿Cómo creo un perfil?"
                                                    anchors.left: parent.left
                                                    anchors.right: parent.right
                                                    horizontalAlignment: Text.AlignHCenter
                                                    verticalAlignment: Text.AlignTop
                                                    wrapMode: Text.Wrap
                                                    font.bold: true
                                                    anchors.rightMargin: 4
                                                    anchors.leftMargin: 4
                                                    font.pointSize: 14
                                                    font.family: "Sans Serif"
                                                    anchors.horizontalCenter: parent.horizontalCenter
                                                    anchors.horizontalCenterOffset: 0
                                                }
                                            }
                                            Rectangle {
                                                id: creRect1
                                                x: -269
                                                y: 1032
                                                width: 850
                                                height: 75
                                                color: "#06384f"
                                                radius: 5
                                                border.width: 0
                                                anchors.horizontalCenterOffset: 2
                                                anchors.horizontalCenter: parent.horizontalCenter
                                                Label {
                                                    id: creLab1
                                                    x: 16
                                                    y: 0
                                                    width: 834
                                                    height: 75
                                                    color: "#ffffff"
                                                    text: "El primer paso para crear un perfil, consiste en acceder al menú de creación de perfil seleccionando el botón \"Crear perfil\" en color verde. La aplicación tiene un botón en la esquina superior izquierda para regresar al menú inicial de generación de documentos."
                                                    anchors.left: parent.left
                                                    anchors.right: parent.right
                                                    horizontalAlignment: Text.AlignHCenter
                                                    verticalAlignment: Text.AlignTop
                                                    wrapMode: Text.Wrap
                                                    anchors.horizontalCenterOffset: 0
                                                    anchors.rightMargin: 8
                                                    anchors.leftMargin: 8
                                                    font.pointSize: 14
                                                    font.family: "Sans Serif"
                                                    anchors.horizontalCenter: parent.horizontalCenter
                                                }
                                            }
                                            AnimatedImage {
                                                id: creImg1
                                                //anchors.horizontalCenter: parent.Center
                                                width: 400
                                                height: 200
                                                //horizontalAlignment: Image.AlignHCenter
                                                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                                source: "../../images/gifs/GeneratorPage/genHelp2.gif"
                                                //sourceSize.width: 550
                                                Layout.maximumWidth: 550
                                                Layout.maximumHeight: 300
                                                fillMode: Image.PreserveAspectFit
                                                playing:false
                                                speed:2
                                                MouseArea {
                                                    id: help2Area
                                                    anchors.fill: parent
                                                    hoverEnabled: true
                                                    onHoveredChanged: {
                                                        creImg1.playing = !creImg1.playing
                                                    }
                                                }

                                            }

                                            Rectangle {
                                                id: creRect2
                                                x: -269
                                                y: 1032
                                                width: 850
                                                height: 75
                                                color: "#06384f"
                                                radius: 5
                                                border.width: 0
                                                Label {
                                                    id: creLab2
                                                    x: 16
                                                    y: 0
                                                    width: 834
                                                    height: 67
                                                    color: "#ffffff"
                                                    text: "Una vez en el menú de creación de perfiles, debemos introducir una plantilla arrastrándola al área designada, o haciéndo clic sobre dicha área para navegar entre los archivos y seleccionar la plantilla."
                                                    anchors.left: parent.left
                                                    anchors.right: parent.right
                                                    horizontalAlignment: Text.AlignHCenter
                                                    verticalAlignment: Text.AlignTop
                                                    wrapMode: Text.Wrap
                                                    anchors.rightMargin: 8
                                                    font.pointSize: 14
                                                    font.family: "Sans Serif"
                                                    anchors.horizontalCenter: parent.horizontalCenter
                                                    anchors.horizontalCenterOffset: 0
                                                    anchors.leftMargin: 8
                                                }
                                                anchors.horizontalCenter: parent.horizontalCenter
                                                anchors.horizontalCenterOffset: 2
                                            }

                                            AnimatedImage {
                                                id: creImg2
                                                width: 400
                                                height: 200
                                                source: "../../images/gifs/GeneratorPage/genHelp3.gif"
                                                fillMode: Image.PreserveAspectFit
                                                Layout.maximumWidth: 550
                                                Layout.maximumHeight: 300
                                                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                                playing:false
                                                speed:2
                                                MouseArea {
                                                    id: help3Area
                                                    anchors.fill: parent
                                                    hoverEnabled: true
                                                    onHoveredChanged: {
                                                        creImg2.playing = !creImg2.playing
                                                    }
                                                }
                                            }

                                            Rectangle {
                                                id: creRect3
                                                x: -269
                                                y: 1032
                                                width: 850
                                                height: 220
                                                color: "#06384f"
                                                radius: 5
                                                border.width: 0
                                                anchors.horizontalCenterOffset: 2
                                                Label {
                                                    id: creLab3
                                                    x: 16
                                                    y: 8
                                                    width: 834
                                                    height: 212
                                                    color: "#ffffff"
                                                    //text: "Una vez en el menú de creación de perfiles, debemos introducir una plantilla arrastrándola al área designada, o haciéndo clic sobre dicha área para navegar entre los archivos y seleccionar la plan"
                                                    text: "Luego de haber seleccionado una plantilla, es posible designar la ruta deseada para el valor de \"URL Documentos\" utilizando el botón con ícono de carpeta que permite navegar hasta un directorio y seleccionarlo (siendo la carpeta \"Documentos\" el directorio por defecto). Luego, para crear el perfil, se debe oprimir el botón verde \"Generar perfil\" que abrirá un explorador de archivos para designar el directorio de destino del perfil; además, es en esta ventana de exploración en donde se debe designar un nombre para el perfil. Una vez que se ha establecido un directorio y un nombre para el perfil, el paso final para crear el perfil consiste en oprimir el botón \"Guardar\". Es posible abrir el perfil creado navegando hasta su ubicación, o utilizando el botón azul incluido en la aplicación que tiene esta función."
                                                    anchors.left: parent.left
                                                    anchors.right: parent.right
                                                    horizontalAlignment: Text.AlignHCenter
                                                    verticalAlignment: Text.AlignTop
                                                    wrapMode: Text.Wrap
                                                    anchors.horizontalCenterOffset: 0
                                                    font.family: "Sans Serif"
                                                    anchors.horizontalCenter: parent.horizontalCenter
                                                    anchors.leftMargin: 8
                                                    anchors.rightMargin: 8
                                                    font.pointSize: 14
                                                }
                                                anchors.horizontalCenter: parent.horizontalCenter
                                            }

                                            AnimatedImage {
                                                id: creImg3
                                                width: 400
                                                height: 200
                                                source: "../../images/gifs/GeneratorPage/genHelp4.gif"
                                                Layout.maximumWidth: 550
                                                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                                Layout.maximumHeight: 300
                                                fillMode: Image.PreserveAspectFit
                                                playing:false
                                                speed:2
                                                MouseArea {
                                                    id: help4Area
                                                    anchors.fill: parent
                                                    hoverEnabled: true
                                                    onHoveredChanged: {
                                                        creImg3.playing = !creImg3.playing
                                                    }
                                                }
                                            }

                                            Rectangle {
                                                id: creRect4
                                                x: -269
                                                y: 1032
                                                width: 850
                                                height: 110
                                                color: "#06384f"
                                                radius: 5
                                                border.width: 0
                                                Label {
                                                    id: creLab4
                                                    x: 16
                                                    y: 8
                                                    width: 834
                                                    height: 102
                                                    color: "#ffffff"
                                                    text: "El perfil resultante será un archivo de Excel sin diligenciar con la apariencia descrita en la sección \"¿Qué es un perfil?\", por ello, el usuario deberá introducir los valores de las celdas según sus necesidades. Se recomienda al usuario utilizar la función de extender celda que ofrece Excel, en caso de que sean necesarios varios valores para los formatos."
                                                    anchors.left: parent.left
                                                    anchors.right: parent.right
                                                    horizontalAlignment: Text.AlignLeft
                                                    verticalAlignment: Text.AlignTop
                                                    wrapMode: Text.Wrap
                                                    font.pointSize: 14
                                                    anchors.leftMargin: 8
                                                    anchors.rightMargin: 8
                                                    anchors.horizontalCenter: parent.horizontalCenter
                                                    font.family: "Sans Serif"
                                                    anchors.horizontalCenterOffset: 0
                                                }
                                                anchors.horizontalCenter: parent.horizontalCenter
                                                anchors.horizontalCenterOffset: 2
                                            }

                                            AnimatedImage {
                                                id: creImg4
                                                width: 400
                                                height: 210
                                                source: "../../images/gifs/GeneratorPage/excelHelp.gif"
                                                Layout.maximumWidth: 550
                                                fillMode: Image.PreserveAspectFit
                                                Layout.maximumHeight: 210
                                                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                                playing:false
                                                speed:2
                                                MouseArea {
                                                    id: excHelpArea
                                                    height: 210
                                                    anchors.fill: parent

                                                    hoverEnabled: true
                                                    onHoveredChanged: {
                                                        creImg4.playing = !creImg4.playing
                                                    }
                                                }
                                            }
                                        }



                                    }

                                    CustomButton {
                                        id: goBack3
                                        x: 8
                                        y: 0
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
                                        onPressed: {

                                            genHelpLayout.currentIndex = 0
                                            console.log('back')
                                        }
                                    }
                                }

                                Item {
                                    id: profileCreationHelp1
                                    ScrollView {
                                        id: scrollViewCreation1
                                        x: 0
                                        y: 0
                                        anchors.fill: parent
                                        clip: true
                                        ColumnLayout {
                                            id: cLayoutCreation1
                                            anchors.fill: parent
                                            anchors.topMargin: 1
                                            anchors.leftMargin: 10
                                            spacing: 6

                                            Rectangle {
                                                id: titleRectCreation1
                                                width: 850
                                                height: 63
                                                color: "#06384f"
                                                radius: 5
                                                border.width: 0
                                                anchors.horizontalCenter: parent.horizontalCenter
                                                Label {
                                                    id: titleLabCreation1
                                                    x: -74
                                                    y: 15
                                                    width: 206
                                                    height: 42
                                                    color: "#ffffff"
                                                    text: "¿Cómo genero documentos?"
                                                    anchors.left: parent.left
                                                    anchors.right: parent.right
                                                    horizontalAlignment: Text.AlignHCenter
                                                    verticalAlignment: Text.AlignTop
                                                    wrapMode: Text.Wrap
                                                    anchors.horizontalCenter: parent.horizontalCenter
                                                    font.family: "Sans Serif"
                                                    font.pointSize: 14
                                                    anchors.horizontalCenterOffset: 0
                                                    anchors.leftMargin: 4
                                                    font.bold: true
                                                    anchors.rightMargin: 4
                                                }
                                                anchors.horizontalCenterOffset: 0
                                            }

                                            Rectangle {
                                                id: creRect5
                                                x: -269
                                                y: 1032
                                                width: 850
                                                height: 80
                                                color: "#06384f"
                                                radius: 5
                                                border.width: 0
                                                anchors.horizontalCenter: parent.horizontalCenter
                                                Label {
                                                    id: creLab5
                                                    x: 16
                                                    y: 8
                                                    width: 524
                                                    height: 114
                                                    color: "#ffffff"
                                                    text: "Para generar documentos, es suficiente con arrastrar o seleccionar un perfil diligenciado en el menú de generación de documentos y luego oprimir el botón \"Generar documentos\". Los documentos serán generados con las opciones contenidas en el perfil."
                                                    anchors.left: parent.left
                                                    anchors.right: parent.right
                                                    horizontalAlignment: Text.AlignLeft
                                                    verticalAlignment: Text.AlignTop
                                                    wrapMode: Text.Wrap
                                                    anchors.horizontalCenter: parent.horizontalCenter
                                                    font.family: "Sans Serif"
                                                    anchors.leftMargin: 8
                                                    anchors.horizontalCenterOffset: 0
                                                    font.pointSize: 14
                                                    anchors.rightMargin: 8
                                                }
                                                anchors.horizontalCenterOffset: 2
                                            }

                                            AnimatedImage {
                                                id: creImg5
                                                width: 400
                                                height: 200
                                                source: "../../images/gifs/GeneratorPage/genHelp1.gif"
                                                paused: false
                                                playing: false
                                                Layout.maximumWidth: 550
                                                fillMode: Image.PreserveAspectFit
                                                Layout.maximumHeight: 300
                                                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                                speed:2
                                                MouseArea {
                                                    id: help1Area
                                                    anchors.fill: parent
                                                    hoverEnabled: true
                                                    onHoveredChanged: {
                                                        creImg5.playing = !creImg5.playing
                                                    }
                                                }
                                            }

                                            Rectangle {
                                                id: creRect6
                                                x: -269
                                                y: 1032
                                                width: 850
                                                height: 135
                                                color: "#06384f"
                                                radius: 5
                                                border.width: 0
                                                anchors.horizontalCenter: parent.horizontalCenter
                                                Label {
                                                    id: creLab6
                                                    x: 16
                                                    y: 8
                                                    width: 524
                                                    height: 81
                                                    color: "#d80202"
                                                    text: "Para evitar errorres, se recomienda cerrar los archivos de Excel que se encuentren abiertos, antes de oprimir el botón \"Generar documentos\"."
                                                    anchors.left: parent.left
                                                    anchors.right: parent.right
                                                    horizontalAlignment: Text.AlignLeft
                                                    verticalAlignment: Text.AlignTop
                                                    wrapMode: Text.Wrap
                                                    anchors.horizontalCenter: parent.horizontalCenter
                                                    font.family: "Sans Serif"
                                                    anchors.leftMargin: 8
                                                    anchors.horizontalCenterOffset: 0
                                                    font.pointSize: 14
                                                    anchors.rightMargin: 8
                                                }

                                                Label {
                                                    id: creLab7
                                                    x: 23
                                                    y: 62
                                                    width: 834
                                                    height: 73
                                                    color: "#ffffff"
                                                    text: "En caso de que el perfil seleccionado contenga datos no válidos, la generación fallará y la aplicación informará al usuario del error. En estos casos, corrija su perfil y asegurese de que haya seguido correctamente todas las instrucciones dadas en esta sección de ayuda."
                                                    anchors.left: parent.left
                                                    anchors.right: parent.right
                                                    horizontalAlignment: Text.AlignLeft
                                                    verticalAlignment: Text.AlignTop
                                                    wrapMode: Text.Wrap
                                                    font.pointSize: 14
                                                    anchors.rightMargin: 8
                                                    anchors.horizontalCenterOffset: 0
                                                    anchors.horizontalCenter: parent.horizontalCenter
                                                    font.family: "Sans Serif"
                                                    anchors.leftMargin: 8
                                                }
                                                anchors.horizontalCenterOffset: 2
                                            }
                                            anchors.rightMargin: 10
                                            anchors.bottomMargin: 50
                                        }
                                        anchors.topMargin: 0
                                        anchors.leftMargin: 0
                                        contentWidth: parent.width - 20
                                        anchors.rightMargin: 0
                                        anchors.bottomMargin: 0
                                    }

                                    CustomButton {
                                        id: goBack4
                                        x: 8
                                        y: 0
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
                                        onPressed: {

                                            genHelpLayout.currentIndex = 0
                                            console.log('back')
                                        }
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
    }}


/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:0.9;height:613;width:988}
}
##^##*/
