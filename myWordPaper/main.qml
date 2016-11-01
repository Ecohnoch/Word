import QtQuick 2.7
import QtQuick.Controls 1.4
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.1
import QtQuick.Window 2.2
import QtMultimedia 5.4
import File 1.0

ApplicationWindow {
    id: mainWindow
    visible: true
    width: 320
    height: 350
    title: qsTr("Ecohnoch's Word Memory")
    color: systemPalette.window
    property int textNum: 1
    property int num: 15
    property bool clear: false
    property string musicPath: "music/yonghengdeyishun.mp3"

    FontLoader{id: uiFont; source: "font/liberationmono.ttf"}
    SystemPalette{id: systemPalette}
    Image{
        id: background
        anchors.fill: parent
        source: "ui/bg.jpg"
    }

    WordGo{
        anchors.fill: parent
    }

    menuBar: MenuBar{
        Menu{
            title: "添加单词"
            MenuItem{text: "添加单个单词"; onTriggered: {addWindow.show()}}
            MenuItem{text: "批量添加（待完成）"; onTriggered: {}}
        }
        Menu{
            title: "数据"
            MenuItem{text: "查看并修改所有数据"; onTriggered: {allWindow.show()}}
        }
        Menu{
            title: "音乐"
            MenuItem{text: "暂停音乐"; onTriggered: {bgm.stop()}}
            MenuItem{text: "播放默认音乐"; onTriggered: {bgm.play()}}
            MenuItem{text: "选择音乐播放"; onTriggered: {fileDialog.open(); }}
        }
        Menu{
            title: "帮助"
            MenuItem{text: "帮助"; onTriggered: {helpyouWindow.show()}}
            MenuItem{text: "关于作者"; onTriggered: {helpWindow.show()}}
        }
    }

    FileDialog {
        id: fileDialog
        modality: Qt.ApplicationModal
        title: "Please choose a file"
        nameFilters: [ "Music files (*.mp3)" ]
        onAccepted: {
            bgm.source = fileDialog.fileUrl
        }
    }



    Window{
        id: addWindow
        width: 300; height: 350
        color: systemPalette.window
        property var addTable: ["", "", "", "", "", ""]
        Column{
            x: 0; y: 20
            width: 300; height: 270
            spacing: 20
            WordAddItem{text: "word:"}
            WordAddItem{text: "answer A"}
            WordAddItem{text: "answer B"}
            WordAddItem{text: "answer C"}
            WordAddItem{text: "answer D"}
            WordAddItem{text: "correct Answer"}
        }
        Image{
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            width: 50; height: 50
            source: "ui/check50.png"
            MouseArea{
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    console.log(addWindow.addTable)
                    var defaultData
                    if(File.exist(File.dataPath('data.json'))){
                        defaultData = File.read(File.dataPath('data.json'))
                    }else{
                        defaultData = File.read(":/wordData.json")
                    }
                    defaultData = defaultData.substring(0, defaultData.length - 4)
                    defaultData = defaultData + ","
                    var data = defaultData + "\n    \"" + num + "\"" + ":{\n        \"eng\"" + ":\"" + num + ":  " + addWindow.addTable[0] + "\",\n        \"la\" : \"" + addWindow.addTable[1] + "\",\n        \"lb\" : \"" + addWindow.addTable[2] + "\",\n        \"lc\" : \"" + addWindow.addTable[3] + "\",\n        \"ld\" : \"" + addWindow.addTable[4] + "\",\n        \"ans\" : \"" + addWindow.addTable[5] + "\"\n    " + "}\n"
                    data = data + "\n\n}"
                    num++

                    console.log(File.write(File.dataPath('data.json'), data))
                    var test = JSON.parse(File.read(File.dataPath('data.json')))
                    console.log("json: ",test[num - 1])
                    allWindow.text = data
                    sucLabel.added()
                }
            }
        }
        Text{
            id: sucLabel
            anchors.right: parent.right
            anchors.rightMargin: 5
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 5
            font.family: uiFont.name
            text: "Added!"
            opacity: 0
            NumberAnimation on opacity{
                id: maskIn; duration: 750
                to: 1; running: false
                easing.type: Easing.InOutQuad
                onStopped: {maskOut.restart()}
            }
            NumberAnimation on opacity{
                id: maskOut; duration: 600
                to: 0; running: false
                easing.type: Easing.InOutQuad
            }
            function added(){
                maskIn.restart()
            }
        }


    }

    ApplicationWindow{
        id: allWindow
        width: 300; height: 350
        color: systemPalette.window
        property string text: File.exist(File.dataPath('data.json')) ? File.read(File.dataPath('data.json')) : File.read(":/wordData.json")
        menuBar:MenuBar{
            Menu{
                title: "编辑"
                MenuItem{
                    text: "保存"
                    onTriggered: {}
                }
                MenuItem{
                    text: "恢复为默认数据（慎重）"
                    onTriggered: {
                        File.write(File.dataPath('data.json'), File.read(':/wordData.json'))
                        textArea.focus = false
                        allWindow.text = File.read(':/wordData.json')
                        textArea.text = File.read(':/wordData.json')
                        allWindow.close()
                    }
                }
            }
        }

        TextArea {
            id: textArea
            anchors.fill: parent
            Layout.fillWidth: true
            Layout.fillHeight: true
            font.family: uiFont.name
            text: allWindow.text
            onTextChanged: {
                console.log("text: ", File.write(File.dataPath('data.json'), text))
            }
        }

    }

    Window{
        id: helpWindow
        title: "About The Author"
        width: 320; height: 240
        minimumWidth: 320; minimumHeight: 240
        modality: Qt.ApplicationModal
        color: systemPalette.window
        ScrollView{
            anchors.fill: parent
        }
        TextEdit{
            id: textEdit
            anchors.fill: parent
            anchors.margins: 10
            renderType: Text.NativeRendering
            textFormat: TextEdit.RichText
            wrapMode: TextEdit.Wrap
            readOnly: true
            selectByMouse: false
            onLinkActivated: Qt.openUrlExternally(link)
            text: "<b>" + Qt.application.name + "        version:" + Qt.application.version + "</b><br><br>
                  This is a Word App, you can load and test the English words<br>
                  My real name is chuyuan Xiong, you can call me Ecohnoch, this is my English name. <br>
                  If you want to see more things , you can goto <a href=\"https://www.github.com/ecohnoch\"> <br>
                  My Github Website."
            font.family: uiFont.name
            font.pixelSize: 13
            MouseArea{
                anchors.fill: parent
                cursorShape: textEdit.hoveredLink ? Qt.PointingHandCursor : Qt.ArrowCursor
                acceptedButtons: Qt.NoButton
            }
        }
    }

    Window{
       id: helpyouWindow
       title: "About The Author"
       width: 320; height: 280
       minimumWidth: 320; minimumHeight: 240
       modality: Qt.ApplicationModal
       color: systemPalette.window
       ScrollView{
           anchors.fill: parent
       }
       TextEdit{
           id: textEdit2
           anchors.fill: parent
           anchors.margins: 10
           renderType: Text.NativeRendering
           textFormat: TextEdit.RichText
           wrapMode: TextEdit.Wrap
           readOnly: true
           selectByMouse: false
           onLinkActivated: Qt.openUrlExternally(link)
           text: "<b>" + Qt.application.name + "        version:" + Qt.application.version + "</b><br><br>
                这是由岐山凤鸣(Ecohnoch)开发的一款背单词软件。<br>
                1. 安装完成后请打开startWord开始背单词..<br>
                2. 您可以单击Add菜单来进行添加单词<br>
                3. 您也可以单击All菜单获得目前导入的所有单词，注意，请只修改冒号之后，双引号之内的文本，不要破坏文件的格式<br>
                4. 如果您破坏了文本的格式导致无法使用，请重新复制正确的格式进行导入，正确的格式在www.github.com/ecohnoch/word中的wordData.json之中<br>
                5. 建议您导入大量单词后能保存到单独的一个文本文件中，防止出现错误。
                6. 欢迎使用本软件<br>
                    by Ecohnoch;<br>
           "
           font.family: uiFont.name
           font.pixelSize: 13
           MouseArea{
               anchors.fill: parent
               cursorShape: textEdit2.hoveredLink ? Qt.PointingHandCursor : Qt.ArrowCursor
               acceptedButtons: Qt.NoButton
           }
       }

    }

    MediaPlayer{
       id: bgm; volume: 0.5; loops: Audio.Infinite; autoPlay:true
       source: musicPath
    }
}
