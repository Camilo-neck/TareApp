import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtGraphicalEffects 1.0

BusyIndicator {
    id: busyIndicator
    anchors.centerIn: parent
    implicitWidth: 96
    implicitHeight: 96
    running: false
    property var timerFunction : () => {}
    property var mainColor: '#006325'
    property var secondaryColor: '#80c342'

    function start(){
        busyIndicator.running = true
        funcTimer.start()
    }

    Timer {
        id: funcTimer
        interval: 1
        onTriggered: {
            timerFunction()
            busyIndicator.running = false
        }
    }

    contentItem: Item {
            implicitWidth: 64
            implicitHeight: 64

            Item {
                id: item
                x: parent.width / 2 - 32
                y: parent.height / 2 - 32
                width: 64
                height: 64
                opacity: busyIndicator.running ? 1 : 0

                Rectangle {
                    id: rect
                    width: parent.width
                    height: parent.height
                    color: Qt.rgba(0, 0, 0, 0) //color
                    radius: width / 2 //roundness
                    border.width: width / 6 //Border width
                    visible: false
                }


                Behavior on opacity {
                    OpacityAnimator {
                        duration: 250
                    }
                }

                RotationAnimator {
                    target: item
                    running: busyIndicator.visible && busyIndicator.running
                    from: 0
                    to: 360
                    loops: Animation.Infinite
                    duration: 1250
                }

                Repeater {
                    id: repeater
                    model: 1
                    ConicalGradient {//Gradient color module
                        width: rect.width
                        height: rect.height
                            gradient: Gradient {
                                GradientStop { position: 0.0; color: secondaryColor }
                                GradientStop { position: 1.0; color: mainColor }
                            }
                        source: rect

                        Rectangle {
                            x: item.width / 2 - width / 2
                            y: item.height / 2 - height / 2
                            implicitWidth: 10
                            implicitHeight: 10
                            radius: 5
                            color: mainColor
                            transform: [
                                Translate {
                                    y: -Math.min(item.width, item.height) * 0.5 + 5
                                },
                                Rotation {
                                    angle: index / repeater.count * 360
                                    origin.x: 5
                                    origin.y: 5
                                }
                            ]
                        }
                    }
                }
            }
        }
}
