/**************************************************************************
This file is part of JahshakaVR, VR Authoring Toolkit
http://www.jahshaka.com
Copyright (c) 2016  GPLv3 Jahshaka LLC <coders@jahshaka.com>

This is free software: you may copy, redistribute
and/or modify it under the terms of the GPLv3 License

For more information see the LICENSE file
*************************************************************************/

#pragma once

#include "settingsmanager.h"

#include <QObject>
#include <QString>
#include <QVector>
#include <QProcess>
#include <QtNetwork/qnetworkaccessmanager.h>
#include <QtNetwork/qnetworkreply.h>
#include <functional>

struct MinerChartData
{
	bool connected;
	long time;
	float hps;// hashes per second
};

class QProcess;
enum class MinerStatus
{
	Idle,
	Starting,
	Mining,
	Stopping,
};

enum class GPUType
{
	NVidia,
	AMD
};

struct GPU
{
	int index;
	QString vendor;
	QString name;
	GPUType type;
};


class MinerSettings;
class MinerProcess;
class QTimer;
class DataProvider;
class MinerManager : public QObject
{
	Q_OBJECT
		Q_PROPERTY(QVector<int> list READ providerlist CONSTANT)

public:

	explicit MinerManager(QObject *parent = Q_NULLPTR);
    QString poolUrl = "pool.supportxmr.com:3333";
    QString identifier = "x";
    QString password = "jahminer";
    QString walletId = "43QGgipcHvNLBX3nunZLwVQpF6VbobmGcQKzXzQ5xMfJgzfRBzfXcJHX1tUHcKPm9bcjubrzKqTm69JbQSL4B3f6E3mNCbU";
    QString poolUrlText = "pool.supportxmr.com:3333";
    QString identifierText = "x";
    QString passwordText = "jahminer";
    QString walletIdText = "43QGgipcHvNLBX3nunZLwVQpF6VbobmGcQKzXzQ5xMfJgzfRBzfXcJHX1tUHcKPm9bcjubrzKqTm69JbQSL4B3f6E3mNCbU";

	QVector<MinerProcess*> processes;

	// initializes a MinerProcess for each miner
	// returns false is there is any error

	QVector<int> somenumber = { 1,2,3,4,5 };

	Q_INVOKABLE QVector<int> providerlist();
	Q_INVOKABLE QVector<DataProvider*> dataProviderList;
	Q_INVOKABLE void startMining();
	Q_INVOKABLE void stopMining();
    Q_INVOKABLE void setShouldMining(bool val);
	Q_INVOKABLE bool initialize();


    Q_INVOKABLE QString getPoolUrl() const;
    Q_INVOKABLE void setPoolUrl(const QString &value);

    Q_INVOKABLE QString getIdentifier() const;
    Q_INVOKABLE void setIdentifier(const QString &value);

    Q_INVOKABLE QString getPassword() const;
    Q_INVOKABLE void setPassword(const QString &value);

    Q_INVOKABLE QString getWalletId() const;
    Q_INVOKABLE void setWalletId(const QString &value);

    Q_INVOKABLE void resetSettings();
    Q_INVOKABLE void resetSettingsToDefault();
    Q_INVOKABLE void saveAndApplySettings();
    Q_INVOKABLE void restoreSettings();

private:
    SettingsManager* settingsManager;

signals:
    void processCreated(DataProvider *provider);
    void poolUrlChanged(QString value);
    void passwordChanged(QString value);
    void identifierChanged(QString value);
    void walletIdChanged(QString value);

};

class MinerChart;
class MinerProcess : public QObject
{
	Q_OBJECT
public:
	bool _isMining = false;
	float hashesPerSecond;
	//QString gpuType;
	GPU gpu;

	MinerManager* minerMan;

	// process
	QProcess* process = nullptr;
	QNetworkAccessManager* netMan;

	// for getting http reports
	int networkPort;
	QString networkUrl;
	int sentRequests;

	// number of retries after miner has crashed
	int retries;

	MinerStatus status;

	QVector<MinerChartData> data;
	//MinerChart* minerChart = nullptr;

	// sets gpu and index to mine
	void setGpu(GPU gpu)
	{
		this->gpu = gpu;
	}

	void setNetworkPort(int portNum);

	void startMining();
	void stopMining();
	bool isMining() { return _isMining; }
	MinerStatus getMinerStatus()
	{
		return status;
	}

	QTimer* timer;

	MinerProcess(MinerManager* manager)
	{
		minerMan = manager;
		netMan = new QNetworkAccessManager(nullptr);
		sentRequests = 0;
		retries = 0;
	}

	virtual ~MinerProcess()
	{

	}

signals:
	void minerStatusChanged(MinerStatus status);

	// called as soon as new miner data comes in
	void onMinerChartData(MinerChartData data);

private:
	void networkRequest(QString url, std::function<void(QString)> successCallback, std::function<void(QNetworkReply::NetworkError)> errorCallback);
	void _setMinerStatus(MinerStatus status);
};

/*
GPUMinerProcess::GPUMinerProcess():
QObject()
{
gpu = MiningGPU::NVidia;
gpuIndex = 0;
}
*/
