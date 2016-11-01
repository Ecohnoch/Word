import QtQuick 2.7
import QtQuick.Controls 1.4

Item {
    id: addItem
    property string text
    width: 200; height: 30
    Label{
        id: label
        width: 100; height: 30
        anchors.left: parent.left
        anchors.leftMargin: 10
        text: parent.text
        font.pixelSize: 15
        font.family: uiFont.name
    }

    TextField{
        id: field
        width: 100
        x: label.x + label.width + 30
        onTextChanged: {
            if(addItem.text == "word:"){
                addWindow.addTable[0] = field.text
            }else if(addItem.text == "answer A"){
                addWindow.addTable[1] = field.text
            }else if(addItem.text == "answer B"){
                addWindow.addTable[2] = field.text
            }else if(addItem.text == "answer C"){
                addWindow.addTable[3] = field.text
            }else if(addItem.text == "answer D"){
                addWindow.addTable[4] = field.text
            }else if(addItem.text == "correct Answer"){
                addWindow.addTable[5] = field.text
            }else{
                console.log("*** Add Item Error")
            }
        }
    }
}
