import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.11
import "../controls"
import Qt.labs.qmlmodels 1.0

Item{
    property alias text1: text1

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
            currentIndex: 2
            anchors.rightMargin: 10
            anchors.leftMargin: 10
            anchors.bottomMargin: 10
            anchors.topMargin: 10

            Item {
                id: item1
                DataFormatTable{
                    x: -10
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.topMargin: 315
                    anchors.bottomMargin: 8
                    anchors.leftMargin: 26
                    anchors.rightMargin: 26

                }

                Rectangle {
                    id: content4
                    x: 8
                    y: 252
                    height: 57
                    color: "#c1e4fd"
                    radius: 5
                    border.color: "#0797bd"
                    border.width: 2
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.leftMargin: 34
                    anchors.rightMargin: 34
                    GridLayout {
                        anchors.fill: parent
                        rows: 1
                        anchors.leftMargin: 8
                        columns: 4
                        anchors.topMargin: 8
                        anchors.bottomMargin: 8
                        anchors.rightMargin: 10
                        Rectangle {
                            id: rectangle
                            width: 200
                            height: 200
                            color: '#06384f'
                            radius: 5
                            Layout.preferredWidth: 80
                            Layout.fillWidth: false
                            Layout.fillHeight: true
                            Text {
                                id: text1
                                text: 'F'
                                anchors.fill: parent
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                font.pointSize: 15
                                color: 'white'
                                font.bold: true
                            }
                        }

                        Rectangle {
                            id: rectangle1
                            width: 200
                            height: 200
                            color: '#06384f'
                            radius: 5
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            Text {
                                text: 'Description'
                                anchors.fill: parent
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                font.pointSize: 15
                                color: 'white'
                                font.bold: true
                            }
                        }

                        Rectangle {
                            id: rectangle2
                            width: 200
                            height: 200
                            color: '#06384f'
                            radius: 5
                            Layout.preferredWidth: 110
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            Text {
                                text: 'Example'
                                anchors.fill: parent
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                font.pointSize: 15
                                color: 'white'
                                font.bold: true
                            }
                        }
                    }
                }

                Rectangle {
                    id: rectangle3
                    color: "#ffffff"
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: content4.top
                    anchors.bottomMargin: 6
                    Text {
                        text: 'Generador de documentos\nEl generador le permite al usuario ingresar una plantilla de word (.docx) en la cual podra incluir palabras clave dentro de corchetes [] para luego ser reemplazadas por los valores especificados en un perfil de excel (.xlsx .xls)\n\nEjemplo:\nPlantilla: El estudiante [STUDENT] posee el numero de identificacion [ID]\nPerfil: [STUDENT]=Andres Torres, [ID]=100524872\n\nDe esta forma el documento generado tendra el contenido:\nEl estudiante Andres Torres posee el numero de identificacion 100524872\n\nEs posible utilizar una serie de formatos predefinidos los cuales permiten incluir fechas y horas exactas al momento de generar el documento\nAcontinuacion encuentra una tabla con todos estos formatos'
                        anchors.fill: parent
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignTop
                        font.pointSize: 10.5
                        color: 'black'
                        font.bold: true
                        wrapMode: Text.WordWrap
                    }
                }
            }

            Item {
            }

            Item {
                id: pdfHelp

                Rectangle {
                    id: rectangle6
                    x: 0
                    y: 0
                    color: "#5dc9ef"
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
                        anchors.rightMargin: 0
                        anchors.leftMargin: 0
                        wheelEnabled: true
                        spacing: 0
                        clip: true
                        ScrollBar.vertical.policy: ScrollBar.AlwaysOn

                        ColumnLayout {
                            id: columnLayout
                            //anchors.fill: parent
                            //anchors.rightMargin: -224
                            //anchors.bottomMargin: 0
                            //anchors.leftMargin: 0
                            //anchors.topMargin: 0
                            width: scrollView.width


                            Rectangle {
                                id: rectangle11
                                width: 707
                                height: 63
                                color: "#06384f"
                                radius: 5
                                anchors.bottom: content4.top
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
                                id: rectangle4
                                width: 707
                                height: 63
                                color: "#06384f"
                                radius: 5
                                anchors.bottom: content4.top
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
                                width: 707
                                height: 63
                                color: "#06384f"
                                radius: 5
                                anchors.bottom: content4.top
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
                                width: 707
                                height: 78
                                color: "#06384f"
                                radius: 5
                                anchors.bottom: content4.top
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
    D{i:0;autoSize:true;height:613;width:988}D{i:19}D{i:18}
}
##^##*/
