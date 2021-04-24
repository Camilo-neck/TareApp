import QtQuick 2.14
import QtQuick.Window 2.14
import QtQuick.Controls 2.15
import "controls"
import QtGraphicalEffects 1.15
import QtQuick.Layouts 1.11
import QtQuick.Dialogs 1.3

Window {
    id: mainwindow
    width: 1000
    height: 580
    minimumWidth: 800
    minimumHeight: 500
    visible: true
    color: "#00000000"
    title: qsTr("Course APP")

    //REMOVE TITLE BAR
    flags: Qt.Window | Qt.FramelessWindowHint

    // Properties
    property int windowStatus: 0
    property int windowMargin: 10

    property alias actualPage: stackView.currentItem

    //INTERNAL FUNCTIONS
    QtObject {
        id: internal
        function maximizeRestore() {
            if(windowStatus == 0) {
                mainwindow.showMaximized()
                windowStatus = 1
                windowMargin = 0
            }else {
                windowStatus = 0
                windowMargin = 10
                mainwindow.showNormal()
            }
        }

        function ifMaximizedWindowRestore() {
            if(windowStatus == 1) {
                windowStatus = 0
                windowMargin = 10
            }
        }

        function restoreMargins() {
            windowMargin = 10
            windowStatus = 0
        }
    }


    Rectangle {
        id: bg
        color: "#2c313c"
        border.color: "#353b48"
        border.width: 1
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.rightMargin: windowMargin
        anchors.bottomMargin: windowMargin
        anchors.leftMargin: windowMargin
        anchors.topMargin: windowMargin
        z: 1

        Rectangle {
            id: container
            color: "#00000000"
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.topMargin: 1
            anchors.bottomMargin: 1
            anchors.leftMargin: 1
            anchors.rightMargin: 1

            Rectangle {
                id: topBar
                height: 60
                color: "#1c1d20"
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.rightMargin: 0
                anchors.leftMargin: 0
                anchors.topMargin: 0

                ToggleButton {
                    onClicked: animationMenu.running = true
                }

                Rectangle {
                    id: topBarDescription
                    x: 70
                    y: 438
                    width: 528
                    height: 25
                    color: "#282c34"
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    anchors.rightMargin: 0
                    anchors.leftMargin: 70
                    anchors.bottomMargin: 0

                    Label {
                        id: labelTopInfo
                        color: "#5f6a82"
                        text: qsTr("Application Description")
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignVCenter
                        font.pointSize: 9
                        anchors.bottomMargin: 0
                        anchors.rightMargin: 300
                        anchors.leftMargin: 20
                        anchors.topMargin: 0
                    }

                    Label {
                        id: label1
                        color: "#5f6a82"
                        text: qsTr("| Home")
                        anchors.left: labelTopInfo.right
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        horizontalAlignment: Text.AlignRight
                        verticalAlignment: Text.AlignVCenter
                        font.pointSize: 9
                        anchors.rightMargin: 10
                        anchors.leftMargin: 0
                        anchors.bottomMargin: 0
                        anchors.topMargin: 0
                    }
                }

                Rectangle {
                    id: titleBar
                    height: 35
                    color: "#00000000"
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.rightMargin: 105
                    anchors.leftMargin: 70
                    anchors.topMargin: 0

                    DragHandler {
                        onActiveChanged: if(active) {
                                             mainwindow.startSystemMove()
                                             internal.ifMaximizedWindowRestore()
                                         }
                    }

                    Image {
                        id: iconApp
                        width: 25
                        height: 25
                        anchors.left: parent.left
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        source: "../images/icons/icon_app_top.svg"
                        anchors.bottomMargin: 0
                        anchors.leftMargin: 5
                        anchors.topMargin: 0
                        fillMode: Image.PreserveAspectFit
                    }

                    Label {
                        id: label
                        color: "#c3cbdd"
                        text: qsTr("My Application Title")
                        anchors.left: iconApp.right
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignVCenter
                        font.pointSize: 10
                        anchors.leftMargin: 5
                    }
                }

                Row {
                    id: row
                    anchors.left: titleBar.right
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: topBarDescription.top
                    anchors.leftMargin: 0
                    anchors.rightMargin: 0
                    anchors.bottomMargin: 0
                    anchors.topMargin: 0

                    TopBarButton {
                        id: minimizeBtn
                        btnColorMouseOver: "#b7f4a9"
                        btnColorClicked: "#4afb00"
                        onClicked: {

                            mainwindow.showMinimized()
                            internal.restoreMargins()

                        }

                    }

                    TopBarButton {
                        id: maximizeRestoreBtn
                        btnIconSource: "../images/icons/icon_maximize.png"
                        btnColorMouseOver: "#ecd393"
                        btnColorClicked: "#fffb26"
                        anchors.leftMargin: 35
                        onClicked: internal.maximizeRestore()
                    }

                    TopBarButton {
                        id: closeBtn
                        btnColorMouseOver: "#ff9e95"
                        btnColorClicked: "#df0707"
                        btnIconSource: "../images/icons/icon_close.png"
                        anchors.leftMargin: 70
                        onClicked: mainwindow.close()
                    }
                }
            }

            Rectangle {
                id: content
                color: "#00000000"
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: topBar.bottom
                anchors.bottom: parent.bottom
                anchors.topMargin: 0

                Rectangle {
                    id: leftMenu
                    width: 70
                    color: "#1c1d20"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 0
                    anchors.topMargin: 0
                    anchors.bottomMargin: 0

                    PropertyAnimation {
                        id: animationMenu
                        target: leftMenu
                        property: "width"
                        to: if(leftMenu.width == 70) return 250; else return 70
                        duration: 1000
                        easing.type: Easing.OutBounce
                    }

                    Column {
                        id: columnMenus
                        width: 70
                        anchors.fill: parent
                        anchors.bottomMargin: 90

                        LeftMenuBtn {
                            id: btnHome
                            width: leftMenu.width
                            text: qsTr("Home")
                            isActiveMenu: true
                            onClicked: {
                                btnHome.isActiveMenu = true
                                btnSettings.isActiveMenu = false
                                btnEdit.isActiveMenu = false
                                btnPdf.isActiveMenu = false
                                stackView.push(Qt.resolvedUrl("pages/homePage.qml"))
                            }
                        }

                        LeftMenuBtn {
                            id: btnOpen
                            width: 70
                            text: qsTr("Open")
                            btnIconSource: "../images/icons/open_icon.svg"

                            onPressed: {
                                btnHome.isActiveMenu = false
                                btnSettings.isActiveMenu = false
                                btnEdit.isActiveMenu = true
                                stackView.push(Qt.resolvedUrl("pages/textEditor.qml"))
                                fileOpen.open()
                            }

                            FileDialog {
                                id: fileOpen
                                title: "Please Choose a file"
                                selectMultiple: false
                                nameFilters: ["Text File (*.txt)"]
                                onAccepted: {
                                    backend.openFile(fileOpen.fileUrl)
                                }
                            }
                        }

                        LeftMenuBtn {
                            id: btnSave
                            width: leftMenu.width
                            text: qsTr("Save")
                            btnIconSource: "../images/icons/save_icon.svg"
                            onPressed: {
                                fileSave.open()
                            }

                            FileDialog {
                                id: fileSave
                                title: "Save file"
                                folder: shortcuts.home
                                nameFilters: ["Text File (*.txt)"]
                                selectExisting: false
                                onAccepted: {
                                    backend.getTextField(actualPage.getText)
                                    backend.writeFile(fileSave.fileUrl)
                                }
                            }
                        }

                        LeftMenuBtn {
                            id: btnEdit
                            width: leftMenu.width
                            text: qsTr("Edit File")
                            btnIconSource: "../images/icons/icon_editor.png"
                            onClicked: {
                                btnHome.isActiveMenu = false
                                btnSettings.isActiveMenu = false
                                btnEdit.isActiveMenu = true
                                stackView.push(Qt.resolvedUrl("pages/textEditor.qml"))
                            }
                        }

                        LeftMenuBtn {
                            id: btnTest
                            width: leftMenu.width
                            text: qsTr("Test")
                            btnIconSource: "../images/icons/icon_restore.png"
                            isActiveMenu: false
                            onClicked: {
                                stackView.push(Qt.resolvedUrl("pages/testPage.qml"))
                            }
                        }

                        LeftMenuBtn {
                            id: btnPdf
                            width: leftMenu.width
                            text: qsTr("Pdf")
                            btnIconSource: "../images/icons/pdf.svg"
                            isActiveMenu: false
                            onClicked: {
                                btnHome.isActiveMenu = false
                                btnSettings.isActiveMenu = false
                                btnEdit.isActiveMenu = false
                                btnPdf.isActiveMenu = true
                                stackView.push(Qt.resolvedUrl("pages/pdfPage.qml"))
                            }
                        }
                    }

                    LeftMenuBtn {
                        id: btnSettings
                        x: 0
                        y: 227
                        width: leftMenu.width
                        text: qsTr("Settings")
                        anchors.bottom: parent.bottom
                        btnIconSource: "../images/icons/settings_icon.svg"
                        anchors.bottomMargin: 25
                        onClicked: {
                            btnHome.isActiveMenu = false
                            btnSettings.isActiveMenu = true
                            btnEdit.isActiveMenu = false
                            stackView.push(Qt.resolvedUrl("pages/settingsPage.qml"))
                        }
                    }
                }

                Rectangle {
                    id: contentPages
                    color: "#2c313c"
                    anchors.left: leftMenu.right
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    clip: true
                    anchors.bottomMargin: 25
                    anchors.leftMargin: 0

                    StackView {
                        id: stackView
                        anchors.fill: parent
                        initialItem: Qt.resolvedUrl("pages/homePage.qml")
                    }
                }

                Rectangle {
                    id: rectangle
                    color: "#282c34"
                    anchors.left: leftMenu.right
                    anchors.right: parent.right
                    anchors.top: contentPages.bottom
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 0
                    anchors.topMargin: 0

                    Label {
                        id: labelTopInfo1
                        color: "#5f6a82"
                        text: qsTr("Application Description")
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignVCenter
                        anchors.rightMargin: 30
                        anchors.topMargin: 0
                        font.pointSize: 9
                        anchors.bottomMargin: 0
                        anchors.leftMargin: 20
                    }

                    MouseArea {
                        id: mouseArea
                        x: 884
                        y: 0
                        width: 25
                        height: 25
                        anchors.right: parent.right
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 0
                        anchors.rightMargin: 0
                        visible: if(windowStatus == 0) return true; else return false
                        cursorShape: Qt.SizeFDiagCursor

                        DragHandler {
                            target: null
                            onActiveChanged: if (active) {
                                                 mainwindow.startSystemResize(Qt.RightEdge | Qt.BottomEdge)
                                             }
                        }

                        Image {
                            id: image
                            opacity: 0.5
                            anchors.fill: parent
                            source: "../images/icons/resize_icon.svg"
                            anchors.leftMargin: 5
                            anchors.topMargin: 5
                            sourceSize.height: 16
                            sourceSize.width: 16
                            fillMode: Image.PreserveAspectFit
                            antialiasing: false
                        }
                    }
                }
            }
        }
    }


    DropShadow {
        anchors.fill: bg
        horizontalOffset: 0
        verticalOffset: 0
        radius: 10
        samples: 16
        color: "#80000000"
        source: bg
        z: 0
    }

    MouseArea {
        id: resizeLeft
        width: 10
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.leftMargin: 0
        anchors.topMargin: 10
        anchors.bottomMargin: 10
        visible: if(windowStatus == 0) return true; else return false
        cursorShape: Qt.SizeHorCursor

        DragHandler {
            target: null
            onActiveChanged: if(active) {mainwindow.startSystemResize(Qt.LeftEdge)}
        }
    }

    MouseArea {
        id: resizeRight
        width: 10
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.rightMargin: 0
        anchors.topMargin: 10
        anchors.bottomMargin: 10
        visible: if(windowStatus == 0) return true; else return false
        cursorShape: Qt.SizeHorCursor

        DragHandler {
            target: null
            onActiveChanged: if(active) {mainwindow.startSystemResize(Qt.RightEdge)}
        }
    }

    MouseArea {
        id: resizeTop
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: bg.top
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        anchors.topMargin: 0
        anchors.bottomMargin: 0
        visible: if(windowStatus == 0) return true; else return false
        cursorShape: Qt.SizeVerCursor

        DragHandler {
            target: null
            onActiveChanged: if(active) {mainwindow.startSystemResize(Qt.TopEdge)}
        }
    }

    MouseArea {
        id: resizeBottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: bg.bottom
        anchors.bottom: parent.bottom
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        anchors.topMargin: 0
        anchors.bottomMargin: 0
        visible: if(windowStatus == 0) return true; else return false
        cursorShape: Qt.SizeVerCursor

        DragHandler {
            target: null
            onActiveChanged: if(active) {mainwindow.startSystemResize(Qt.BottomEdge)}
        }
    }

    Connections {
        target: backend

        function onReadText(text) {
            actualPage.setText = text
        }
    }

}



/*##^##
Designer {
    D{i:0;formeditorZoom:0.9}D{i:28}
}
##^##*/
