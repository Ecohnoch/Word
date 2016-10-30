import QtQuick 2.7
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1
import QtQuick.Window 2.2
import File 1.0

ApplicationWindow {
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

    menuBar: MenuBar{
        Menu{
            title: "Add"
            MenuItem{text: "Add single word"; onTriggered: {addWindow.show()}}
        }
    }

    Window{
        id: addWindow
        width: 300; height: 350
        color: systemPalette.window
        property var addTable: ["", "", "", "", "", ""]
        Column{
            x: 0; y: 0
            width: 300; height: 270
            spacing: 20
            WordAddItem{text: "word:"}
            WordAddItem{text: "answer A"}
            WordAddItem{text: "answer B"}
            WordAddItem{text: "answer C"}
            WordAddItem{text: "answer D"}
            WordAddItem{text: "correct Answer"}
        }
        Button{
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            width: 50; height: 50
            text: "Sure"
            onClicked: {
                console.log(addWindow.addTable)
                var data = "{}"
                console.log(File.write(":/wordData2.txt", data))
            }
        }

    }
}
