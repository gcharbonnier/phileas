#include "updatemanager.h"

#include <QFile>
#include <QSqlQuery>
UpdateManager::UpdateManager(QObject *parent) : QObject(parent)
{

    QSqlQuery query("SELECT version FROM info");
    query.next();
    //uint currentVersion = query.value(0).toUINT();


    QFile file1("assets:/44-9.db");
    QFile file2("https://sites.google.com/site/retzistance/44-9.db");
    QFile xmlDescriptor("https://sites.google.com/site/retzistance/phileas.xml");
/*
    QXmlSimpleReader xmlReader;
        QXmlInputSource *source = new QXmlInputSource(xmlDescriptor);
*/
}
