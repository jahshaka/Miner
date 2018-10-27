/**************************************************************************
This file is part of JahshakaVR, VR Authoring Toolkit
http://www.jahshaka.com
Copyright (c) 2016  GPLv3 Jahshaka LLC <coders@jahshaka.com>

This is free software: you may copy, redistribute
and/or modify it under the terms of the GPLv3 License

For more information see the LICENSE file
*************************************************************************/

#include <cl/cl.h>

#include <QTimer>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonValue>
#include <QJsonArray>
#include <QDir>
#include <QApplication>
#include <QMessageBox>

#include "minerprocess.h"
#include "cuda_gpu_list.h"
#include "dataprovider.h"

float RandomFloat(float a, float b) {
	float random = ((float)rand()) / (float)RAND_MAX;
	float diff = b - a;
	float r = random * diff;
	return a + r;
}

float RandomFloat()
{
	return RandomFloat(0.0f, 1.0f);
}

QString parse_vendor(const char* name) {
	if (!strcmp(name, "Intel(R) Corporation"))
		return "Intel";
	else if (!strcmp(name, "Advanced Micro Devices, Inc."))
		return "AMD";
	else if (!strcmp(name, "NVIDIA Corporation"))
		return "NVIDIA";
	else
		return "Unknown";
}

QList<GPU> get_amd_devices() {
	cl_platform_id platforms[64];
	cl_uint platforms_used;
	clGetPlatformIDs(sizeof platforms / sizeof(*platforms), platforms, &platforms_used);

	QList<GPU> ret;
	int gpuIndex = 0;
	for (auto i = 0; i < platforms_used; ++i) {
		cl_device_id devices[64];
		cl_uint devices_used;
		clGetDeviceIDs(platforms[i], CL_DEVICE_TYPE_GPU, sizeof devices / sizeof(*devices), devices, &devices_used);

		for (auto j = 0u; j < devices_used; ++j) {
			char name[256];
			char vendorname[256];
			cl_ulong cache;
			cl_ulong memory;

			clGetDeviceInfo(devices[j], CL_DEVICE_GLOBAL_MEM_CACHE_SIZE, sizeof(cache), &cache, nullptr);
			clGetDeviceInfo(devices[j], CL_DEVICE_GLOBAL_MEM_SIZE, sizeof(memory), &memory, nullptr);
			clGetDeviceInfo(devices[j], CL_DEVICE_VENDOR, sizeof vendorname, &vendorname, nullptr);
			clGetDeviceInfo(devices[j], CL_DEVICE_NAME, sizeof name, &name, nullptr);
			if (parse_vendor(vendorname) == "AMD")
				ret.push_back({ gpuIndex++, parse_vendor(vendorname), name, GPUType::AMD });
		}
	}

	return ret;
}

QList<GPU> get_cuda_devices() {
	cl_platform_id platforms[64];
	cl_uint platforms_used;
	clGetPlatformIDs(sizeof platforms / sizeof(*platforms), platforms, &platforms_used);

	QList<GPU> ret;
	int gpuIndex = 0;
	for (auto i = 0; i < platforms_used; ++i) {
		cl_device_id devices[64];
		cl_uint devices_used;
		clGetDeviceIDs(platforms[i], CL_DEVICE_TYPE_GPU, sizeof devices / sizeof(*devices), devices, &devices_used);


		for (auto j = 0u; j < devices_used; ++j) {
			char name[256];
			char vendorname[256];
			cl_ulong cache;
			cl_ulong memory;

			clGetDeviceInfo(devices[j], CL_DEVICE_GLOBAL_MEM_CACHE_SIZE, sizeof(cache), &cache, nullptr);
			clGetDeviceInfo(devices[j], CL_DEVICE_GLOBAL_MEM_SIZE, sizeof(memory), &memory, nullptr);
			clGetDeviceInfo(devices[j], CL_DEVICE_VENDOR, sizeof vendorname, &vendorname, nullptr);
			clGetDeviceInfo(devices[j], CL_DEVICE_NAME, sizeof name, &name, nullptr);
			if (parse_vendor(vendorname) == "NVIDIA")
				ret.push_back({ gpuIndex++, parse_vendor(vendorname), name, GPUType::NVidia });
		}
	}

	return ret;
}

// code taken from autoAdjust.hpp from nvidia miner backend
/*
QList<GPU> get_cuda_devices() {
	QList<GPU> ret;

	int deviceCount = 0;
	if (cuda_get_devicecount(&deviceCount) == 0)
		return ret;

	// evaluate config parameter for if auto adjustment is needed
	for (int i = 0; i < deviceCount; i++)
	{

		nvid_ctx ctx;

		ctx.device_id = i;
		// -1 trigger auto adjustment
		ctx.device_blocks = -1;
		ctx.device_threads = -1;

		// set all evice option those marked as auto (-1) to a valid value
#ifndef _WIN32
		ctx.device_bfactor = 0;
		ctx.device_bsleep = 0;
#else
		// windows pass, try to avoid that windows kills the miner if the gpu is blocked for 2 seconds
		ctx.device_bfactor = 6;
		ctx.device_bsleep = 25;
#endif
		if (cuda_get_deviceinfo(&ctx) == 0) {
			ret.append({ ctx.device_id, "NVIDIA", ctx.device_name, GPUType::NVidia });
		}
		else
			qDebug()<<"WARNING: NVIDIA setup failed for GPU" << i;

	}

	//generateThreadConfig();
	return ret;
}
*/
MinerManager::MinerManager( QObject *parent) :QObject(parent){
    settingsManager = new SettingsManager();
    resetSettingsToDefault();
}

Q_INVOKABLE QString MinerManager::getWalletId() const
{
    return walletIdText;
}

Q_INVOKABLE void MinerManager::setWalletId(const QString &value)
{
    walletIdText = value;
}

void MinerManager::resetSettings()
{
    emit walletIdChanged(walletIdText);
    emit poolUrlChanged(poolUrlText);
    emit passwordChanged(passwordText);
    emit identifierChanged(identifierText);
}

Q_INVOKABLE void MinerManager::resetSettingsToDefault()
{
    walletIdText = settingsManager->getValue("wallet_id", walletId).toString();
    poolUrlText = settingsManager->getValue("pool", poolUrl).toString();
    passwordText = settingsManager->getValue("password", password).toString();
    identifierText =  settingsManager->getValue("identifier", identifier).toString();

    emit walletIdChanged(walletId);
    emit poolUrlChanged(poolUrl);
    emit passwordChanged(password);
    emit identifierChanged(identifier);
}

Q_INVOKABLE void MinerManager::saveAndApplySettings()
{
        settingsManager->setValue("wallet_id", walletIdText);
        settingsManager->setValue("pool", poolUrlText);
        settingsManager->setValue("password", passwordText);
        settingsManager->setValue("identifier", identifierText);


            for( auto pro : dataProviderList){
                if(pro->isProcessMining())
                    pro->restartProcesses();
            }
}

Q_INVOKABLE void MinerManager::restoreSettings()
{
         settingsManager->setValue("wallet_id", walletId);
        settingsManager->setValue("pool", poolUrl);
        settingsManager->setValue("password", password);
         settingsManager->setValue("identifier", identifier);

         resetSettingsToDefault();
}

Q_INVOKABLE QString MinerManager::getPassword() const
{
    return passwordText;
}

Q_INVOKABLE void MinerManager::setPassword(const QString &value)
{
    passwordText = value;
}

Q_INVOKABLE QString MinerManager::getIdentifier() const
{
    return identifierText;
}

Q_INVOKABLE void MinerManager::setIdentifier(const QString &value)
{
    identifierText = value;
}

Q_INVOKABLE QString MinerManager::getPoolUrl() const
{
    return poolUrlText;
}

Q_INVOKABLE void MinerManager::setPoolUrl(const QString &value)
{
    poolUrlText = value;
}

Q_INVOKABLE QVector<int> MinerManager::providerlist()
{
    return somenumber;
}

//Q_INVOKABLE QQmlListProperty<DataProvider*> MinerManager::dataHolderLists()
//{
//	return providerList;
//}

Q_INVOKABLE void MinerManager::startMining()
{
	for (auto card : dataProviderList) {
		card->startProcess();
	}
}

Q_INVOKABLE void MinerManager::stopMining()
{
	for (auto card : dataProviderList) {
		card->stopProcess();
    }
}

void MinerManager::setShouldMining(bool val)
{
    for(auto pro : dataProviderList){
        pro->setShouldMine(val);
    }
}



bool MinerManager::initialize()
{
	// get nvidia devices
	auto list = get_cuda_devices();

    // get amd devices
    list.append(get_amd_devices());

	// create processes for each
	int portNum = 9310;
	int i = 0;
	for (auto gpu : list) {
		auto proc = new MinerProcess(this);
		auto dataprovider = new DataProvider();
		i++;
		proc->setGpu(gpu);
		proc->setNetworkPort(portNum);
		dataprovider->setMinerProcess(proc);
		dataprovider->setIndex(i);
        emit processCreated(dataprovider);
		processes.append(proc);
		dataProviderList.append(dataprovider);
		portNum += 1;
	}

	return true;

}

void MinerProcess::setNetworkPort(int portNum)
{
	networkUrl = QString("http://localhost:%1/api.json").arg(portNum);
	networkPort = portNum;
}

void MinerProcess::startMining()
{
	QDir basePath = QDir(QCoreApplication::applicationDirPath());
	auto xmrPath = QDir::cleanPath(basePath.absolutePath() + QDir::separator() + "xmr-stak/xmr-stak.exe");
	qDebug() << "start xmrstack called";
	process = new QProcess();
	QStringList args;
	/*
	args << "--currency" << "monero7";
	args << "-o" << "pool.supportxmr.com:3333";
	args << "-p" << "x";
	args << "-r" << "x";
	args << "-u" << "43QGgipcHvNLBX3nunZLwVQpF6VbobmGcQKzXzQ5xMfJgzfRBzfXcJHX1tUHcKPm9bcjubrzKqTm69JbQSL4B3f6E3mNCbU";
	*/
	args << "--currency" << "monero";
    args << "-o" << minerMan->poolUrlText;
	if (minerMan->password.isEmpty())
		args << "-p" << minerMan->password;
	else
        args << "-p" << minerMan->passwordText;
    args << "-r" << minerMan->identifierText;
    args << "-u" << minerMan->walletIdText;
	args << "-i" << QString("%1").arg(this->networkPort);
	if (gpu.type == GPUType::AMD)
		args << "--noNVIDIA";
	else
		args << "--noAMD";
	args << "--noCPU";
	args << "--noUAC";
	args << "--gpuIndex" << QString("%1").arg(gpu.index);
	qDebug() << args;
	data.clear();

	QObject::connect(process, &QProcess::readyReadStandardOutput, [this]()
	{
		auto text = QString(process->readAllStandardOutput());;
		qDebug().noquote() << text;
		emit onMinerOutput(text);
	});
	QObject::connect(process, &QProcess::readyReadStandardError, [this]()
	{
		auto text = QString(process->readAllStandardOutput());;
		qDebug().noquote() << text;
		emit onMinerOutput(text);
	});

	QObject::connect(process, &QProcess::errorOccurred, [this](QProcess::ProcessError error)
	{
		qDebug() << "Miner Process Error: " << error;
		qDebug() << process->readAllStandardOutput();

		if (_isMining && retries < 3) {
			//todo: stop mining
			this->stopMining();
			this->startMining();
			qDebug() << "restarting miner";
			retries++;
		}
		else {
			this->stopMining();
		}
	});

	process->setProcessChannelMode(QProcess::MergedChannels);
	process->start(xmrPath, args);

	// start listening over the network
	timer = new QTimer();
	timer->setInterval(1000);
	timer->start();
	sentRequests = 0;
	QObject::connect(timer, &QTimer::timeout, [this]()
	{
		// limit to 5 requests waiting
		if (sentRequests > 5)
			return;

		sentRequests += 1;
		this->networkRequest(this->networkUrl, [this](QString result)
		{
			sentRequests -= 1;

			QJsonParseError error;
			auto doc = QJsonDocument::fromJson(result.toUtf8(), &error);

			if (error.error == QJsonParseError::NoError) {
				QJsonObject obj = doc.object();
				//qDebug() << obj;
				//auto hps = obj["hashrate"]["total"][0].toDouble(0);
				//auto time = obj["connection"]["uptime"].toFloat(0);

				// time
				auto conObj = obj["connection"].toObject();
				auto uptime = conObj["uptime"].toInt();
				auto pool = conObj["pool"].toString();
				bool poolConnected = pool == "not connected" ? false : true;

				// hps
				auto hashObj = obj["hashrate"].toObject();
				auto hashArray = hashObj["total"].toArray();
				auto hps = (float)hashArray[0].toDouble(0);

				// emit status changed    
				emit onMinerChartData({ poolConnected,uptime, hps });

				// emit each new error in connection error log
				auto conErrorLog = conObj["error_log"].toArray();
				double maxErrorTime = errorLogLastSeen;
				for (auto errorVar : conErrorLog) {
					auto errObj = errorVar.toObject();
					double errorTime = errObj["last_seen"].toDouble();
					if (errorTime > errorLogLastSeen) {
						auto text = obj["text"].toString();
						emit onMinerOutput(text);
						qDebug() << text;
						errorLogLastSeen = errorTime;
					}

					if (errorTime > maxErrorTime)
						maxErrorTime = errorTime;
				}

				// emit each new error in connection error log
				auto resErrorLog = obj["results"].toObject()["error_log"].toArray();
				for (auto errorVar : resErrorLog) {
					auto errObj = errorVar.toObject();
					double errorTime = errObj["last_seen"].toDouble();
					if (errorTime > errorLogLastSeen) {
						auto text = obj["text"].toString();
						emit onMinerOutput(text);
						qDebug() << text;
						errorLogLastSeen = errorTime;
					}

					if (errorTime > maxErrorTime)
						maxErrorTime = errorTime;
				}

				errorLogLastSeen = maxErrorTime;

			}
		}, [this](QNetworkReply::NetworkError error)
		{
			this->sentRequests -= 1;
		});
	});

	_isMining = true;
	retries = 0;
}

void MinerProcess::stopMining()
{
	timer->stop();
	if (process != nullptr) {
		//process->terminate();
		process->kill();
		//delete process;
		//process->close();
		//delete process;
		//process = nullptr;
	}

	_isMining = false;
	retries = 0;
}

void MinerProcess::networkRequest(QString url, std::function<void(QString)> successCallback, std::function<void(QNetworkReply::NetworkError)> errorCallback)
{
	auto reply = netMan->get(QNetworkRequest(QUrl(networkUrl)));
	
	QObject::connect(reply, &QNetworkReply::readyRead, [reply, successCallback]()
	{
		auto data = QString(reply->readAll());
		successCallback(data);
	});

	QObject::connect(reply, QOverload<QNetworkReply::NetworkError>::of(&QNetworkReply::error), [this, errorCallback](QNetworkReply::NetworkError error)
	{
		//this->sentRequests -= 1;
		errorCallback(error);
	});
}

void MinerProcess::_setMinerStatus(MinerStatus status)
{
	this->status = status;
	emit minerStatusChanged(status);
}
