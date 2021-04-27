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
            id: rectangleTop
            color: "#ffffff"
            height: 69
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.rightMargin: 50
            anchors.leftMargin: 50
            anchors.topMargin: 40
            radius: 12

            GridLayout {
                anchors.fill: parent
                anchors.rightMargin: 10
                anchors.leftMargin: 10
                rows: 1
                columns:  3
                CustomTextField {
                    id: inputText
                    bgColor: "#03a678"
                    placeholderTextColor: "#ffffff"
                    Layout.fillWidth: true
                    Layout.fillHeight: false
                    Keys.onEnterPressed: {
                        backend.welcomeText(inputText.text)
                        inputText.text = ""
                    }
                    Keys.onReturnPressed: {
                        backend.welcomeText(inputText.text)
                        inputText.text = ""
                    }

                }

                CustomButton {
                    id: customBtn
                    text: "Button"
                    btnColorMouseOver: "#84ee80"
                    btnColorDefault: "#02735e"
                    Layout.maximumWidth: 150
                    Layout.fillWidth: true
                    Layout.preferredHeight: 40
                    Layout.preferredWidth: 250

                    // Change Show/Hide Frame
                    onClicked: {
                        backend.welcomeText(inputText.text)
                        inputText.text = ""
                    }

                }

                Switch {
                    id: switchHome
                    Layout.fillHeight: false
                    Layout.fillWidth: false
                    checked: true
                    Layout.preferredHeight: 40
                    Layout.preferredWidth: 68

                    onToggled: {
                        backend.showHideRectangle(switchHome.checked)
                    }
                }
            }


        }

        Rectangle {
            id: rectangleVisible
            color: "#ffffff"
            radius: 12
            anchors.fill: parent
            anchors.rightMargin: 50
            anchors.bottomMargin: 31
            anchors.leftMargin: 50
            anchors.topMargin: 137

            Label {
                id: welcomeLabel
                y: 5
                height: 33
                color: "#060607"
                text: qsTr("Welcome")
                anchors.left: parent.left
                anchors.right: parent.right
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.rightMargin: 8
                anchors.leftMargin: 12
                font.pointSize: 14
            }

            Label {
                id: dateLabel
                y: 31
                height: 33
                color: "#21a8c0"
                text: qsTr("Date")
                anchors.left: parent.left
                anchors.right: parent.right
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.bold: false
                anchors.rightMargin: 8
                anchors.leftMargin: 12
                font.pointSize: 12
            }

            ScrollView {
                id: scrollView
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: dateLabel.bottom
                anchors.bottom: parent.bottom
                anchors.topMargin: 10
                anchors.bottomMargin: 17
                anchors.rightMargin: 10
                anchors.leftMargin: 10

                Text {
                    id: textHome
                    color: "#131418"
                    text: "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0//EN\" \"http://www.w3.org/TR/REC-html40/strict.dtd\">\n<html><head><meta name=\"qrichtext\" content=\"1\" /><style type=\"text/css\">\np, li { white-space: pre-wrap; }\n</style></head><body style=\" font-family:'MS Shell Dlg 2'; font-size:8.25pt; font-weight:400; font-style:normal;\">\n<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-weight:600;\">GNU GENERAL PUBLIC LICENSE</span></p>\n<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\">Version 3, 29 June 2007</p>\n<p style=\"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><br /></p>\n<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\">Copyright (c) 2021 <span style=\" font-weight:600;\">Camilo A. Cuello</span></p>\n<p style=\"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; font-weight:600;\"><br /></p>\n<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-weight:600; color:#f98125;\">Attention</span>: this project was created with the Open Souce tools from Qt Company,</p>\n<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\">this project can be used for studies or personal non-commercial projects. </p>\n<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-weight:600;\">If you are going to use it for </span><span style=\" font-weight:600; color:#f98125;\">commercial use</span><span style=\" font-weight:600;\">, you need to purchase a license at &quot;https://www.qt.io&quot;.</span></p>\n<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\">Search page Powered by<span style=\" color:#00aaff;\"> </span><span style=\" font-weight:600; color:#55aaff;\">Open AI GPT-3 API.</span></p></body></html>"
                    anchors.fill: parent
                        font.pixelSize: 12
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
    D{i:0;autoSize:true;height:480;width:800}
}
##^##*/
