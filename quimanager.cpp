#include "quimanager.h"
#include <QSqlQuery>

QUIManager::QUIManager(QObject *parent) : QObject(parent)
{
    if (!struc.selectTable("structures"))
        qCritical() << "Error with Structures";
    if (!dom.selectTable("domaines"))
        qCritical() << "Error with domaines";
    if (!ent.selectTable("enterprises"))
        qCritical() << "Error with enterprises";
}

// Getter
QSqlQmlTableModel* QUIManager::domainsModel(){ return &dom; }
QSqlQmlTableModel* QUIManager::structuresModel(){ return &struc; }
QSqlQmlTableModel* QUIManager::enterprisesModel(){ return &ent; }
QVariant QUIManager::selectedDomainData(QString roleName){ return m_domainSelectedData.field( roleName).value();}
QVariant QUIManager::selectedStructureData(QString roleName){ return m_structureSelectedData.field( roleName).value();}

//int QUIManager::structureSelected(){return m_structureSelected; }
//int QUIManager::domainSelected(){ return m_domainSelected; }

uint QUIManager::countEntrepreneur(int iddomain)
{
    QSqlQuery query(QString("SELECT count(id) FROM enterprises where id_domaine =%1").arg(iddomain));
    query.next();

    return query.value(0).toInt();
}

void QUIManager::back()
{
    changeState(m_BackState.first, m_BackState.second);
}

void QUIManager::changeState(uint newState, int selectedid)
{
    QString qmlUrl = "";
    m_BackState = m_currentState;
    m_currentState = QPair<uint, int>( newState,selectedid);

    switch (newState)
    {

    case pageState::ViewStructure:
        qmlUrl = "qrc:/Structure.qml";
        selectStructure(selectedid);
        m_isFooter = true;
        m_labelCurrentPage = selectedStructureData("name").toString();
        m_structColor = selectedStructureData("color").toString();
        break;
    case pageState::ViewDomain:
        qmlUrl = "qrc:/Domain.qml";
        selectDomain(selectedid);
        m_isFooter = true;
        m_labelCurrentPage = selectedDomainData("name").toString();
        break;
    case pageState::ViewMap:
        qmlUrl = "qrc:/MapEnterprises.qml";
        m_isFooter = true;
        m_labelCurrentPage = "Les entreprises sélectionnées";
        break;
    case pageState::Welcome:
    default:
        m_isFooter = false;
        qmlUrl = "qrc:/Welcome.qml";
        selectDomain( -1);
        selectStructure(-1);
    }

    emit pageRequested(qmlUrl);
    emit currentPageChanged();
}

void QUIManager::selectStructure(int idstruct){
    //qDebug()<<"m_structureSelected" << idstruct;
    m_structureSelected = idstruct;

    //Update filter
    if (idstruct > 0)
    {
        struc.setFilter( QString("id=%1").arg(idstruct));
        dom.setFilter( QString("id_structure=%1").arg(idstruct));
    }
    else{
        struc.setFilter(QString());
        dom.setFilter(QString());
    }
    updateSelectedData();


}


void QUIManager::selectDomain(int iddom)
{
    //qDebug()<<"m_domainSelected" << iddom;
    m_domainSelected = iddom;

    //Update filter
    if (iddom > 0)
    {
        dom.setFilter( QString("id=%1").arg(iddom));
        ent.setFilter( QString("id_domaine=%1").arg(iddom));
    }
    else{
        dom.setFilter(QString());
        ent.setFilter(QString());
    }

    updateSelectedData();
}



void QUIManager::updateSelectedData()
{
    m_structureSelectedData = struc.record(0);
    m_domainSelectedData = dom.record(0);
}

QVariant QUIManager::requestStructureData(int id, QString roleName)
{
    QSqlQuery query(QString("SELECT %1 FROM structures where id =%2").arg(roleName).arg(id));
    query.next();

    return query.value(0);
}

QVariant QUIManager::requestDomainData(int id, QString roleName)
{
        QSqlQuery query(QString("SELECT %1 FROM domaines where id =%2").arg(roleName).arg(id));
        query.next();

        return query.value(0);

}
