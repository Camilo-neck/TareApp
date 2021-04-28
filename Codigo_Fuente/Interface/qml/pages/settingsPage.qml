import QtQuick 2.0
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.11
import QtQml.Models 2.2

Item {
    property var listaTest : ["pdf1","pdf2","pdf3"]

    Rectangle {
        id: bg
        visible: true
        color: "#89c2db"
        anchors.fill: parent
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0

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
                            onReleased: {
                                held = false
                                var listOnModel = "{";
                                for(var i = 0; i < visualModel.items.count; i++){
                                    listOnModel += visualModel.items.get(i).model.url + ", "
                                }
                                console.log("List: " + listOnModel + "}");
                            }

                            Rectangle {
                                id: content

                                anchors { horizontalCenter: parent.horizontalCenter; verticalCenter: parent.verticalCenter }
                                width: 100
                                height: 100

                                color: colore
                                opacity: dragArea.held ? 0.8 : 1.0

                                Text{
                                    anchors.verticalCenter: parent.verticalCenter
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    text : listaTest[index]
                                    //text: index
                                    font.pixelSize: 20
                                }

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
                                    visualModel.items.move( drag.source.DelegateModel.itemsIndex, dragArea.DelegateModel.itemsIndex);
                                }

                            }
                        }
                    }

                    ListModel {
                        id: timelineModel

                        ListElement {
                            colore: "blue"
                            property var url: "url1"
                        }

                        ListElement {
                            colore: "green"
                            property var url: "url2"
                        }

                        ListElement {
                            colore: "orange"
                            property var url: "url3"
                        }

                    }
                }
            }
     }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:1.33;height:480;width:800}
}
##^##*/
