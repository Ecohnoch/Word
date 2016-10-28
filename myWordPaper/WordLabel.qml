import QtQuick 2.7
import QtQuick.Controls 1.4

Item {
    id: label
    property string myColor: "#FFECF5"
    property string myText: "测试一下中文"
    property bool checked: true

    FontLoader{id: chineseFont; source: "font/Hiragino Sans GB W3.otf"}
    CheckBox{
        id: check
        width: 20; height: 20
        onCheckedChanged:{
            label.checked = check.checked
            if(checked && !clear) go.checkOnlyOne(false)
            else if(clear){
                go.checkOnlyOne(true, true)
                check.checked = false
            }
            else go.checkOnlyOne(true, false)
            console.log("check the memory!")
            label.enabled = true
        }
    }
    Image{
        id: right
        width: 30; height: 30
        anchors.horizontalCenter: check.horizontalCenter
        anchors.verticalCenter:  check.verticalCenter
        visible: false

        source: "ui/check_mark.png"
    }

    Rectangle{
        id: rect
        x: check.x + check.width + 20;
        height: 30; width: 250
        anchors.verticalCenter: check.verticalCenter
        color: parent.myColor
        opacity: 0.6
        Text{
            id: chinese
            anchors.centerIn: parent
            text: label.myText
            color: "#000000"
            font.family: chineseFont.name
            font.pixelSize: 15
        }
    }

    function getChecked(){
        return check
    }
    function rightShow(){
        right.visible = true
    }
    function rightHide(){
        right.visible = false
    }
}
