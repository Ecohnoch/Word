import QtQuick 2.7
import File 1.0

Item {
    //property var data: JSON.parse(File.read(":/wordData.json"))
    id: go
    WordView{
        id: view
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.horizontalCenter: parent.horizontalCenter
        myText: "1:  exclusive"
    }
    WordLabel{
        id: labelA
        anchors.top: view.bottom
        anchors.topMargin: 20
        x: view.x + 10
        myText: "专用的"
    }
    WordLabel{
        id: labelB
        anchors.top: labelA.bottom
        anchors.topMargin: 40
        x: labelA.x
        myText: "专有的"
    }
    WordLabel{
        id: labelC
        anchors.top: labelB.bottom
        anchors.topMargin: 40
        x: labelA.x
        myText: "专家的"
    }
    WordLabel{
        id: labelD
        anchors.top: labelC.bottom
        anchors.topMargin: 40
        x: labelA.x
        myText: "专长的"
    }

    Image{
        id: checkBtn
        width: 50; height: 50
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: preBtn.top
        source: "ui/check50.png"
        MouseArea{
            anchors.fill: parent
            onClicked: checkClicked()
            cursorShape: Qt.PointingHandCursor
        }
    }

    Image{
        id: nextBtn
        width: 50; height: 50
        anchors.right: view.right
        anchors.rightMargin: 5
        anchors.top: preBtn.top
        source: "ui/right168.png"
        MouseArea{
            anchors.fill: parent
            onClicked: nextClicked()
            cursorShape: Qt.PointingHandCursor
        }
    }

    Image{
        id: preBtn
        width: 50; height: 50
        anchors.left: view.left
        anchors.leftMargin: 5
        anchors.top: labelD.bottom
        anchors.topMargin: 30
        source: "ui/left174.png"
        MouseArea{
            anchors.fill: parent
            onClicked: preClicked()
            cursorShape: Qt.PointingHandCursor
        }
    }



    Text{
        id: copyRight
        text: "This is powered by Ecohnoch!(XCY)"
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        anchors.horizontalCenter: view.horizontalCenter
        font.pixelSize: 15
        font.family: uiFont.name
    }

    function nextClicked(){
        var data = JSON.parse(File.read(":/wordData.json"))
        textNum ++
        if(!data || !data[textNum]){
            textNum = 1
            console.log("***Json read Error!")
            return
        }
        clear = true
        checkOnlyOne(true, true)
        view.myText = data[textNum].eng
        labelA.visible = true
        labelA.rightHide()
        labelA.myText = data[textNum].la
        labelB.visible = true
        labelB.rightHide()
        labelB.myText = data[textNum].lb
        labelC.visible = true
        labelC.rightHide()
        labelC.myText = data[textNum].lc
        labelD.visible = true
        labelD.rightHide()
        labelD.myText = data[textNum].ld
        clear = false
    }

    function preClicked(){
        var data = JSON.parse(File.read(":/wordData.json"))
        textNum --
        if(!data || !data[textNum]){
            console.log("***Json read Error!")
            return
        }
        clear = true
        checkOnlyOne(true, true)
        view.myText = data[textNum].eng
        labelA.visible = true
        labelA.myText = data[textNum].la
        labelB.visible = true
        labelB.myText = data[textNum].lb
        labelC.visible = true
        labelC.myText = data[textNum].lc
        labelD.visible = true
        labelD.myText = data[textNum].ld
        clear = false
    }

    function checkClicked(){
        var data = JSON.parse(File.read(":/wordData.json"))
        if(!data[textNum] || !data){
            console.log("***Error to get the ans, maybe check the json")
            return
        }
        var ans = data[textNum].ans
        if(ans === 'a'){
            labelA.rightShow()
            labelB.visible = false
            labelC.visible = false
            labelD.visible = false
        }else if(ans === 'b'){
            labelB.rightShow()
            labelA.visible = false
            labelC.visible = false
            labelD.visible = false
        }else if(ans === 'c'){
            labelC.rightShow()
            labelA.visible = false
            labelB.visible = false
            labelD.visible = false
        }else if(ans === 'd'){
            labelD.rightShow()
            labelA.visible = false
            labelB.visible = false
            labelC.visible = false
        }else console.log("***Error with the ans")
    }
    function getLabel(i){
        if(i === 1) return labelA
        else if(i === 2) return labelB
        else if(i === 3) return labelC
        else if(i === 4) return labelD
        else console.log("***Get Label Wrong.")
    }

    function checkOnlyOne(all, clear){
        if(!clear){
            labelA.enabled = all
            labelB.enabled = all
            labelC.enabled = all
            labelD.enabled = all
        }else{
            labelA.enabled = true
            labelA.getChecked().checked = false
            labelB.enabled = true
            labelB.getChecked().checked = false
            labelC.enabled = true
            labelC.getChecked().checked = false
            labelD.enabled = true
            labelD.getChecked().checked = false
        }
    }
}
