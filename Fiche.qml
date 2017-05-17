import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.1
import ATeam.Phileas.AssetsSingleton 1.0
import ATeam.BlobImage 1.0

Item {
    id:root
    property alias photo: photoCand.imageData
    property alias nom: nom.text
    property alias tel: tel.text
    property alias email: email.text
    property alias cv: cv.text


    Column{
        id:col
        anchors.fill: parent
        anchors.margins : 2

        spacing : 15

        BlobImage{
            id:photoCand
            visible:true
            width:parent.width * .5
            height:Math.min(200,parent.height * .2)
        }

        GridLayout {
            id:contactDetails
            visible: true
            width:parent.width
            anchors.right:parent.right
            columns: 2
            rowSpacing: 10
            columnSpacing: 10

            Label {
                text: qsTr("Nom :")
                Layout.leftMargin: 1
                wrapMode:Text.Wrap
            }

            Label {
                id:nom
                font.bold: true
                elide: Text.ElideRight
                Layout.fillWidth: true
                color:"white"
                wrapMode:Text.Wrap
            }

            Label {
                text: qsTr("Tel:")
                Layout.leftMargin: 1
                wrapMode:Text.Wrap
            }

            Label {
                id:tel
                font.bold: true
                elide: Text.ElideRight
                color:"white"
                wrapMode:Text.Wrap
                MouseArea{
                    anchors.fill:parent
                    onClicked: Qt.openUrlExternally("tel:"+parent.text)
                }
            }

            Label {
                text: qsTr("e-Mail:")
                Layout.leftMargin: 1
                wrapMode:Text.Wrap
            }

            Label {
                id:email
                font.bold: true
                elide: Text.ElideRight
                color:"white"
                wrapMode:Text.Wrap
                MouseArea{
                    anchors.fill:parent
                    onClicked: Qt.openUrlExternally("mailto:"+parent.text)
                }
            }
        }

        Flickable{
            width:parent.width
            contentWidth: width
            contentHeight: cv.height
            clip: true
            height:parent.height - photoCand.height - contactDetails.height - 2 *col.spacing
            Label {
                id:cv
                width:parent.width
                font: Assets.fonts.robotslab.name
                wrapMode: Label.WordWrap
                color:"white"
            }
        }
    }

}

