import QtQuick 2.0
import QtMultimedia 5.0
import Qt.labs.settings 1.0

pragma Singleton

Item {
    property var ui:ui
    property var sounds:sounds
    property var fonts:fonts
    property var models:models

    Item{
        id:models

        property ListModel lstPOI :ListModel{
            ListElement{
                latitude:47.099180
                longitude:-1.636729
                poiID:0
            }
            ListElement{
                latitude:47.096700
                longitude:-1.635230
                poiID:1
            }

            ListElement{
                latitude:47.095500
                longitude:-1.637110
                poiID:2
            }
            ListElement{
                latitude:47.096900
                longitude:-1.638970
                poiID:3

            }
        }

    }



    Item{
        id:fonts
        property FontLoader awesome: FontLoader{ source: "qrc:/res/fonts/fontawesome-webfont.ttf" }
    }

    Item{
        id:ui
        property color buttonColor : "#44FF55"
        property int minimumPixelSize:6
        property int maximumPixelSize:250
        property Gradient backgradient: Gradient{
            GradientStop{ position: 0; color:"blue"}
            GradientStop{ position: 0.35; color:"darkblue"}
            GradientStop{ position: 1; color:"black"}
        }


    }
    Item{
        id:sounds
        property var scanQrOk:scanQrOk

        SoundEffect {
            id: scanQrOk
            source: "qrc:/res/audio/scanQrOk.wav"
        }
    }




}




