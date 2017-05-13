#include <QGuiApplication>
#include <QQmlApplicationEngine>


int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    qmlRegisterSingletonType( QUrl("qrc:/Assets.qml"),"ATeam.Phileas.AssetsSingleton", 1, 0,"Assets");
    engine.load(QUrl(QLatin1String("qrc:/main.qml")));

    return app.exec();
}
