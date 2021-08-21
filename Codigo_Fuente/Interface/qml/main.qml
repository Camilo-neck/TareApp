import QtQuick 2.14
import QtQuick.Window 2.14
import QtQuick.Controls 2.15
import "controls"
import QtGraphicalEffects 1.15
import QtQuick.Layouts 1.11
import QtQuick.Dialogs 1.3

Window {
    id: mainwindow
    width: 1280
    height: 800
    minimumWidth: 800
    minimumHeight: 720
    visible: true
    color: "#00000000"
    title: qsTr("SmoothTask")

    //REMOVE TITLE BAR
    //flags: Qt.Window | Qt.FramelessWindowHint

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
        radius: 0
        border.color: "#353b48"
        border.width: 1
        anchors.fill: parent
        clip: true
        z: 1

        Rectangle {
            id: container
            color: "#00000000"
            radius: 12
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            clip: false
            anchors.topMargin: 0
            anchors.bottomMargin: 0
            anchors.leftMargin: 0
            anchors.rightMargin: 0


            Rectangle {
                id: content
                color: "#00000000"
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.topMargin: 0

                Rectangle {
                    id: leftMenu
                    width: 70
                    color: "#012e40"
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

                    ToggleButton {
                        x: 0
                        y: -61
                        checked: true
                        btnColorDefault: "#012e40"
                        onClicked: animationMenu.running = true
                    }

                    ScrollView {
                        width: 70
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 90
                        anchors.topMargin: 70

                        Column {
                            id: columnMenus
                            anchors.fill: parent

                            LeftMenuBtn {
                                id: btnHome
                                width: leftMenu.width
                                text: qsTr("Home")
                                btnColorDefault: "#012e40"
                                isActiveMenu: true
                                onClicked: {
                                    btnHome.isActiveMenu = true
                                    btnSettings.isActiveMenu = false
                                    btnSearch.isActiveMenu = false
                                    btnPdf.isActiveMenu = false
                                    btnSorter.isActiveMenu = false
                                    btnPdfgen.isActiveMenu = false
                                    btnHelp.isActiveMenu = false

                                    location.text = qsTr("| Home")
                                    labelTopInfo.text = qsTr("Bienvenidos")
                                    stackView.push(Qt.resolvedUrl("pages/homePage.qml"))
                                }
                            }

                            LeftMenuBtn {
                                id: btnSearch
                                width: leftMenu.width
                                text: qsTr("Consultor")
                                btnColorDefault: "#012e40"
                                btnIconSource: "../images/icons/search_icon.svg"
                                isActiveMenu: false
                                onClicked: {
                                    btnHome.isActiveMenu = false
                                    btnSettings.isActiveMenu = false
                                    btnSearch.isActiveMenu = true
                                    btnPdf.isActiveMenu = false
                                    btnSorter.isActiveMenu = false
                                    btnPdfgen.isActiveMenu = false
                                    btnHelp.isActiveMenu = false

                                    location.text = qsTr("| Search")
                                    labelTopInfo.text = qsTr("Investiga con la mayor facilidad.")
                                    stackView.push(Qt.resolvedUrl("pages/searchPage.qml"))
                                }
                            }

                            LeftMenuBtn {
                                id: btnPdf
                                width: leftMenu.width
                                text: qsTr("PDFs Editor")
                                btnColorDefault: "#012e40"
                                btnIconSource: "../images/icons/pdf.svg"
                                isActiveMenu: false
                                onClicked: {
                                    btnHome.isActiveMenu = false
                                    btnSettings.isActiveMenu = false
                                    btnSearch.isActiveMenu = false
                                    btnPdf.isActiveMenu = true
                                    btnSorter.isActiveMenu = false
                                    btnPdfgen.isActiveMenu = false
                                    btnHelp.isActiveMenu = false

                                    location.text = qsTr("| PDF Editor")
                                    labelTopInfo.text = qsTr("Organiza tus pdfs como nunca antes")
                                    stackView.push(Qt.resolvedUrl("pages/pdfPage.qml"))
                                }
                            }

                            LeftMenuBtn {
                                id: btnSorter
                                width: leftMenu.width
                                text: qsTr("Folders Sorter")
                                checked: true
                                btnIconSource: "../images/icons/sortIcon.png"
                                btnColorDefault: "#012e40"
                                isActiveMenu: false
                                onClicked: {
                                    btnHome.isActiveMenu = false
                                    btnSettings.isActiveMenu = false
                                    btnSearch.isActiveMenu = false
                                    btnPdf.isActiveMenu = false
                                    btnSorter.isActiveMenu = true
                                    btnPdfgen.isActiveMenu = false
                                    btnHelp.isActiveMenu = false

                                    location.text = qsTr("| File organizer")
                                    labelTopInfo.text = qsTr("Organiza y Etiqueta tus archivos facilmente.")
                                    stackView.push(Qt.resolvedUrl("pages/sorterPage.qml"))

                                }
                            }
                            LeftMenuBtn {
                                id: btnPdfgen
                                width: leftMenu.width
                                text: qsTr("Documentos con formato")
                                isActiveMenu: false
                                btnColorDefault: "#012e40"
                                btnIconSource: "../images/icons/docx_icon.png"
                                onClicked: {
                                    btnHome.isActiveMenu = false
                                    btnSettings.isActiveMenu = false
                                    btnSearch.isActiveMenu = false
                                    btnPdf.isActiveMenu = false
                                    btnSorter.isActiveMenu = false
                                    btnPdfgen.isActiveMenu = true
                                    btnHelp.isActiveMenu = false

                                    location.text = qsTr("| Generador de documentos")
                                    labelTopInfo.text = qsTr("Genera tus documentos con el formato que desees.")
                                    stackView.push(Qt.resolvedUrl("pages/docGeneratorPage.qml"))
                                }
                            }


                        }

                    }

                    LeftMenuBtn {
                        id: btnHelp
                        x: 0
                        y: 227
                        width: leftMenu.width
                        text: qsTr("Help")
                        anchors.bottom: parent.bottom
                        btnColorDefault: "#012e40"
                        btnIconSource: "../images/icons/help_icon.png"
                        anchors.bottomMargin: 25
                        onClicked: {
                            btnHome.isActiveMenu = false
                            btnSettings.isActiveMenu = false
                            btnSearch.isActiveMenu = false
                            btnPdf.isActiveMenu = false
                            btnSorter.isActiveMenu = false
                            btnPdfgen.isActiveMenu = false
                            btnHelp.isActiveMenu = true

                            stackView.push(Qt.resolvedUrl("pages/helpPage.qml"))

                            location.text = qsTr("| Ayuda")
                            labelTopInfo.text = qsTr("Obten ayuda sobre el uso de nuestras aplicaciones.")
                        }
                    }

                    LeftMenuBtn {
                        id: btnSettings
                        x: 0
                        y: 488
                        width: leftMenu.width
                        text: qsTr("Settings")
                        anchors.bottom: parent.bottom
                        btnColorDefault: "#012e40"
                        btnIconSource: "../images/icons/settings_icon.svg"
                        anchors.bottomMargin: 90
                        onClicked: {
                            btnHome.isActiveMenu = false
                            btnSettings.isActiveMenu = true
                            stackView.push(Qt.resolvedUrl("pages/settingsPage.qml"))
                        }
                    }

                }

                Rectangle {
                    id: contentPages
                    color: "#89c2db"
                    anchors.left: leftMenu.right
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.topMargin: 0
                    clip: true
                    anchors.bottomMargin: 25
                    anchors.leftMargin: 0

                    StackView {
                        id: stackView
                        anchors.fill: parent
                        anchors.topMargin: 35
                        initialItem: Qt.resolvedUrl("pages/homePage.qml")
                    }
                }

                Rectangle {
                    id: rectangle
                    color: "#03738c"
                    anchors.left: leftMenu.right
                    anchors.right: parent.right
                    anchors.top: contentPages.bottom
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 0
                    anchors.topMargin: 0

                    Label {
                        id: labelBottomInfo
                        color: "#1efae7"
                        text: qsTr("La mejor App para hacer tus tareas")
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignVCenter
                        font.family: "Sans Serif"
                        anchors.rightMargin: 30
                        anchors.topMargin: 0
                        font.pointSize: 10
                        anchors.bottomMargin: 0
                        anchors.leftMargin: 20
                    }

                    Label {
                        id: dateLabel
                        color: "#1efae7"
                        text: qsTr("Date")
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        font.pointSize: 10
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
            Rectangle {
                id: topBar
                height: 36
                color: "#ffffff"
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.topMargin: 0
                anchors.rightMargin: 0
                anchors.leftMargin: 70

                Rectangle {
                    id: topBarDescription
                    x: 70
                    width: 528
                    color: "#03738c"
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.topMargin: 0
                    anchors.rightMargin: 0
                    anchors.leftMargin: 0
                    anchors.bottomMargin: 0

                    Label {
                        id: labelTopInfo
                        color: "#1efae7"
                        text: qsTr("Bienvenido")
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignVCenter
                        font.family: "Sans Serif"
                        font.pointSize: 10
                        anchors.bottomMargin: 0
                        anchors.rightMargin: 300
                        anchors.leftMargin: 20
                        anchors.topMargin: 0
                    }

                    Label {
                        id: location
                        color: "#1efae7"
                        text: qsTr("| Home")
                        anchors.left: labelTopInfo.right
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        horizontalAlignment: Text.AlignRight
                        verticalAlignment: Text.AlignVCenter
                        font.family: "Sans Serif"
                        font.pointSize: 10
                        anchors.rightMargin: 10
                        anchors.leftMargin: 0
                        anchors.bottomMargin: 0
                        anchors.topMargin: 0
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

        function onPrintTime(time) {
            dateLabel.text = time
        }

    }

}



/*##^##
Designer {
    D{i:0;formeditorZoom:0.9;height:720;width:1080}D{i:26}D{i:25}
}
##^##*/
