import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    width: 640
    height: 480
    color: "lightblue"

    signal buttonClicked()

    Button {
        id: myButton
        text: "Click Me"
        anchors.centerIn: parent
        onClicked: {
            myButton.text = "Clicked!"
            buttonClicked()
            dialog.visible = true
        }
    }



    Dialog {
           id: dialog
           title: "Modal Dialog"
           standardButtons: Dialog.Ok | Dialog.Cancel
           visible: false
           modal:true
           onAccepted: {
               myButton.text = "Accepted"
           }

           onRejected: {
               myButton.text = "Rejected"
           }

           contentItem: Text {
               text: "This is a modal dialog."
               anchors.centerIn: parent
           }
       }
}


