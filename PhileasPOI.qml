import QtQuick 2.0
import QtQuick.Controls 2.0
import ATeam.Phileas.AssetsSingleton 1.0

Page {
    id:root
    property bool demo : false
    property int poiId : 0
    signal endPOI();

    Column{
        z:2
        Label{
            text:root.demo ? "DEMO" : "GPS"
        }
        Label{
            text:root.poiId
        }

        Button{
            text:"Quit game"
            onClicked: root.endPOI()
        }
    }


}
