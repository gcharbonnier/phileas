import QtQuick 2.0
import QtPositioning 5.8
import QtLocation 5.8
import ATeam.Phileas.AssetsSingleton 1.0


MapQuickItem{

    id:root
    property int poiID : 0
    property bool isNear : false

    signal startPOI(int poiID);



    sourceItem:Image{
        id:imgPOIDelegate
        width:50
        height:50
        source:"qrc:/res/img/phi_blanc.png"
        fillMode:Image.PreserveAspectFit

        PropertyAnimation{
            target:imgPOIDelegate
            property:"opacity"
            running:root.isNear
            to:0
            from:1
            duration:1000
            loops: Animation.Infinite
        }

        MouseArea{
            anchors.fill: imgPOIDelegate
            enabled:root.isNear
            onClicked: {
                root.startPOI(root.poiID)
                console.log("deg"+poiID)
            }
        }
    }
}
