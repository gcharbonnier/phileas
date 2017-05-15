import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import ATeam.Phileas.AssetsSingleton 1.0
import ATeam.BlobImage 1.0
import "./components/"

Page {

    background:Rectangle{
        color:Assets.ui.fondDrawer
    }

    Connections{
        target:sqlCircoModel
        onSelectedRowChanged:{
            titulaire.photo = sqlCircoModel.selectedData("titulaire_photo")
            titulaire.nom = sqlCircoModel.selectedData("titulaire_nom")
            titulaire.tel = sqlCircoModel.selectedData("titulaire_tel")
            titulaire.email = sqlCircoModel.selectedData("titulaire_email")
            titulaire.cv = sqlCircoModel.selectedData("titulaire_cv")

            suppleant.photo = sqlCircoModel.selectedData("suppleant_photo")
            suppleant.nom = sqlCircoModel.selectedData("suppleant_nom")
            suppleant.tel = sqlCircoModel.selectedData("suppleant_tel")
            suppleant.email = sqlCircoModel.selectedData("suppleant_email")
            suppleant.cv = sqlCircoModel.selectedData("suppleant_cv")
        }
    }


    footer:TabBar{
        id:bar

        background:Rectangle{
            color:Assets.ui.fondDrawer
        }
        TabButton{
            text: qsTr("Titulaire")
        }
        TabButton{
            text: qsTr("Suppléant-e")

        }
    }

    StackLayout {
          anchors.fill: parent
          currentIndex: bar.currentIndex
          Fiche{
              id:titulaire
              anchors.fill: parent
          }
          Fiche{
              id:suppleant
              anchors.fill: parent
          }

      }



}
