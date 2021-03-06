import QtQuick 2.0
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.11

Item {
    // PROPERTIES
    property string getText: textArea.text
    property string setText: ""

    Rectangle {
        id: bg
        color: "#89c2db"
        anchors.fill: parent
        Rectangle {
            id: content
            color: "#ffffff"
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.rightMargin: 10
            anchors.leftMargin: 10
            anchors.bottomMargin: 10
            anchors.topMargin: 10
            radius: 10
            border.width: 1
            Flickable {
                id: flickable
                anchors.fill: parent
                clip: true

                TextArea.flickable: TextArea {
                    id: textArea
                    padding: 10
                    wrapMode: Text.WordWrap
                    font.family: "Sans Serif"
                    placeholderTextColor: "#000000"
                    textFormat: Text.AutoText
                    selectByMouse: true
                    selectedTextColor: "#ffffff"
                    selectionColor: "#ff007f"
                    color: "#000000"
                    font.pointSize: 14
                    text: setText
                }

                ScrollBar.vertical: ScrollBar{}
        }
        }
    }

}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:800}
}
##^##*/
