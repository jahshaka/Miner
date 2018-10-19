


#include "dataprovider.h"
#include <QDebug>


DataProvider::DataProvider(QObject *parent) :
    QObject(parent),summation(0),count(0)
{
  
	process = nullptr;

    connect(this,&DataProvider::miningStopped,[this](){
        status = "Inactive";
    }) ;

}

DataProvider::~DataProvider()
{
	
}


Q_INVOKABLE void DataProvider::finished()
{
	qDebug() << "called";
	if (process) {
		 stopProcess();
	}
}

QList<qreal> DataProvider::getValues() const
{
   // return { 1.5, 2.5, 1.5, 2.5, 2.0, 1.0, 0.5 };
    return valueList;
}


QStringList DataProvider::getLabels() const
{
    //return QStringList({ "8:00", "10:00", "12:00", "14:00", "16:00", "18:00", "20:00" });
   // return {"lab","hfi"};
    return labelList;
}


QStringList DataProvider::getColors() const
{
    return QStringList({ "#54bc9b",
                         "#f58d35",
                         "#f14946",
                         "#8562a4",
                         "#348faa",
                         "#dddddd",
                         "#c4c4c4"
                       });
}

qreal DataProvider::getAverage()
{
    return summation/count/maxValue_;
}

void DataProvider::addToSeries(qreal yValue, QString xValue)
{

	auto num = QString::number(yValue, 'f', 2).toDouble();
	qDebug() << num;

	if (first_run && num <= 0.00) return;
	
    double sub =0;

    if(valueList.length() > chartMaxValue){
        sub = valueList.takeFirst();
	//	labelList.takeFirst();
        count--;
    }

	valueList.append(num);

	checkMinMax();

    countMax++;

    summation += num - sub;
	count++;
	mean = QString::number((summation / count), 'f', 2).toDouble();
    average = QString::number((mean / maxValue_), 'f', 2).toDouble();

    latest = num;
    emit meanChanged(mean);
    emit averageChanged(average);
    emit latestChanged(latest);
    emit dataAdded();
	first_run = false;
}

void DataProvider::randomSeries()
{
    int l= 3;

    if(countMax > 100) l = 100;
    float r2 = static_cast <float>( (rand()) % l);
   // auto value = float(qrand()%100);
    addToSeries(r2);

}

bool DataProvider::armed()
{
	return armed_;
}

Q_INVOKABLE void DataProvider::setArmed(bool value)
{
    armed_ = value;

    if(isProcessMining() && !armed())
        stopProcess();
    if(getShouldMine() && armed())
        startProcess();


    qDebug() << getShouldMine() << value;
}

QString DataProvider::time()
{
    return QTime::currentTime().toString("h:mm ap");
}

void DataProvider::setIndex(int dex)
{
	index = dex;
}

Q_INVOKABLE void DataProvider::startProcess()
{

	if (armed()) {
		this->process->startMining();
        emit this->miningStarted();
	}
}

Q_INVOKABLE void DataProvider::stopProcess()
{
	qDebug() << "called";

	if (this->process->isMining()) {
		this->process->stopMining();
		//emit this->miningStopped();
        emit miningStopped();
    }
}

bool DataProvider::isProcessMining()
{
    return process->isMining();
}

void DataProvider::restartProcesses()
{
    stopProcess();
    startProcess();

}

void DataProvider::setShouldMine(bool val)
{
    shouldMine = val;
}

bool DataProvider::getShouldMine()
{
 return shouldMine;
}

void DataProvider::setMinerProcess(MinerProcess *process)
{
	this->process = process;
	cardName = process->gpu.name;
		emit cardNameChanged(cardName);

	if (process != nullptr) {
		connect(process, &MinerProcess::onMinerChartData, [this](MinerChartData data)
		{
			// set last hash to ui
			//this->setSpeed(data.hps);
			addToSeries(data.hps);

			// if hps is 0 then it must be connecting
			// set pool color to orange
			if (data.connected)
				//this->setMinerStatus(MinerConnection::Connected);
				this->status = "Connected";
			else
				//this->setMinerStatus(MinerConnection::Connecting);
				this->status = "Connecting";

			emit statusChanged(this->status);

			this->addToSeries(data.hps);
			


		/*	if (data.hps != 0) {
				if (this->info->data.size() > 100)
					this->info->data.removeFirst();
				this->info->data.append(data);
				this->info->repaint();
			}*/
		});

		connect(process, &MinerProcess::minerStatusChanged, [this](MinerStatus status)
		{
			switch (status)
            {
            case MinerStatus::Idle:
				/*this->setMinerStatus(MinerConnection::Inactive);
				displayLabel->setText("Inactive");*/

				this->status = "Inactive";
				break;
			case MinerStatus::Starting:
				/*this->setMinerStatus(MinerConnection::Connecting);
				displayLabel->setText("Connecting");*/
				this->status = "Connecting";
				break;
			case MinerStatus::Mining:
				/*this->setMinerStatus(MinerConnection::Connected);
				displayLabel->setText("Connected");*/
				this->status = "Connected";
				break;
			case MinerStatus::Stopping:
				/*this->setMinerStatus(MinerConnection::Notconnected);
				displayLabel->setText("Not Connected");*/
				this->status = "Not Connected";

				break;
			}
			emit statusChanged(this->status);

		});
	}

}

qreal DataProvider::getHigh() const
{
    return this->maxValue_;
}

qreal DataProvider::getLow() const
{
    return low;
}

qreal DataProvider::getMean() const
{
	qSetRealNumberPrecision(2);
	
    return mean;
}

qreal DataProvider::getLatest() const
{
    return latest;
}

QString DataProvider::getCardName() const
{
    return cardName;
}

QString DataProvider::getStatus() const
{
    return status;
}

Q_INVOKABLE int DataProvider::getIndex()
{
	return index;
}

Q_INVOKABLE DataProvider * DataProvider::getProvide()
{
	return this;
}

void DataProvider::checkMinMax() 
{
	double valLow = *std::min_element(valueList.begin(), valueList.end());
	double valHigh = *std::max_element(valueList.begin(), valueList.end());

	valLow = QString::number(valLow, 'f', 2).toDouble();
	valHigh = QString::number(valHigh, 'f', 2).toDouble();


		low = valLow;
		emit lowChanged(low);

		maxValue_ = valHigh;
		emit maxValueChanged(maxValue_);
	

}

