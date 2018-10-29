#include "dataprovider.h"
#include "literals.h"
#include "minerfrontend.h"
#include "minerprocess.h"
#include <QApplication>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <literal.h>
#include <QQuickView>
#include <QOpenGLWidget>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
	QCoreApplication::setAttribute(Qt::AA_UseSoftwareOpenGL);
    QApplication app(argc, argv);

    Literal lit;

    QQmlApplicationEngine engine;
	qmlRegisterType<DataProvider>("DataProvider", 1, 0, "DataProvider");
	qmlRegisterType<MinerManager>("MinerManager", 1, 0, "MinerManager");
	engine.rootContext()->setContextProperty("Literals",&lit);
    engine.load(QUrl(QStringLiteral("qrc:/mainStandalone.qml")));

	/*QQuickView view;
	view.setSource(QUrl(QStringLiteral("qrc:/mainStandalone.qml")));
	view.rootContext()->setContextProperty("Literals", &lit);
	view.setColor(QColor(200, 0, 0));
	view.setResizeMode(QQuickView::SizeViewToRootObject);
	view.setSceneGraphBackend(QSGRendererInterface::Software);
	view.setSceneGraphBackend(QSGRendererInterface::Direct3D12);

	QSurfaceFormat format;
    format.setSwapInterval(0);
    format.setRenderableType(QSurfaceFormat::OpenGL);
    view.setFormat(format);


	auto *wid = QOpenGLWidget::createWindowContainer(&view);
	wid->show();*/
	//view.show();
	

    //if (engine.rootObjects().isEmpty())
    //    return -1;



    return app.exec();
}
