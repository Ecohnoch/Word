import QtQuick 2.7
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1
import QtQuick.Window 2.2
import File 1.0

Window {
    id: mainWindow
    visible: true
    width: 320
    height: 320
    title: qsTr("Ecohnoch's Word Memory")
    color: systemPalette.window
    property int textNum: 1
    property bool clear: false
    FontLoader{id: uiFont; source: "font/liberationmono.ttf"}
    SystemPalette{id: systemPalette}
    Image{
        id: background
        anchors.fill: parent
        source: "ui/bg.jpg"
    }

//    GridView{
//        id: wordView
//        property var wordTabel: ['a', 'b', 'c', 'd','e', 'f', 'g', 'h', 'i', 'j', 'k',
//                           'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z']
//        model: wordTabel
//        cellWidth: 40; cellHeight: 40

//        delegate: Rectangle{
//            width: 30; height: 30
//            color: "#00000000"
//            border.width: 5
//            border.color: "grey"
//            Text{
//                anchors.centerIn: parent
//                font.family: uiFont.name
//                font.pixelSize: 16

//                text: wordView.wordTabel[index]
//            }
//            MouseArea{
//                anchors.fill: parent
//                onClicked: {
//                    wordView.visible = false
//                }
//            }
//        }
//    }
    WordGo{
        anchors.fill: parent
    }


}
