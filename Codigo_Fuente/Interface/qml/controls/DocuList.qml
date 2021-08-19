import QtQuick 2.0
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.11
import QtQml.Models 2.2
import "../controls"

Item {
    property var urls : []
    property var held: true

    function createListObject(name,url) {
        var color = "#c1e4fd";
        var urlText = name
        var ListElementQML = 'import QtQuick 2.0;
                              import QtQml.Models 2.2;
                              ListElement {property var colore : "'+color+'" ;
                              property var url : "'+url+'";
                              property var urlText: "'+urlText+'"}'

        var component = Qt.createQmlObject(ListElementQML,timelineModel,"dynamicSnippet1");

        if (ListElement === null) {
            // Error Handling
            console.log("Error creating object");
            return 0
        }

        urls.push(url)
        timelineModel.append(component)

    }

    function clearModel(){
        urls = []
        timelineModel.clear()
    }

    function updateUrlsList() {
        urls = []
        for(var i = 0; i < visualModel.items.count; i++){
            urls.push(visualModel.items.get(i).model.url)
        }
    }

    function extractPages(pages) {

        var indexs = pages.map((pag) => urls.indexOf(pag)).sort((i1,i2) => {return i1-i2})
        console.log("indexs: "+indexs)

        var len = timelineModel.count
        var n = 0

        for(var i = 0; i<len; i++){
            if(i !== indexs[n]){
                timelineModel.remove(n,1)

            }else{
                n++
            }
        }
        updateUrlsList()
    }
    function getNames(){
                var nameList = []
                for(var i = 0; i < visualModel.items.count; i++){
                    nameList.push(visualModel.items.get(i).model.urlText)
                }
                return nameList
            }

    Rectangle {
        id: bg1
        visible: true
        color: "#89c2db"
        //anchors.fill: parent
        anchors.leftMargin: 20
        //anchors.topMargin: 20
        anchors.bottomMargin: 2

        anchors.left:parent.left
        anchors.top:parent.top
        anchors.bottom:parent.bottom


        Rectangle {
            id:bg2
            anchors.fill: parent;

            ListView{
                id: timeline
                anchors.fill: parent
                orientation: ListView.Horizontal
                spacing: 2
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

                        width: 100; height: 40

                        property bool held: false

                        drag.target: held ? content : undefined
                        drag.axis: Drag.XAxis

                        onPressAndHold: held = true
                        onReleased: {
                            held = false
                            updateUrlsList()
                            console.log(urls)
                        }

                        Rectangle {
                            id: content

                            anchors { horizontalCenter: parent.horizontalCenter; verticalCenter: parent.verticalCenter}

                            width: 120
                            height: 78
                            opacity: dragArea.held ? 0.8 : 1.0
                            border.color: "#0797bd"
                            border.width: 2
                            radius: 5

                            color: colore

                            Text{
                                id:docuText
                                anchors.horizontalCenter: parent.horizontalCenter;
                                anchors.topMargin: 52
                                anchors.bottomMargin: 2
                                //anchors.left: parent.left
                                //anchors.right: parent.right
                                anchors.top: parent.top
                                anchors.bottom: parent.bottom
                                text : urlText
                                font.pixelSize: 17

                            }
                            Image{
                                id: docxImg
                                source: "../../images/icons/word_icon.svg"
                                width: 50
                                height: 50
                                anchors.horizontalCenter: parent.horizontalCenter;
                                //anchors.verticalCenter: parent.verticalCenter
                                anchors.topMargin:5
                                //anchors.bottomMargin: 17
                                //anchors.rightMargin: 8
                                //sourceSize.height: 50
                                //sourceSize.width: 50
                                //anchors.leftMargin: 8
                                //anchors.left: parent.left
                                //anchors.right: parent.right
                                anchors.top: parent.top
                                //anchors.bottom: parent.bottom
                                fillMode: Image.PreserveAspectFit
                                visible: true
                                antialiasing: true
                            }

                            CustomButton {
                                id: delBttn
                                customRadius : 5
                                //anchors.left: parent.left
                                //anchors.right: parent.right
                                //anchors.top: parent.top
                                //anchors.bottom: parent.bottom
                                font.pointSize: 25
                                //anchors.rightMargin: 85
                                //anchors.bottomMargin: 25
                                //anchors.leftMargin: 0
                                //anchors.topMargin: 0
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
                                var from = drag.source.DelegateModel.itemsIndex
                                var to = dragArea.DelegateModel.itemsIndex
                                var n = from>to ? from-to : to-from
                                visualModel.items.move( from, to);
                                timelineModel.move( from, to, n)
                            }

                        }
                    }

                }

                ListModel {
                    id: timelineModel
                    //here goes the listElements that defines the rectangles

                }
            }
        }
    }
}
