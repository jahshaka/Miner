#pragma once
#include <qobject.h>
#include <qquickwindow.h>
#include <QQmlEngine>
#include <QWidget>
#include "literals.h"
#include <qquickview.h>
#include <QCloseEvent>
#include <QQuickWidget>


class Literals;
class MinerFrontend : public QWidget
{
	Q_OBJECT
public:
	MinerFrontend(QWidget *parent = Q_NULLPTR);
	~MinerFrontend();

	void showMiner();
private:
	bool running = false;
	QQuickWidget *qmlView;
	QWidget *container;
    QObject *minerObj;

    void setWindowGeometry();

protected:
	bool event(QEvent *event) override;
    void closeEvent(QCloseEvent *event) override;
};

