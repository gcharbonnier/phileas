#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include <QDir>
#include <QStandardPaths>
#include <QSqlQuery>

#include "qdatabasemodels.h"
#include "qblobimage.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    //Open SQLite Database
    QSqlDatabase db = QSqlDatabase::addDatabase("QSQLITE");
    QString absPath = QStandardPaths::writableLocation(QStandardPaths::AppDataLocation)+"/44-9.db";
#ifdef Q_OS_ANDROID
    //absPath = QDir::currentPath() + "/44-9.db";
    if (!QFile::exists(absPath)){
        QFile dfile("assets:/44-9.db");
        if (dfile.exists())
        {
            if (!dfile.copy(absPath))
                qCritical() << "Fail to copy db file to " << absPath;
            if (!QFile::setPermissions(absPath,QFile::WriteOwner | QFile::ReadOwner))
                qCritical() << "Fail to provide file write permissions";
        }
        else qCritical() << "Can't find deployed database in assets folder";
    }
    else
    {
        qInfo() << "DataBase file already exists at "<< absPath;
    }
#endif
#ifdef Q_OS_IOS

#endif

    /*
    QString remoteDB = QString("https://sites.google.com/site/retzistance/44-9.db");
    QString versionDesc = QString("http://krutagor.free.fr/phileas/phileas.xml");

    QFile file2( remoteDB );
    QFile fileVersionDesc( versionDesc );
          if (!fileVersionDesc.open(QIODevice::ReadOnly | QIODevice::Text))
              return 1;

          QTextStream in(&fileVersionDesc);
          while (!in.atEnd()) {
              QString line = in.readLine();

          }
    db.setDatabaseName(remoteDB);
    uint currentVersion = 0;
    if (db.open())
    {
        QSqlQuery query("SELECT version FROM info");
        query.next();
        currentVersion = query.value(0).toUInt();
    }
    */

    db.setDatabaseName(absPath);
    if (!db.open())
        qCritical() << "Failed opening dataBase";
    else {
        qInfo() << "Opening dataBase ok  at "<< absPath;
        qInfo() << db.tables();
    }

    QSqlQuery query("SELECT version FROM info");
    query.next();
    uint localVersion = query.value(0).toUInt();


    QQmlApplicationEngine engine;

    QSqlQmlTableModel lstPoi;
    if (!lstPoi.selectTable("poi"))
        qCritical() << "Error with Point Of Interests table";
    QSqlQmlTableModel lstCirco;
    if (!lstCirco.selectTable("circos"))
        qCritical() << "Error with Circonscription table";

    engine.rootContext()->setContextProperty("sqlPoiModel", &lstPoi);
    engine.rootContext()->setContextProperty("sqlCircoModel", &lstCirco);

    qmlRegisterType<QBlobImage>("ATeam.BlobImage", 1, 0, "BlobImage");
    qmlRegisterSingletonType( QUrl("qrc:/Assets.qml"),"ATeam.Phileas.AssetsSingleton", 1, 0,"Assets");
    engine.load(QUrl(QLatin1String("qrc:/main.qml")));

    return app.exec();
}
