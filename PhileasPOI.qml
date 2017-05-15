import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.1
import ATeam.Phileas.AssetsSingleton 1.0
import ATeam.BlobImage 1.0
import "./components"

Page {
    id:root
    property bool demo : false
    property int poiId : 0
    signal endPOI();

    background: Rectangle{
        id:fondPOI
        color:Assets.ui.fondPOI
    }

    states: [
        State {
            name: "INFO";
            PropertyChanges { target: info; height:root.height*0.8}
            PropertyChanges { target: poiImage; opacity:0.3 }
            PropertyChanges { target: fondPOI; color:"white" }

            PropertyChanges { target: buttonInfo; textColor:Assets.ui.fondPOI }
            PropertyChanges { target: buttonLAEC; visible:false }

        },
        State {
            name: "LAEC";
            PropertyChanges { target: laec; height:root.height*0.8}
            PropertyChanges { target: poiImage; opacity:0.3 }
            PropertyChanges { target: fondPOI; color:"white" }

            PropertyChanges { target: buttonLAEC; textColor:Assets.ui.fondPOI }
            PropertyChanges { target: buttonInfo; visible:false }

        }
    ]

    footer: ToolBar {
        background: Rectangle {
                  implicitHeight: 40
                  color: Assets.ui.fondBandeauTitre

                  Rectangle {
                      width: parent.width
                      height: 1
                      anchors.top: parent.top
                      color: "transparent"
                      border.color: "white"
                  }
              }
        RowLayout {
            anchors.fill: parent
            ATButtonText {
                height: parent.height
                width:height
                fontFamily: Assets.fonts.awesome.name
                text:"\uf177"
                onClicked: root.endPOI()
            }
            Label {
                text:sqlPoiModel.selectedData("label")
                elide: Label.ElideRight
                color:"white"
                font: Assets.fonts.montserrat.name
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
                Layout.fillWidth: true
            }


        }
    }




    BlobImage{
        id:poiImage
        anchors.fill: parent
        imageData: sqlPoiModel.selectedData("image")
        visible:true
        Behavior on opacity {
            NumberAnimation { duration: 1000 }
        }
    }

    Item {
        id: info
        //visible:false
        anchors.bottom: parent.bottom
        width:parent.width
        height:0//parent.height * 0.8
        Behavior on height {
            NumberAnimation { duration: 1000 ; easing.type:Easing.InOutElastic}
        }
        BlobImage{
            width:parent.width /3
            height:parent.height
            //fillMode: Image.PreserveAspectFit
            imageData: sqlCircoModel.selectedData("titulaire_image2")
            visible:true
        }
        Flickable{
            width:parent.width * 2/3
            height:parent.height
            anchors.right:parent.right
            contentWidth: width
            contentHeight: infoLabel.height
            clip: true
            Label{
                id:infoLabel
                width:info.width * 2/3
                text:sqlPoiModel.selectedData("description")
                font: Assets.fonts.robotslab.name
                wrapMode: Label.WordWrap
            }
        }
    }

    Item {
        id: laec
        //visible:false
        anchors.bottom: parent.bottom
        width:parent.width
        height:0
        Behavior on height {
            NumberAnimation { duration: 1000 ; easing.type:Easing.InOutElastic}
        }
        Flickable{
            width:parent.width *2/3
            height:parent.height
            contentWidth: width
            contentHeight: laecLabel.height
            clip: true
            Label{
                id:laecLabel
                width:parent.width
                text:sqlPoiModel.selectedData("laec")
                font: Assets.fonts.robotslab.name
                wrapMode: Label.WordWrap
            }
        }

        Image{
            width:parent.width /3
            height:parent.height
            anchors.right:parent.right
            visible:!supImage.imageData
            fillMode: Image.PreserveAspectFit
            source: "qrc:/res/tmp/candidate.png"
        }
        BlobImage{
            id:supImage
            width:parent.width /3
            height:parent.height
            anchors.right:parent.right
            visible:true
            imageData: sqlCircoModel.selectedData("suppleant_image2")
        }
    }


    ATButtonText{
        id:buttonInfo
        height:50
        width:height
        visible:infoLabel.text != ""
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        fontFamily:Assets.fonts.awesome.name
        text:"\uf059" //fa-question-sign
        onClicked: root.state = root.state=="INFO" ? "" : "INFO"
    }
    ATButtonText{
        id:buttonLAEC
        height:50
        width:height
        visible:laecLabel.text != ""
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        fontFamily:Assets.fonts.awesome.name
        text:"\uf02d" //icon book
        onClicked: root.state = root.state=="LAEC" ? "" : "LAEC"
    }




}
