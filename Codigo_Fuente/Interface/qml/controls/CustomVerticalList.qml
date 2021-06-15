import QtQuick 2.0
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.11
import QtQml.Models 2.2
import "../controls"
import "../pages"

Item {
    property var urls : []
    property var names: []
    property var checkBoxValues : []
    property var etiqueta : ""
    property var labelAction: 0
    property var selectAll: false

    function count(){return visualModel.items.count}

    function getCheckedUrls(){
        var checkedUrls = []
        for(var i = 0; i < visualModel.items.count; i++){
            var element = visualModel.items.get(i).model
            if(element.isChecked || selectAll){
                checkedUrls.push(element.url)
            }
        }
        return checkedUrls
    }

    function updateCheckBoxValues(){
        checkBoxValues = []
        for(var i = 0; i < visualModel.items.count; i++){
            checkBoxValues.push(visualModel.items.get(i).model.isChecked)
        }
    }

    function getNames(){
        var nameList = []
        for(var i = 0; i < visualModel.items.count; i++){
            nameList.push(visualModel.items.get(i).model.urlText)
        }
        return nameList
    }


    /*
    function updateNames(){
        for(var i = 0; i < visualModel.items.count; i++){
            var element = visualModel.items.get(i).model
            if(element.isChecked){
                element.urlText += " "+etiqueta

            }
        }
    }
    */

    function createListObject(name,url) {
        var color = "#c1e4fd";
        var urlText = name
        var ListElementQML = 'import QtQuick 2.0;
                              import QtQml.Models 2.2;
                              ListElement {property var colore : "'+color+'" ;
                              property var url : "'+url+'";
                              property var urlText: "'+urlText+'" ;
                              property var isChecked: false;
                              property var labels: []}'

        var component = Qt.createQmlObject(ListElementQML,timelineModel,"dynamicSnippet1");

        if (ListElement === null) {
            // Error Handling
            console.log("Error creating object");
            return 0
        }

        urls.push(url)
        names.push(urlText)
        timelineModel.append(component)

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
                clip: true


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
                        id: content
                        //anchors { horizontalCenter: parent.horizontalCenter; verticalCenter: parent.verticalCenter }

                        //width: 650
                        width: timeline.width-5
                        height: 29
                        border.color: "#0797bd"
                        border.width: 2
                        radius: 5
                        clip: true

                        color: labelAction==0 ? (!checkBox.checked ? "#c1e4fd" : "#6cabd7") : (!checkBox.checked ? "#c1e4fd" : "#693FFD")

                        Text{
                            width: 175
                            text : labelAction==0 ? (!checkBox.checked ? urlText : urlText+etiqueta) : (!checkBox.checked ? urlText : urlText.replace(etiqueta,''))
                            //text: urlText
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
                            font.pointSize: 4
                            checkable: true
                            checkState: Qt.Unchecked
                            checked: selectAll==true ? true : isChecked

                            anchors.right: parent.right
                            anchors.top: parent.top
                            anchors.bottom: parent.bottom
                            anchors.rightMargin: 8

                            anchors.bottomMargin: 6
                            anchors.topMargin: 6
                            indicator.width: 20
                            indicator.height: 20
                            onClicked: {
                                isChecked = this.checked
                                updateCheckBoxValues()

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

/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:0.9;height:480;width:640}
}
##^##*/
