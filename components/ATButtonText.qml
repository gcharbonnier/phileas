import QtQuick 2.0
import QtGraphicalEffects 1.0
import ATeam.Phileas.AssetsSingleton 1.0

Item{
    property alias text : embText.text
    property alias textColor : embText.color
    property color color : Assets.ui.buttonBkColor
    signal clicked()
    property alias fontFamily: embText.font.family
    property bool showOutline : false
    property alias fontPixelSize : embText.font.pixelSize
    property alias horizontalAlignment: embText.horizontalAlignment
    property alias verticalAlignment : embText.verticalAlignment

    property alias backgroundOpacity : embRect.opacity
    property int backgroundBorderWidth : 0
    width: Assets.ui.defaultWidth
    height:Assets.ui.defaultHeight

    Rectangle{
        id:embRect
        border.color: Qt.darker(color)
        border.width: parent.backgroundBorderWidth
        radius: height * 0.5
        opacity: Assets.ui.buttonBkOpacity
        visible: parent.showOutline
        anchors.fill: parent
        color: parent.enabled ? parent.color : Assets.ui.buttonBkColorDisabled
        transformOrigin: Item.Center

    }

    ATText
    {
        id: embText
        enabled: parent.enabled
        anchors.fill: parent
        anchors.margins: parent.showOutline ? Assets.ui.buttonMargin : 0
        color: Assets.ui.buttonTextcolor

    }

    MouseArea{
        id:embMA
        anchors.fill:parent
        enabled: parent.enabled
        onClicked: parent.clicked()
        preventStealing: true
    }

}



