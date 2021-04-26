import QtQuick 2.15
import QtQuick.Controls 2.15

TextField {
    id: textField


    placeholderText: qsTr("Type Something Here")
    color: "#ffffff"
    implicitWidth: 300
    implicitHeight: 40
    background: Rectangle {
        color: "#1d2129"
        anchors.fill: parent
        radius: 10
    }

    selectByMouse: true
    selectedTextColor: "#FFFFFF"
    selectionColor: "#ff007f"
    placeholderTextColor: "#c3d3e1"
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:70;width:400}
}
##^##*/
