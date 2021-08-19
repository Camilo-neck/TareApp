import QtQuick 2.7
import QtQuick.Controls 2.15

TabBar {
    id: bar
    property var repeaterModel: []
    property var itemColor: 'white'
    property var barStyle: 0
    property var radio: 0
    background: {color: itemColor}

    Repeater {
        model: repeaterModel

        TabButton {
            width: barStyle==0 ?  Math.max(100, bar.width / modelData.length) : (bar.currentIndex===index ? (itemText.text.length*itemText.font.pointSize) +tabBtnImg.width +10 : tabBtnImg.width +10)
            //width: bar.currentIndex===index ? 200 : 50
            contentItem:
                Text{
                    id: itemText
                    color: bar.currentIndex===index ? 'black' : 'white'
                    text: modelData["text"]
                    anchors.left: parent.left
                    anchors.leftMargin: tabBtnImg.width+15
                    verticalAlignment: Text.AlignVCenter
                    font.pointSize: 10.5
                    font.bold: true
                    visible: barStyle==0 ? true : (bar.currentIndex===index ? true : false)
                }

            background: Rectangle {
                height: bar.height
                color: bar.currentIndex===index ? itemColor : '#0998e9'
                radius: radio
                Image {
                    id: tabBtnImg
                    width: bar.height-5
                    height: bar.height-5
                    source: modelData["imgSource"]
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                }
            }


        }


    }
    //background: bg.color
}
