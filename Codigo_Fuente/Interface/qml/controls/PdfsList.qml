import QtQuick 2.0
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.11
import QtQml.Models 2.2
import "../controls"

Item {
    property var urls : []
    property var listIndex : 0
    property var held: true

    function createSpriteObjects(basename,urls) {
        var url = urls[listIndex];
        var color = "#78ede7";
        var urlText = basename
        var strListElement = 'import QtQuick 2.0; import QtQml.Models 2.2; ListElement {property var colore : "'+color+'" ; property var url : "'+url+'"; property var urlText: "'+urlText+'"}'
        var component = Qt.createQmlObject(strListElement,
                                       timelineModel,
                                       "dynamicSnippet1");

        if (ListElement === null) {
            // Error Handling
            console.log("Error creating object");
            return 0
        }
        timelineModel.append(component)

        listIndex++

    }

    function updateUrlsList() {
        urls = []
        var listOnModel = "{";
        for(var i = 0; i < visualModel.items.count; i++){
            urls.push(visualModel.items.get(i).model.url)
            listOnModel += visualModel.items.get(i).model.url + ", "
        }
        //console.log("List: " + listOnModel + "}");
    }

    Rectangle {
        id: bg
        visible: true
        color: "#89c2db"
        anchors.fill: parent


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
                            updateUrlsList()
                        }

                        Rectangle {
                            id: content

                            anchors { horizontalCenter: parent.horizontalCenter; verticalCenter: parent.verticalCenter }

                            width: 100
                            height: 100
                            opacity: dragArea.held ? 0.8 : 1.0


                            color: colore

                            Text{

                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.verticalCenter: parent.verticalCenter

                                text : urlText
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

                }
            }
        }
    }
}



