import QtQuick 2.0
import QtQuick.Controls 2.0
import QtPositioning 5.8
import QtLocation 5.8
import QtGraphicalEffects 1.0
import ATeam.Phileas.AssetsSingleton 1.0
import QtQuick.Layouts 1.1
import "./components"

Page {
    id:root
    property bool demo : false

    signal startPOI(int poiID);

    property int detectedPOI : -1

    onDetectedPOIChanged:{
        if (detectedPOI != -1)
            Assets.sounds.detectedPOI.play();
    }



    Map{
        id:myMap
        Component.onCompleted: myMap.activeMapType = myMap.supportedMapTypes[2]


        //opacity:0
        anchors.fill: parent
        plugin:Plugin{
            name:"osm"
            PluginParameter { name: "osm.useragent"; value: "Phileas hobby project" }
            PluginParameter { name: "osm.apikey"; value: "411732fe1c3144c892da530d0d35ee85" }
            PluginParameter { name: "osm.mapping.apikey"; value: "411732fe1c3144c892da530d0d35ee85" }
            PluginParameter { name: "osm.mapping.custom.apikey"; value: "411732fe1c3144c892da530d0d35ee85" }
            PluginParameter { name: "osm.mapping.custom.host"; value: "https://{s}.tile.thunderforest.com/landscape/{z}/{x}/{y}.png" }
        }

        copyrightsVisible: root.demo
        center:root.demo ? QtPositioning.coordinate(47.096443, -1.636882) : myPos.position.coordinate

        visibleRegion: QtPositioning.circle(QtPositioning.coordinate(47.096443, -1.636882), 250)

        minimumZoomLevel: 15

        Behavior on zoomLevel{
            NumberAnimation { duration: 1000 }
        }

        MapItemView{
            model:sqlPoiModel
            delegate:PhileasDelegate{
                poiID : model.id
                poiType : model.type
                coordinate: QtPositioning.coordinate(latitude,longitude)
                isNear : myMap.center.distanceTo(coordinate) < 50
                onIsNearChanged:{
                    if (isNear) root.detectedPOI = index;
                    else root.detectedPOI = -1;
                }

                onStartPOI: {
                    sqlPoiModel.selectedRow = index;
                    root.startPOI(index)
                }
            }
        }

    }

    Image{
        source:"qrc:/res/jlm.png"
        anchors.bottom: myMap.bottom
        anchors.right : myMap.right
        height:200
        width:height*1.168
        opacity: (root.detectedPOI !=-1) ? 1 : 0
        fillMode: Image.PreserveAspectFit

        Behavior on opacity {
            NumberAnimation { duration: 1000 }
        }
        MouseArea{
            anchors.fill:parent
            enabled: (root.detectedPOI !=-1)
            onClicked: {
                sqlPoiModel.selectedRow = root.detectedPOI;
                root.startPOI(root.detectedPOI)
            }
        }
    }



    MouseArea{
        anchors.fill:myMap
        enabled: root.demo
        onDoubleClicked: myMap.center = myMap.toCoordinate(Qt.point(mouse.x,mouse.y))
        propagateComposedEvents: true
    }

    PositionSource{
        id:myPos
        updateInterval: 1000
        active:!root.demo
        preferredPositioningMethods: PositionSource.AllPositioningMethods
    }


    ATButtonText {
        height:50
        width:height
        textColor:Assets.ui.zoomcarte
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        fontFamily:Assets.fonts.awesome.name
        text:"\uf010" //fa-search-minus f00e
        visible:myMap.zoomLevel>=myMap.minimumZoomLevel
        onClicked: myMap.zoomLevel--

    }


    ATButtonText{
        height:50
        width:height
        textColor:Assets.ui.zoomcarte
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        fontFamily:Assets.fonts.awesome.name
        text:"\uf00e" //fa-search-minus
        visible:myMap.zoomLevel<=myMap.maximumZoomLevel
        onClicked: myMap.zoomLevel++
    }

}
