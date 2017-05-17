import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.1
import QtPositioning 5.8
import QtLocation 5.8
import ATeam.Phileas.AssetsSingleton 1.0
import "./components"
import Qt.labs.settings 1.0


ApplicationWindow {
    id:mainApp
    visible: true
    //width: 640
    //height: 960
    title: qsTr("Phileas")

    Component.onCompleted: {
        Assets.demoMode = Qt.platform.os == "osx"
    }

    Settings{
        property alias circonscriptionSelected : lstCirco.currentIndex
    }


    header:ToolBar{
        id:headerTb
        background: Rectangle {
            implicitHeight: 40
            color: Assets.ui.fondBandeauTitre

            Rectangle {
                width: parent.width
                height: 1
                anchors.bottom: parent.bottom
                color: "transparent"
                border.color: "white"
            }
        }
        RowLayout{
            anchors.fill: parent

            ATButtonText {
                height: parent.height
                width: height
                fontFamily: Assets.fonts.awesome.name
                //text:"\uf0c9" //fa-align-justify
                text:"\uf0f0" //fa-align-justify
                onClicked: drawer.open()
                //color:Assets.ui.fondBandeauTitre

            }
            ComboBox{
                id:lstCirco
                model:sqlCircoModel
                textRole:"label"
                currentIndex: 0
                font:Assets.fonts.montserrat.name
                Layout.fillWidth: true
                onCurrentIndexChanged: sqlCircoModel.selectedRow = currentIndex;
                //displayText:currentText + " circonscription"

                delegate: ItemDelegate {
                    width: lstCirco.width
                    contentItem: Text {
                        text: label
                        color: Assets.ui.fondBandeauTitre
                        font: lstCirco.font
                        elide: Text.ElideRight
                        verticalAlignment: Text.AlignVCenter
                    }
                    highlighted: lstCirco.highlightedIndex == index
                }
                contentItem: Text {
                    leftPadding: 0
                    rightPadding: lstCirco.indicator.width + lstCirco.spacing

                    text: lstCirco.displayText
                    font: lstCirco.font
                    color: "white"
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                    elide: Text.ElideRight
                }
                background: Rectangle {
                    implicitWidth: 120
                    implicitHeight: 40
                    color:"transparent"
                    border.color: "white"
                    border.width: 0//lstCirco.visualFocus ? 2 : 1
                    radius: 2
                }


            }
            ATButtonText {
                height: parent.height
                width: 3*height
                fontFamily: Assets.fonts.montserrat.name
                text:Assets.demoMode ? "Mode: Test" : "Mode: GPS"
                onClicked: Assets.demoMode =!Assets.demoMode
            }
        }
    }

    Drawer{
        id:drawer
        y : headerTb.height
        height : parent.height -headerTb.height
        width:parent.width*4/5

        background: Rectangle{
            color:Assets.ui.fondDrawer
        }

            ATButtonText {
                id:closeDrawer
                height: 50
                width: height
                anchors.right:parent.right
                fontFamily: Assets.fonts.awesome.name
                text:"\uf057"
                onClicked: drawer.close()

            }

            FicheCandidats{
                width:parent.width
                height:parent.height - 55
                anchors.bottom : parent.bottom
            }

    }


    StackView{
        id:stack
        anchors.fill: parent
        initialItem: PhileasMap{
            demo : Assets.demoMode
        }

        Connections{
            target:stack.currentItem
            ignoreUnknownSignals: true
            onEndPOI:{
                stack.replace("qrc:/PhileasMap.qml", {"demo" : Assets.demoMode })
            }
            onStartPOI: {
                stack.replace("qrc:/PhileasPOI.qml", {"poiId":poiID})
            }
        }
    }

    Splash {
        width:mainApp.width
        height:mainApp.overlay.height
    }






}
