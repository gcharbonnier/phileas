import QtQuick 2.0
import QtQuick.Controls 2.0
import QtPositioning 5.8
import QtLocation 5.8
import QtGraphicalEffects 1.0
import ATeam.Phileas.AssetsSingleton 1.0

Page {
    id:root
    property bool demo : false

    signal startPOI(int poiID);

    Map{

        Component.onCompleted: myMap.activeMapType = myMap.supportedMapTypes[2]

        id:myMap
        //opacity:0
        anchors.fill: parent
        plugin:Plugin{
            name:"osm"
            PluginParameter { name: "osm.useragent"; value: "Phileas hobby project" }


        }

        copyrightsVisible: root.demo
        center:root.demo ? QtPositioning.coordinate(47.096443, -1.636882) : myPos.position.coordinate

        visibleRegion: QtPositioning.circle(QtPositioning.coordinate(47.096443, -1.636882), 250)

        minimumZoomLevel: 15

        Behavior on zoomLevel{
            NumberAnimation { duration: 1000 }
        }

        MapItemView{
            model:Assets.models.lstPOI
            delegate:PhileasDelegate{
                poiID : poiID
                coordinate: QtPositioning.coordinate(latitude,longitude)
                isNear : myMap.center.distanceTo(coordinate) < 50
                onStartPOI: {
                    root.startPOI(poiID)
                    console.log(poiID)
                }
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

    Item{
        width:50
        height:50
        Text{
            anchors.fill: parent
            fontSizeMode:Text.Fit
            font.pixelSize: Assets.ui.maximumPixelSize
            color:Assets.ui.buttonColor
            minimumPixelSize: Assets.ui.minimumPixelSize
            horizontalAlignment: Qt.AlignHCenter
            verticalAlignment : Qt.AlignVCenter
            font.family:Assets.fonts.awesome.name
            text:"\uf010" //fa-search-minus f00e
            visible:myMap.zoomLevel>=15
            MouseArea{
                anchors.fill: parent
                onClicked: myMap.zoomLevel--
            }
        }

    }
    Item{
        anchors.right:parent.right
        width:50
        height:50
        Text{
            anchors.fill: parent
            fontSizeMode:Text.Fit
            font.pixelSize: Assets.ui.maximumPixelSize
            color: Assets.ui.buttonColor
            minimumPixelSize: Assets.ui.minimumPixelSize
            horizontalAlignment: Qt.AlignHCenter
            verticalAlignment : Qt.AlignVCenter
            font.family:Assets.fonts.awesome.name
            text:"\uf00e" //fa-search-minus
            visible:myMap.zoomLevel<=myMap.maximumZoomLevel
            MouseArea{
                anchors.fill: parent
                onClicked: myMap.zoomLevel++
            }
        }

    }
}
