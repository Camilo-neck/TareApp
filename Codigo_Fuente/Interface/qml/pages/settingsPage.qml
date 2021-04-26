import QtQuick 2.5
import QtQuick.Window 2.0
import QtQml.Models 2.2

Window {
    visible: true
    width: 300
    height: 120
    title: qsTr("Hello World")

    Rectangle {
        anchors.fill: parent;

        ListView{
            id: timeline
            anchors.fill: parent
            orientation: ListView.Horizontal
            model: visualModel
            delegate: timelineDelegate

            moveDisplaced: Transition {
                NumberAnimation{
                    properties: "x,y"
                    duration: 200
                }
            }

            DelegateModel {
                id: visualModel
                model: timelineModel
                delegate: timelineDelegate
            }

            Component {
                id: timelineDelegate


                MouseArea {
                    id: dragArea

                    width: 100; height: 100

                    property bool held: false

                    drag.target: held ? content : undefined
                    drag.axis: Drag.XAxis

                    onPressAndHold: held = true
                    onReleased: held = false

                    Rectangle {
                        id: content

                        anchors { horizontalCenter: parent.horizontalCenter; verticalCenter: parent.verticalCenter }
                        width: 100
                        height: 100

                        color: colore
                        opacity: dragArea.held ? 0.8 : 1.0

                        Drag.active: dragArea.held
                        Drag.source: dragArea
                        Drag.hotSpot.x: width / 2
                        Drag.hotSpot.y: height / 2

                        states: State{
                            when: dragArea.held
                            ParentChange { target: content; parent: timeline }
                            AnchorChanges {
                                target: content
                                anchors { horizontalCenter: undefined; verticalCenter: undefined }
                            }
                        }
                    }

                    DropArea {
                        anchors.fill: parent
                        onEntered: {
                            visualModel.items.move( drag.source.DelegateModel.itemsIndex, dragArea.DelegateModel.itemsIndex)
                            timeline.currentIndex = dragArea.DelegateModel.itemsIndex
                        }
                    }
                }
            }

            ListModel {
                id: timelineModel
                // @disable-check M16
                ListElement { colore: "blue" }
                // @disable-check M16
                ListElement { colore: "orange" }
                // @disable-check M16
                ListElement { colore: "red" }
                // @disable-check M16
                ListElement { colore: "yellow" }
                // @disable-check M16
                ListElement { colore: "green" }
                // @disable-check M16
                ListElement { colore: "yellow" }
                // @disable-check M16
                ListElement { colore: "red" }
                // @disable-check M16
                ListElement { colore: "blue" }
                // @disable-check M16
                ListElement { colore: "green" }
            }
        }
    }
}

