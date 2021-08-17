import QtQuick 2.0
import QtQuick.Controls 2.15
import "../controls"
import QtQuick.Layouts 1.11

Item {
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
            color: "#ffffff"
            radius: 12
            anchors.fill: parent
            anchors.rightMargin: 40
            anchors.bottomMargin: 15
            anchors.leftMargin: 40
            anchors.topMargin: 15

            Label {
                id: welcomeLabel
                y: 5
                height: 44
                color: "#060607"
                text: qsTr("Bienvenido a SmoothTask")
                anchors.left: parent.left
                anchors.right: parent.right
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.family: "Sans Serif"
                anchors.rightMargin: 8
                anchors.leftMargin: 12
                font.pointSize: 36
            }

            Rectangle {
                id: rectangle
                x: 105
                y: 169
                width: 200
                height: 200
                color: "#00000000"
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: -5
                anchors.horizontalCenterOffset: 0
                anchors.horizontalCenter: parent.horizontalCenter

                Image {
                    id: image
                    x: 114
                    y: -126
                    width: 450
                    height: 350
                    anchors.top: welcomeLabel.bottom
                    source: "../../images/icons/SmoothTaskLogo.png"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.topMargin: 5
                    fillMode: Image.PreserveAspectFit
                }

                Text {
                    id: textHome
                    x: 0
                    y: 234
                    width: 678
                    color: "#131418"
                    text: "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0//EN\" \"http://www.w3.org/TR/REC-html40/strict.dtd\">\n<html><head><meta name=\"qrichtext\" content=\"1\" /><style type=\"text/css\">\np, li { white-space: pre-wrap; }\n</style></head><body style=\" font-family:'MS Shell Dlg 2'; font-size:8.25pt; font-weight:400; font-style:normal;\">\n<p align=\"center\" style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-size:10pt; font-weight:600;\">UNIVERSIDAD NACIONAL DE COLOMBIA</span></p>\n<p align=\"center\" style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-size:10pt;\">Programacón Orientada a objetos - G6 - Alexei Ochoa</span></p>\n<p align=\"center\" style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-size:10pt;\">Version 1.0.0, </span><span style=\" font-size:10pt; font-weight:600;\">Beta</span></p>\n<p align=\"center\" style=\"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; font-size:10pt;\"><br /></p>\n<p align=\"center\" style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-size:10pt;\">Copyright (c) 2021 </span><span style=\" font-size:10pt; font-weight:600;\">Camilo A. Cuello, Juan A. Orozco, David Solis</span></p>\n<p align=\"center\" style=\"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; font-size:10pt; font-weight:600;\"><br /></p>\n<p align=\"center\" style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-size:10pt; font-weight:600; color:#f98125;\">Attention</span><span style=\" font-size:10pt;\">: El diseño de este proyecto fue basado en el desarrollado por </span><span style=\" font-size:10pt; font-weight:600; color:#f98125;\">Wanderson Pimienta</span><span style=\" font-size:10pt;\">, </span></p>\n<p align=\"center\" style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-size:10pt;\">diseñador gráfico y </span><span style=\" font-size:10pt; color:#000000;\">Youtuber brasilero</span><span style=\" font-size:10pt;\">.</span></p>\n<p align=\"center\" style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-size:10pt;\"> La aplicación de base es de </span><span style=\" font-size:10pt; font-weight:600; color:#f98125;\">código abierto</span><span style=\" font-size:10pt;\"> y sin licencia.</span></p>\n<p align=\"center\" style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-size:10pt; font-weight:600;\">Consultor</span><span style=\" font-size:10pt;\"> patrocinado por</span><span style=\" font-size:10pt; color:#00aaff;\"> </span><span style=\" font-size:10pt; font-weight:600; color:#55aaff;\">Open AI GPT-3 API.</span></p></body></html>"
                    anchors.top: image.bottom
                    anchors.bottom: parent.bottom
                    font.pixelSize: 16
                    anchors.bottomMargin: 10
                    anchors.topMargin: 5
                    anchors.horizontalCenter: parent.horizontalCenter
                    minimumPointSize: 14
                    minimumPixelSize: 14
                    font.family: "Sans Serif"
                    textFormat: Text.RichText
                }

            }


        }
    }

    Connections {
        target: backend
        function onSetName(name) {
            welcomeLabel.text = name
        }

        function onPrintTime(time) {
            dateLabel.text = time
        }

        function onIsVisible(isChecked) {
            rectangleVisible.visible = isChecked
        }
    }

}

/*##^##
Designer {
    D{i:0;autoSize:true;height:613;width:988}D{i:5}D{i:6}
}
##^##*/
