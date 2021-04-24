import QtQuick 2.0
import QtQuick.Controls 2.15
import "../controls"
import QtQuick.Layouts 1.11
import QtQuick.Dialogs 1.3

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
            id: rectangleVisible
            color: "#1d2129"
            radius: 12
            anchors.fill: parent
            clip: true
            anchors.rightMargin: 30
            anchors.bottomMargin: 30
            anchors.leftMargin: 30
            anchors.topMargin: 30

            Label {
                id: mergePdfLabel
                y: 5
                height: 33
                color: "#6b737a"
                text: qsTr("Merge PDF")
                anchors.left: parent.left
                anchors.right: parent.right
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                anchors.rightMargin: 8
                anchors.leftMargin: 12
                font.pointSize: 16
            }

            ScrollView {
                id: scrollView
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: rectangleTop.bottom
                anchors.bottom: parent.bottom
                anchors.topMargin: 5
                anchors.bottomMargin: 17
                anchors.rightMargin: 10
                anchors.leftMargin: 10
            }

            Rectangle {
                id: rectangleTop
                x: 62
                y: 35
                height: 69
                color: "#5c667d"
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.topMargin: 40
                anchors.rightMargin: 50
                anchors.leftMargin: 10
                radius: 12

                GridLayout {
                    anchors.fill: parent
                    anchors.rightMargin: 10
                    anchors.leftMargin: 10
                    rows: 1
                    columns:  3
                    CustomTextField {
                        id: mergePdfText
                        Layout.fillWidth: true
                        Layout.fillHeight: false
                    }

                    CustomButton {
                        id: mergePdfBtn
                        text: "Add"
                        Layout.maximumHeight: 65535
                        Layout.maximumWidth: 100
                        Layout.fillWidth: true
                        Layout.preferredHeight: 40
                        Layout.preferredWidth: 250

                        onClicked: {
                            fileOpen.open()
                        }
                        FileDialog {
                            id: fileOpen
                            title: "Please Choose a file"
                            selectMultiple: true
                            nameFilters: ["PDF File (*.pdf)"]
                            onAccepted: {
                                backend.mergePdf(fileOpen.fileUrls, mergePdfText.text)
                                mergePdfText.text = ""
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
    D{i:0;autoSize:true;height:480;width:800}
}
##^##*/
