import QtQuick 2.15
import QtQuick.Controls

Rectangle {
    width: 200
    height: 100
    color: "lightblue"

    Text {
        anchors.centerIn: parent
        text: "Hello, QML!"
        font.pointSize: 24
        color: "white"
    }
}
