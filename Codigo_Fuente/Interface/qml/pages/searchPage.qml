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
            color: "#03738c"
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
                    font.pointSize: 10
                    font.family: "Sans Serif"
                    fontColor: "#151212"
                    placeholderTextColor: "#121314"
                    bgColor: "#ffffff"
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

                    // Change Show/Hide Frame
                    onClicked: {
                        backend.startSearch(inputText.text)
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
                color: "#12181d"
                text: qsTr("Welcome")
                anchors.left: parent.left
                anchors.right: parent.right
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.family: "Sans Serif"
                anchors.rightMargin: 8
                anchors.leftMargin: 12
                font.pointSize: 16
            }

            Label {
                id: dateLabel
                y: 31
                height: 33
                color: "#eeb211"
                text: qsTr("Date")
                anchors.left: parent.left
                anchors.right: parent.right
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.family: "Sans Serif"
                font.bold: false
                anchors.rightMargin: 8
                anchors.leftMargin: 12
                font.pointSize: 14
            }

            // ScrollView {
            //     id: scrollView
            //     anchors.left: parent.left
            //     anchors.right: parent.right
            //     anchors.top: dateLabel.bottom
            //     anchors.bottom: parent.bottom
            //     anchors.topMargin: 10
            //     anchors.bottomMargin: 17
            //     anchors.rightMargin: 10
            //     anchors.leftMargin: 10

            //     Text {
            //             id: textHome
            //             color: "#a9b2c8"
            //             text: ""
            //             wrapMode: Text.WordWrap
            //             textFormat: Text.AutoText
            //             padding: 10
            //             anchors.fill: parent
            //             font.pixelSize: 12
            //         }
            // }
            Flickable {
                id: flickable
                clip: true
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: dateLabel.bottom
                anchors.bottom: parent.bottom
                anchors.topMargin: 5
                anchors.bottomMargin: 17
                anchors.rightMargin: 10
                anchors.leftMargin: 10

                TextArea.flickable: TextArea {
                    id: textHome
                    padding: 10
                    wrapMode: Text.WordWrap
                    font.family: "Sans Serif"
                    placeholderTextColor: "#0c1012"
                    textFormat: Text.AutoText
                    selectByMouse: true
                    selectedTextColor: "#ffffff"
                    selectionColor: "#ff007f"
                    color: "#000000"
                    font.pixelSize: 14
                    text: ""

                    ColumnLayout {
                        id: columnLayout
                        x: 227
                        y: 185
                        width: 100
                        height: 100
                    }
                }

                ScrollBar.vertical: ScrollBar{}
            }
        }

        Column {
            id: column
            x: 294
            width: 200
            anchors.top: rectangleVisible.bottom
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
    }

    Connections {
        target: backend

        function onResult(text) {
            textHome.text = text
        }
    }


}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:800}D{i:15}D{i:16}D{i:14;locked:true}
}
##^##*/
