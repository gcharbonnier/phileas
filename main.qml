import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import QtPositioning 5.8
import QtLocation 5.8
import ATeam.Phileas.AssetsSingleton 1.0



ApplicationWindow {
    id:mainApp
    visible: true
    width: 640
    height: 480
    title: qsTr("Phileas")

    property bool demo : Qt.platform.os == "osx"

    StackView{
        id:stack
        anchors.fill: parent
        initialItem: PhileasMap{
            demo : mainApp.demo
        }

        Connections{
            target:stack.currentItem
            ignoreUnknownSignals: true
            onEndPOI:{
                stack.replace("qrc:/PhileasMap.qml", {"demo" : mainApp.demo })
            }
            onStartPOI: {
               stack.replace("qrc:/PhileasPOI.qml", {"poiId":poiID})
            }
        }
    }






}
