import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.11
import QtGraphicalEffects 1.0

Rectangle {
    property color gradColor: "#fda342"
    property color bgColor: "#8c4b05"
    property color txtColor: "#000000"
    property var title: "Consultor"
    property var desc: "Aplicación que te hará tu vida académica mucho más sencilla, en esta herramienta podrás hacer consultas en diferentes motores de busqueda y la obtendrás resumida. además de tener las palabras claves del texto."
    property url imagen: "../../images/icons/search_icon.svg"

    id: rectangle12
    border.width: 0
    gradient: Gradient {
        GradientStop {
            position: 0
            color: bgColor
        }

        GradientStop {
            position: 1
            color: gradColor
        }
    }
    layer.enabled: true
    layer.effect: OpacityMask {
        invert: false
        cached: false
        maskSource: Item {
            width: rectangle12.width
            height: rectangle12.height
            Rectangle {
                anchors.centerIn: parent
                width: rectangle12.width
                height: rectangle12.height
                radius: 20
            }
        }
    }
    ColumnLayout {
        id: columnLayout1
        anchors.fill: parent
        clip: true
        Image {
            id: image
            source: imagen
            Layout.topMargin: 5
            fillMode: Image.PreserveAspectFit
            Layout.fillHeight: false
            sourceSize.height: 100
            Layout.fillWidth: true
            sourceSize.width: 100
        }

        Label {
            id: label
            color: "#ffffff"
            text: qsTr(title)
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            wrapMode: Label.WordWrap
            font.bold: true
            Layout.fillWidth: true
            font.family: "Arial"
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            font.pointSize: 20
        }

        Label {
            id: label1
            color: txtColor
            text: qsTr(desc)
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignTop
            wrapMode: Label.WordWrap
            Layout.rightMargin: 5
            Layout.fillHeight: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            font.pointSize: 12
            Layout.fillWidth: true
            Layout.leftMargin: 5
        }



        DropShadow {
            color: "#80000000"
            radius: 8.1
            anchors.fill: rectangle12
            source: rectangle12
            verticalOffset: 3
            horizontalOffset: 3
            transparentBorder: true
            samples: 18
        }
        DropShadow {
            color: "#80ccaeae"
            radius: 7.9
            anchors.fill: image
            source: image
            Layout.topMargin: 0
            verticalOffset: 3
            horizontalOffset: 3
            transparentBorder: true
            samples: 17
        }
    }

    Rectangle{
        Layout.fillHeight: true
        Layout.fillWidth: true
        color: "#00c"
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: columnLayout1.bottom
        anchors.bottom: parent.bottom
        anchors.rightMargin: 0
        anchors.leftMargin: 0
        anchors.bottomMargin: 0
        anchors.topMargin: -30
        Label {
            id: label2
            anchors.fill: parent
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            color: "#fff"
            text: qsTr("Click para más ayuda...")
            wrapMode: Label.WordWrap
            font.family: "Tahoma"
            font.underline: false
            font.italic: true
            font.bold: true
            font.pointSize: 10
        }
        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
    }
}


/*##^##
Designer {
    D{i:0;height:360;width:215}
}
##^##*/
