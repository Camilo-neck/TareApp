import QtQuick 2.0
import QtQuick.Controls 2.15
import "../controls"
import QtQuick.Layouts 1.11

Item {
    Rectangle {
        id: bg
        color: "#2c313c"
        anchors.fill: parent
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0

        Rectangle {
            id: rectangleTop
            color: "#5c667d"
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
                    Layout.maximumWidth: 200
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
            color: "#1d2129"
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
                color: "#6b737a"
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
                color: "#24ced7"
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
                    textFormat: Text.AutoText
                    selectByMouse: true
                    selectedTextColor: "#ffffff"
                    selectionColor: "#ff007f"
                    color: "#a9b2c8"
                    font.pixelSize: 12
                    text: ""
                }

                ScrollBar.vertical: ScrollBar{}
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
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
