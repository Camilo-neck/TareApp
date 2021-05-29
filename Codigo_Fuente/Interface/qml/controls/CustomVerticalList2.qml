import QtQuick 2.0
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.11
import QtQml.Models 2.2
import "../controls"
import "../pages"

Item {
    property var urls : []
    property var names: []
    property var colorList: ["#77B7F7","#72C8ED","#76CBE0","#77F7EA","#7FF5C3"]
    property var fColorList: ["#5CAFF7","#5EC3E0","#04D2E0","#07F7BC","#02F56B"]
    property var colorIndex: 0

    function getNames(){
        var nameList = []
        for(var i = 0; i < visualModel.items.count; i++){
            nameList.push(visualModel.items.get(i).model.folder)
        }
        return nameList
    }

    function getExtensions(){
        var extensionList = []
        for(var i = 0; i < visualModel.items.count; i++){
            extensionList.push(visualModel.items.get(i).model.tagExt)
        }
        return extensionList
    }
    /*

    function getFoldersInfo(){
        var folders = []
        for(var i = 0; i < visualModel.items.count; i++){
            var folder = {
                "name": visualModel.items.get(i).model.folder,
                "extTags": visualModel.items.get(i).model.tagExt
            }
            folders.push(folder)
        }
        return folders
    }
    */

    function getLength(){
        return visualModel.items.count
    }

    function createListObject(fName, fExtensions) {
        var color = colorList[colorIndex];
        var fColor = fColorList[colorIndex]
        var ListElementQML = 'import QtQuick 2.0;
                              import QtQml.Models 2.2;
                              ListElement {
                              property var colore : "'+color+'";
                              property var fColore : "'+fColor+'";
                              property var folder : "'+fName+'";
                              property var tagExt : "'+fExtensions+'"}'

        var component = Qt.createQmlObject(ListElementQML,timelineModel,"dynamicSnippet1");

        if (ListElement === null) {
            // Error Handling
            console.log("Error creating object");
            return 0
        }

        timelineModel.append(component)
        if(colorIndex<4){
            colorIndex++
        }else{colorIndex=0}


    }

    function clearModel(){
        urls = []
        names = []
        timelineModel.clear()
    }

    function updateUrlsList() {
        urls = []
        names = []
        for(var i = 0; i < visualModel.items.count; i++){
            var element = visualModel.items.get(i).model
            urls.push(element.url)
            names.push(element.urlText)
        }
    }

    Rectangle {
        id: bg
        visible: true
        color: "#89c2db"
        anchors.fill: parent


        Rectangle {
            color: "#d1e5ed"
            radius: 8
            anchors.fill: parent;

            ListView{
                id: timeline
                anchors.fill: parent
                orientation: ListView.Vertical
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


                    Rectangle {
                        id: content3
                        y: 89
                        //width: 700
                        width: timeline.width-50
                        height: 57
                        color: colore
                        radius: 5
                        border.color: "#0797bd"
                        border.width: 2
                        Layout.fillWidth: true
                        //anchors.topMargin: 40
                        //anchors.rightMargin: 10
                        //anchors.leftMargin: 10

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
                                    //colorIndex--
                                    timelineModel.remove(index,1)
                                    updateUrlsList()
                                }
                            }

                            CustomTextField {
                                property var folderText : folder = this.text
                                id: folderNameInput
                                text: folder
                                width: 590
                                //"#0998e9"
                                bgColor: fColore
                                placeholderText: "Carpeta"
                                Layout.preferredWidth: 150
                                Layout.fillWidth: true
                                font.family: "Sans Serif"
                                Layout.fillHeight: false
                                font.pointSize: 10
                                placeholderTextColor: "#ffffff"
                            }

                            CustomTextField {
                                property var tagExtText : tagExt = this.text
                                id: tagExtInput
                                text: tagExt
                                width: 279
                                height: 40
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
                }

                ListModel {
                    id: timelineModel
                    //here goes the listElements that defines the rectangles
                    /*
                    ListElement {property var colore : "#c1e4fd";
                    property var folder : "";
                    property var tagExt : ""}
                    */
                }
            }
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:0.9;height:480;width:640}
}
##^##*/
