#ifndef QUIMANAGER_H
#define QUIMANAGER_H

#include "qdatabasemodels.h"
#include <QObject>

class QUIManager : public QObject
{
    Q_OBJECT


    Q_PROPERTY(QString structureColor READ structureColor NOTIFY currentPageChanged)
    Q_PROPERTY(QString currentPageLabel READ currentPageLabel NOTIFY currentPageChanged)
    Q_PROPERTY(bool isFooter READ isFooter NOTIFY currentPageChanged)
    Q_PROPERTY(QSqlQmlTableModel* structModel READ structuresModel NOTIFY tryForFun)

    //Q_PROPERTY(int structureSelected READ structureSelected WRITE selectStructure NOTIFY structureSelectedChanged)
    //Q_PROPERTY(int domainSelected READ domainSelected WRITE selectDomain NOTIFY domainSelectedChanged)
public:
    explicit QUIManager(QObject *parent = 0);

    enum pageState{ Welcome = 0, ViewStructure, ViewDomain, ViewEnterprise, ViewMap};
    Q_ENUM(pageState)

    Q_INVOKABLE void changeState(uint newState, int selectedid =-1);
    Q_INVOKABLE void back();
    //

    QString structureColor(){ return m_structColor;}
    QString currentPageLabel(){ return m_labelCurrentPage;}
    bool isFooter(){ return m_isFooter;}

    Q_INVOKABLE QVariant selectedStructureData(QString roleName);
    Q_INVOKABLE QVariant selectedDomainData(QString roleName);

    Q_INVOKABLE QVariant requestStructureData(int id, QString roleName);
    Q_INVOKABLE QVariant requestDomainData(int id, QString roleName);

    Q_INVOKABLE uint countEntrepreneur(int iddomain);
    QSqlQmlTableModel* domainsModel();
    QSqlQmlTableModel* structuresModel();
    QSqlQmlTableModel* enterprisesModel();
signals:
    void currentPageChanged();
    void tryForFun();
    void pageRequested(QString qmlUrl);

private:
    void selectStructure(int idstruct);
    void selectDomain(int iddom);
    void updateSelectedData();

    bool m_isFooter = false;
    QString m_labelCurrentPage ="";
    QPair<uint, int> m_currentState = QPair<uint, int>( pageState::Welcome,-1);
    QPair<uint, int> m_BackState = QPair<uint, int>( pageState::Welcome,-1);


    QSqlQmlTableModel dom;
    QSqlQmlTableModel struc;
    QSqlQmlTableModel ent;

    int m_structureSelected = -1;
    int m_domainSelected = -1;

    QSqlRecord m_structureSelectedData = QSqlRecord();
    QSqlRecord m_domainSelectedData = QSqlRecord();

    QString m_structColor = QString("#21b79a");//{33,183, 154}; //"#21b79a"
};
#endif // QUIMANAGER_H
