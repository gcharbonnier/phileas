import QtQuick 2.0
import QtQuick.Window 2.1
import QtQuick.Controls 2.0
import ATeam.Phileas.AssetsSingleton 1.0
import "./components"

Rectangle {
    id: splash
    color:"black"



    Behavior on opacity{
        NumberAnimation { duration: 1000 }
    }

    property int timeoutInterval: 2000
    signal timeout

    visible:opacity!=0
    width: 300
    height: 300

    ATButtonText {
        id:closeDrawer
        height: 50
        width: height
        anchors.right:parent.right
        fontFamily: Assets.fonts.awesome.name
        text:"\uf057"
        onClicked: splash.opacity = 0

    }

    SwipeView{
        id:view
        clip: true
        width:parent.width * 0.8
        height:parent.height * 0.8
        anchors.centerIn: parent
        Image {
            id: splashImage
            source: "qrc:/res/splash.jpg"
            fillMode: Image.PreserveAspectFit

        }
        Label{
            width:view.width
            color:"white"
            wrapMode:Text.WordWrap
            text : "<p><h1>Avertissement</h1>
                   Pendant la phase de test, plutot que de se déplacer vers un point d'intéret (pour le moment, il n'y en a que 4 au sud de Nantes, vous pouvez activer le mode Test en haut à droite (en mode normal, il indique GPS). <br>
                   <br>Dans ce mode de test :<br>
                   <ul>
                       <li>La carte devrait se positionner à l'endroit des point d'intérets de tests
                       <li>La carte ne réagit plus au gesture Pan/swipe etc...on ne peut zoomer/dezoomer qu'avec les boutons
                       <li>il faut double-cliquer pour simuler un déplacement à l'endroit du clic
                   </ul>
                   <br>A terme, le bouton Test disparaitra !</p>"
        }
    }

    ATButtonText {
        height: 100
        width: 100
        anchors.bottom:parent.bottom
        anchors.right:parent.right
        anchors.bottomMargin: 25
        fontFamily: Assets.fonts.awesome.name
        text:"\uf061" //fa-align-justify
        visible: view.currentIndex < (view.count-1)
        onClicked: view.currentIndex++
        //color:Assets.ui.fondBandeauTitre

    }

    ATButtonText {
        height: 100
        width: 100
        anchors.bottom:parent.bottom
        anchors.bottomMargin: 25
        anchors.left:parent.left
        fontFamily: Assets.fonts.awesome.name
        text:"\uf060" //fa-align-justify
        visible: view.currentIndex > 0
        onClicked: view.currentIndex--
        //color:Assets.ui.fondBandeauTitre

    }

}
