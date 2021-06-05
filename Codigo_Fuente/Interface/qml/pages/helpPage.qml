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
            currentIndex: 0
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
        }

    }

    Connections {
        target: backend
    }

}

/*##^##
Designer {
    D{i:0;autoSize:true;height:613;width:988}D{i:4}D{i:5}D{i:13}
}
##^##*/
