import QtQuick 2.0
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.11
import QtQml.Models 2.2
import "../controls"
import "../pages"

Item {

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

                DelegateModel {
                    id: visualModel
                    model: timelineModel
                    delegate: timelineDelegate
                }

                Component {
                    id: timelineDelegate


                    Rectangle {
                        property var rowColors: ["#55bfee","#138cc1"]

                        id: content4
                        x: -30
                        y: 8
                        height: 57
                        color: "#c1e4fd"
                        radius: 5
                        border.color: "#0797bd"
                        border.width: 2
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.rightMargin: 8
                        anchors.leftMargin: 8

                        GridLayout {
                            anchors.fill: parent
                            anchors.topMargin: 8
                            rows: 1
                            anchors.rightMargin: 10
                            anchors.leftMargin: 8
                            anchors.bottomMargin: 8
                            columns: 4

                            Rectangle {
                                id: rectangle
                                width: 200
                                height: 200
                                //color: "#5dc9ef"
                                color: index%2 === 0 ? rowColors[0] : rowColors[1]
                                radius: 5
                                Layout.preferredWidth: 80
                                Layout.fillHeight: true
                                Layout.fillWidth: false
                                Text {
                                    text: format
                                    anchors.fill: parent
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                    font.pointSize: 15
                                    color: 'white'
                                    font.bold: true

                                }
                            }

                            Rectangle {
                                id: rectangle1
                                width: 200
                                height: 200
                                //color: "#5dc9ef"
                                color: index%2 === 0 ? rowColors[0] : rowColors[1]
                                radius: 5
                                Layout.fillHeight: true
                                Layout.fillWidth: true
                                Text {
                                    text: desc
                                    anchors.fill: parent
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                    font.pointSize: 15
                                    color: 'white'
                                }
                            }

                            Rectangle {
                                id: rectangle2
                                width: 200
                                height: 200
                                //color: "#5dc9ef"
                                color: index%2 === 0 ? rowColors[0] : rowColors[1]
                                radius: 5
                                Layout.preferredWidth: 110
                                Layout.fillHeight: true
                                Layout.fillWidth: true
                                Text {
                                    text: example
                                    anchors.fill: parent
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                    font.pointSize: 15
                                    color: 'white'
                                }
                            }
                        }
                    }
                }

                ListModel {
                    id: timelineModel
                    //here goes the listElements that defines the rectangles

                     ListElement {format: "%a"; desc: "Weekday, short version"; example: "Wed"}
                     ListElement {format: "%A"; desc: "Weekday, full version"; example: "Wednesday"}
                     ListElement {format: "%w"; desc: "Weekday as a number 0-6, 0 is Sunday"; example: "3"}
                     ListElement {format: "%d"; desc: "Day of month 01-31"; example: "31"}
                     ListElement {format: "%b"; desc: "Month name, short version"; example: "Dec"}
                     ListElement {format: "%B"; desc: "Month name, full version"; example: "December"}
                     ListElement {format: "%m"; desc: "Month as a number 01-12"; example: "12"}
                     ListElement {format: "%y"; desc: "Year, short version, without century"; example: "18"}
                     ListElement {format: "%Y"; desc: "Year, full version"; example: "2018"}
                     ListElement {format: "%H"; desc: "Hour 00-23"; example: "17"}
                     ListElement {format: "%I"; desc: "Hour 00-12"; example: "05"}
                     ListElement {format: "%p"; desc: "AM/PM"; example: "PM"}
                     ListElement {format: "%M"; desc: "Minute 00-59"; example: "41"}
                     ListElement {format: "%S"; desc: "Second 00-59"; example: "08"}
                     ListElement {format: "%f"; desc: "Microsecond 000000-999999"; example: "548513"}
                     ListElement {format: "%z"; desc: "UTC offset"; example: "+0100"}
                     ListElement {format: "%Z"; desc: "Timezone"; example: "CST"}
                     ListElement {format: "%j"; desc: "Day number of year 001-366"; example: "365"}
                     ListElement {format: "%U"; desc: "Week number of year, Sunday as the first day of week, 00-53"; example: "52"}
                     ListElement {format: "%W"; desc: "Week number of year, Monday as the first day of week, 00-53"; example: "52"}
                     ListElement {format: "%c"; desc: "Local version of date and time"; example: "Mon Dec 31 17:41:00 2018"}
                     ListElement {format: "%x"; desc: "Local version of date"; example: "12/31/18"}
                     ListElement {format: "%X"; desc: "Local version of time"; example: "17:41:00"}
                     ListElement {format: "%%"; desc: "A % character"; example: "%"}
                     ListElement {format: "%G"; desc: "ISO 8601 year"; example: "2018"}
                     ListElement {format: "%u"; desc: "ISO 8601 weekday (1-7)"; example: "1"}
                     ListElement {format: "%V"; desc: "ISO 8601 weeknumber (01-53)"; example: "01"}


                }
            }
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
