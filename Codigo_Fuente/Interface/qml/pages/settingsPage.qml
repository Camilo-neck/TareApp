import QtQuick 2.7
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.11
import QtQml.Models 2.2
import "../controls"
import Qt.labs.animation 1.0

import QtQuick.Window 2.15
import QtGraphicalEffects 1.0

Item{

    Rectangle {
        id: bg
        color: "#89c2db"
        anchors.fill: parent
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0

        CustomTopBar{
            id: bar
            x: 0
            y: 0
            height: 40
            //anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width/2
            spacing: 0
            itemColor : bg.color
            barStyle: 0
            currentIndex: 0
            repeaterModel: [{text:"Wikipedia",imgSource:"../../images/icons/wikipedia_icon.png"},
                {text:"Google",imgSource:"../../images/icons/google_icon.png"},
                {text:"Text",imgSource:"../../images/icons/text_icon.png"},
                {text:"Url",imgSource:"../../images/icons/url_icon.svg"}]
        }


        StackLayout {
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: bar.bottom
            anchors.bottom: parent.bottom
            currentIndex: bar.currentIndex
            Item {
                id: homeTab
                Rectangle {
                    id: content

                    anchors { horizontalCenter: parent.horizontalCenter; verticalCenter: parent.verticalCenter }

                    width: 100
                    height: 40
                    //opacity: dragArea.held ? 0.8 : 1.0
                    border.color: "#0797bd"
                    border.width: 2
                    anchors.verticalCenterOffset: -156
                    anchors.horizontalCenterOffset: 145
                    radius: 5



                    Text{
                        text: "urlText"

                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter

                        font.pixelSize: 20
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }

                    CustomButton {
                        id: bttn1
                        customRadius : 5
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        font.pointSize: 25
                        anchors.rightMargin: 85
                        anchors.bottomMargin: 25
                        anchors.leftMargin: 0
                        anchors.topMargin: 0
                        Layout.preferredWidth: 10
                        Layout.maximumWidth: 10
                        btnColorMouseOver: "#78ede7"
                        Layout.maximumHeight: 65535
                        btnColorClicked: "#ec0606"
                        btnColorDefault: "#0797bd"
                        Layout.fillWidth: true
                        Layout.preferredHeight: 10
                        onClicked: {
                            timelineModel.remove(index,1)
                            updateUrlsList()
                        }

                        Text{
                            color: "#ffffff"
                            text: "-"
                            anchors.fill: parent
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            anchors.bottomMargin: 4
                            font.pointSize: 25
                            minimumPixelSize: 12
                        }
                    }

                }




                Rectangle {
                    id: content2
                    y: 47

                    //anchors { horizontalCenter: parent.horizontalCenter; verticalCenter: parent.verticalCenter }

                    width: 447
                    height: 29
                    //opacity: dragArea.held ? 0.8 : 1.0
                    border.color: "#0797bd"
                    border.width: 2
                    anchors.left: parent.left
                    anchors.leftMargin: 29
                    radius: 5

                    color: "#c1e4fd"

                    Text{
                        width: 175


                        text : "TestText"
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        font.pixelSize: 13
                        verticalAlignment: Text.AlignTop
                        anchors.leftMargin: 8
                        anchors.topMargin: 8
                        anchors.bottomMargin: 8
                        anchors.verticalCenterOffset: 0
                    }

                    CheckBox {
                        id: checkBox
                        width: 19
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.rightMargin: 8
                        font.pointSize: 4
                        checkable: true
                        checkState: Qt.Unchecked
                        anchors.bottomMargin: 6
                        anchors.topMargin: 6
                        indicator.width: 20
                        indicator.height: 20
                    }
                }

                Rectangle {
                    id: content3
                    y: 82
                    width: 447
                    height: 57
                    color: "#c1e4fd"
                    radius: 5
                    border.color: "#0797bd"
                    border.width: 2
                    anchors.left: parent.left
                    anchors.leftMargin: 29

                    GridLayout {
                        anchors.fill: parent
                        anchors.bottomMargin: 8
                        anchors.rightMargin: 10
                        columns: 4
                        anchors.leftMargin: 8

                        CustomButton {
                            id: bttn3
                            width: 20
                            height: 48
                            Layout.rightMargin: 5
                            topPadding: 6
                            rightPadding: 8
                            Layout.bottomMargin: -8
                            Layout.margins: 0
                            Layout.leftMargin: -6
                            Layout.topMargin: -8
                            Layout.columnSpan: 1
                            Layout.rowSpan: 1
                            Layout.fillHeight: true
                            Layout.maximumHeight: 65535
                            btnColorClicked: "#0797bd"
                            Layout.preferredWidth: 20
                            Text {
                                color: "#ffffff"
                                text: "-"
                                anchors.fill: parent
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                anchors.bottomMargin: 4
                                minimumPixelSize: 12
                                font.pointSize: 25
                            }
                            font.pointSize: 25
                            Layout.preferredHeight: 10
                            Layout.fillWidth: false
                            btnColorMouseOver: "#0797bd"
                            Layout.maximumWidth: 25
                            btnColorDefault: "#0797bd"
                            customRadius: 2
                            onClicked: {
                                timelineModel.remove(index,1)
                                updateUrlsList()
                            }
                        }

                        CustomTextField {
                            id: folderNameInput
                            width: 590
                            Layout.preferredWidth: 150
                            bgColor: "#0998e9"
                            placeholderText: "Carpeta"
                            Layout.fillWidth: true
                            font.family: "Sans Serif"
                            Layout.fillHeight: false
                            font.pointSize: 10
                            placeholderTextColor: "#ffffff"
                        }

                        CustomTextField {
                            id: tagExtInput
                            width: 279
                            height: 40
                            Layout.preferredWidth: -1
                            bgColor: "#39b3f9"
                            placeholderText: "Extensiones o Eiquetas"
                            Layout.fillWidth: true
                            font.family: "Sans Serif"
                            Layout.fillHeight: false
                            font.pointSize: 10
                            placeholderTextColor: "#ffffff"
                        }


                        rows: 1
                        anchors.topMargin: 8
                    }
                }


                CustomVerticalList2 {
                    id: list2
                    y: 157
                    height: 148
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 135
                    anchors.rightMargin: 364
                    anchors.leftMargin: 29

                    CustomButton {
                        id: bttadd1
                        x: 748
                        y: 42
                        width: 40
                        height: 42
                        text: "+"
                        anchors.right: parent.right
                        anchors.bottom: parent.bottom
                        anchors.rightMargin: 8
                        anchors.bottomMargin: 8
                        Layout.preferredWidth: 250
                        Layout.maximumHeight: 65535
                        btnColorDefault: "#009aeb"
                        btnColorMouseOver: "#78ede7"
                        btnColorClicked: "#ec0606"
                        Layout.maximumWidth: 70
                        font.family: "Sans Serif"
                        onClicked: {
                            list2.createListObject()
                        }
                        font.pointSize: 10
                        Layout.preferredHeight: 40
                        Layout.fillWidth: true
                    }
                }


                Rectangle {
                    id: rectangle3
                    height: 84
                    color: "#ffffff"
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 34
                    anchors.leftMargin: 25
                    anchors.rightMargin: 19

                    Rectangle {
                        id: content4
                        x: -30
                        y: 12
                        height: 57
                        color: "#c1e4fd"
                        radius: 5
                        border.color: "#0797bd"
                        border.width: 2
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.rightMargin: 8
                        anchors.leftMargin: 8
                        GridLayout {
                            anchors.fill: parent
                            anchors.topMargin: 8
                            rows: 1
                            anchors.rightMargin: 10
                            anchors.leftMargin: 8
                            anchors.bottomMargin: 8
                            columns: 4

                            Rectangle {
                                id: rectangle
                                width: 200
                                height: 200
                                color: "#5dc9ef"
                                radius: 5
                                Layout.preferredWidth: 80
                                Layout.fillHeight: true
                                Layout.fillWidth: false
                            }

                            Rectangle {
                                id: rectangle1
                                width: 200
                                height: 200
                                color: "#5dc9ef"
                                radius: 5
                                Layout.fillHeight: true
                                Layout.fillWidth: true
                            }

                            Rectangle {
                                id: rectangle2
                                width: 200
                                height: 200
                                color: "#5dc9ef"
                                radius: 5
                                Layout.preferredWidth: 110
                                Layout.fillHeight: true
                                Layout.fillWidth: true
                            }
                        }
                    }
                }
                CustomButton {
                    id: bttn2
                    y: 45
                    customRadius : 5
                    anchors.left: parent.left
                    anchors.right: parent.right
                    font.pointSize: 25
                    anchors.rightMargin: 15
                    anchors.leftMargin: 755
                    Layout.preferredWidth: 10
                    Layout.maximumWidth: 10
                    btnColorMouseOver: "#78ede7"
                    Layout.maximumHeight: 65535
                    btnColorClicked: "#ec0606"
                    btnColorDefault: "#0797bd"
                    Layout.fillWidth: true
                    Layout.preferredHeight: 10
                    onClicked: {
                        console.log("Espere por favor ...")
                        busyIndicator.timerFunction = () => {backend.longF()
                            console.log("Proceso terminado")}
                        busyIndicator.start()

                    }
                }


                CustomBusyIndicator{
                    id: busyIndicator
                    anchors.verticalCenterOffset: -136
                    anchors.horizontalCenterOffset: 270
                    anchors.centerIn: parent
                    implicitWidth: 96
                    implicitHeight: 96
                    running: false
                    mainColor: '#38A1DB'
                    secondaryColor: '#33E2F2'

                }


            }
            Item {
                id: discoverTab

                CustomVerticalList2 {
                    id: list3
                    y: 8
                    height: 417
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    CustomButton {
                        id: bttadd2
                        x: 748
                        y: 42
                        width: 40
                        height: 42
                        text: "+"
                        anchors.right: parent.right
                        anchors.bottom: parent.bottom
                        btnColorMouseOver: "#78ede7"
                        Layout.maximumWidth: 70
                        onClicked: {
                            list3.createListObject()
                        }
                        Layout.fillWidth: true
                        anchors.rightMargin: 8
                        Layout.maximumHeight: 65535
                        Layout.preferredWidth: 250
                        btnColorDefault: "#009aeb"
                        Layout.preferredHeight: 40
                        anchors.bottomMargin: 8
                        font.pointSize: 10
                        font.family: "Sans Serif"
                        btnColorClicked: "#ec0606"
                    }
                    anchors.rightMargin: 22
                    anchors.leftMargin: 22
                    anchors.bottomMargin: 15
                }
            }
            Item {
                id: activityTab
                Rectangle {
                    id: rectangle23
                    width: 500
                    height: 600

                    SplitView {
                        anchors.fill: parent
                        orientation: Qt.Vertical

                        PropertyAnimation {
                            id: heightAnimation
                            target: rect1
                            property: "height";
                            from: 0;
                            to: 400;
                            duration: 500;
                            running: false;
                            loops: 1;
                        }

                        Rectangle {
                            id: rect1
                            height: 0
                            Layout.maximumHeight: 400
                            color: "blue"

                            Text {
                                text: "View 1"
                                anchors.centerIn: parent
                            }
                        }

                        Rectangle {
                            id: rect2
                            Layout.minimumHeight: 50
                            Layout.fillHeight: true
                            color: "lightgray"
                            Text {
                                text: "View 2"
                                anchors.centerIn: parent
                            }
                        }

                        Rectangle {
                            id: rect3
                            height: 200
                            color: "lightgreen"
                            Text {
                                text: "View 3"
                                anchors.centerIn: parent
                            }

                            MouseArea {
                                id: mouseArea1
                                x: 8
                                y: 5
                                width: 484
                                height: 187

                                onClicked: heightAnimation.start();
                            }
                        }
                    }
                }
            }
            Item {
                id: fouthTab
            }
        }
    }







    Connections {
        target: backend
        function onResponse(text) {
            textHome.text = text
        }
    }



    /*


    ApplicationWindow {
        width: 400
        height: 400
        visible: true

        //Component.onCompleted: print(Qt.formatDateTime(new Date(), "mm:ss:zzz"), "QML loaded")

        CustomButton {
            id: bttn2
            customRadius : 5
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            font.pointSize: 25
            anchors.rightMargin: 85
            anchors.bottomMargin: 25
            anchors.leftMargin: 0
            anchors.topMargin: 0
            Layout.preferredWidth: 10
            Layout.maximumWidth: 10
            btnColorMouseOver: "#78ede7"
            Layout.maximumHeight: 65535
            btnColorClicked: "#ec0606"
            btnColorDefault: "#0797bd"
            Layout.fillWidth: true
            Layout.preferredHeight: 10
            onClicked: {
                if (!loader.item) {
                    loader.active = true
                }
            }
        }

        //onAfterSynchronizing: {}
        }

        Item {
            anchors.fill: parent

            BusyIndicator {
                running: !loader.item
                anchors.centerIn: parent
            }

            Loader {
                id: loader
                active: false
                anchors.fill: parent
                sourceComponent: Text {
                    wrapMode: Text.Wrap

                    Component.onCompleted: {
                        for (var i = 0; i < 1500; ++i) {
                            text += "Hello, ";
                        }
                    }
                }
            }
        }
        */


}


/*##^##
Designer {
    D{i:0;formeditorZoom:1.1;height:480;width:840}
}
##^##*/
