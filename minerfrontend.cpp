#include "minerfrontend.h"
#include <qquickwindow.h>
#include <qquickview.h>
#include <QVBoxLayout>
#include <qqmlcontext.h>
#include "literal.h"
#include "minerprocess.h"
#include "dataprovider.h"
#include <QQmlApplicationEngine>
#include <QQmlComponent>
#include <QQuickItem>
#include <QDebug>
#include <QQuickWidget>
#include <QQmlProperty>




MinerFrontend::MinerFrontend(QWidget *parent) : QWidget()
{

		qmlView = new QQuickWidget();
		Literal *lit = new Literal();
		qmlView->engine()->rootContext()->setContextProperty("Literals", lit);

		qmlRegisterType<DataProvider>("DataProvider", 1, 0, "DataProvider");
		qmlRegisterType<MinerManager>("MinerManager", 1, 0, "MinerManager");
		qmlView->setSource(QUrl("qrc:/main.qml"));
        qmlView->setResizeMode(QQuickWidget::SizeRootObjectToView);
        minerObj = qmlView->rootObject();
		QQmlProperty(minerObj, "width").write(geometry().width()); 
		QQmlProperty(minerObj, "height").write(geometry().height());

		auto layout = new QVBoxLayout;
        layout->setSpacing(0);
        layout->setContentsMargins(0,0,0,0);
		setLayout(layout);
		layout->addWidget(qmlView);
		running = true;
		
        show();

}


MinerFrontend::~MinerFrontend()
{


}

void MinerFrontend::showMiner()
{
    show();
}

void MinerFrontend::setWindowGeometry()
{
    minerObj->setProperty("width", geometry().width());
    minerObj->setProperty("height", geometry().height());
  //  minerObj->setProperty("x", geometry().x());
  //  minerObj->setProperty("y", geometry().y());


}

bool MinerFrontend::event(QEvent * event)
{
    return QWidget::event(event);
}

void MinerFrontend::closeEvent(QCloseEvent *event)
{

    hide();
    event->ignore();
}
