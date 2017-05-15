import QtQuick 2.0
import QtMultimedia 5.0
import Qt.labs.settings 1.0

pragma Singleton

Item {
    property var ui:ui
    property var sounds:sounds
    property var fonts:fonts
    property bool demoMode : true


    Item{
        id:fonts
        property FontLoader awesome: FontLoader{ source: "qrc:/res/fonts/fontawesome-webfont.ttf" }
        property FontLoader defaultFont: FontLoader{ source: "qrc:/res/fonts/Arista2.0.ttf" }

        property FontLoader robotslab: FontLoader{ source: "qrc:/res/fonts/RobotoSlab-Regular.ttf" }
        property FontLoader montserrat: FontLoader{ source: "qrc:/res/fonts/Montserrat-Regular.ttf" }
        property FontLoader courgette: FontLoader{ source: "qrc:/res/fonts/Courgette-Regular.ttf" }


    }

    Item{
        id:ui
        property color rougeorange : "#C9462C"
        property color rougevif : "#E23D22"
        property color bleuciel : "#0098B6"
        property color bleuvif : "#23B9D0"
        property color bleumarine : "#1F3356"


        property color zoomcarte : bleuciel
        property color fondPOI : bleuvif
        property color fondDrawer : bleuvif
        property color fondBandeauTitre : bleuciel
        property color buttonTextcolor : "white"
        property color textcolor : bleumarine



        property color buttonColor : "#44FF55"
        property color buttonBkColor : "black"
        property color drawerTextcolor : "black"
        property color buttonBkColorDisabled : "darkgrey"
        property real buttonBkOpacity:0.8
        property int defaultWidth:30
        property int defaultHeight:200
        property int buttonMargin:3
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
        property var detectedPOI:detectedPOI

        SoundEffect {
            id: detectedPOI
            source: "qrc:/res/audio/scanQrOk.wav"
        }
    }




}




