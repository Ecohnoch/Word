import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.2

RowLayout {
    id: fileSelector

    property string path: ""
    property string folder//: fileDialog.shortcuts.pictures

    TextField {
        Layout.fillWidth: true
        height: button.height * 0.8
        Layout.alignment: Qt.AlignHCenter
        text: imageSelector.path
        readOnly: true
    }

    Button {
        id: button
        text: "Browse..."
        onClicked: {
            fileDialog.folder = imageSelector.folder
            fileDialog.open()
        }
    }

    FileDialog {
        id: fileDialog
        modality: Qt.ApplicationModal
        title: "Please choose a file"
        nameFilters: [ "Image files (*.jpg *.png *.gif *.mp3)" ]
        onAccepted: {
            imageSelector.folder = fileDialog.folder
            imageSelector.path = fileDialog.fileUrl
            console.log(imageSelector.path)
        }
    }
}
