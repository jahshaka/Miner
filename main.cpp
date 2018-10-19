#include "dataprovider.h"
#include "literals.h"
#include "minerfrontend.h"
#include "minerprocess.h"
#include <QApplication>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <literal.h>


int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QApplication app(argc, argv);

    Literal lit;

    QQmlApplicationEngine engine;
	qmlRegisterType<DataProvider>("DataProvider", 1, 0, "DataProvider");
	qmlRegisterType<MinerManager>("MinerManager", 1, 0, "MinerManager");
	engine.rootContext()->setContextProperty("Literals",&lit);
    engine.load(QUrl(QStringLiteral("qrc:/mainStandalone.qml")));

    if (engine.rootObjects().isEmpty())
        return -1;



    return app.exec();
}
