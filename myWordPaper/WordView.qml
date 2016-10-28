import QtQuick 2.7

Rectangle {
    property string myText: "Text"
    width: 300; height: 50
    color: "#00000000"
    border.width: 3
    border.color: "grey"
    radius: 5
    Text{
        anchors.centerIn: parent
        text: parent.myText
        font.family: uiFont.name
        font.pixelSize: 17

    }

}
