


#ifndef DATAPROVIDER_H
#define DATAPROVIDER_H

#include "minerprocess.h"
#include <QObject>
#include <QClipBoard>

class DataProvider : public QObject
{
    Q_OBJECT

    Q_PROPERTY(qreal maxValue READ maxValue NOTIFY maxValueChanged)
		//Q_PROPERTY(bool armed READ armed WRITE setArmed NOTIFY armedChanged)
public:
    explicit DataProvider(QObject *parent = Q_NULLPTR);
    ~DataProvider();

	Q_INVOKABLE void finished();
    Q_INVOKABLE QList<qreal> getValues() const;
    Q_INVOKABLE QStringList getLabels() const;
    Q_INVOKABLE QStringList getColors() const;
    Q_INVOKABLE qreal getAverage();
    Q_INVOKABLE void addToSeries( qreal yValue, QString xValue = Q_NULLPTR);

    Q_INVOKABLE qreal getHigh() const;
    Q_INVOKABLE qreal getLow() const;
    Q_INVOKABLE qreal getMean() const;
    Q_INVOKABLE qreal getLatest() const;
    Q_INVOKABLE QString getCardName() const;
    Q_INVOKABLE QString getStatus() const;
	Q_INVOKABLE int getIndex();
	Q_INVOKABLE DataProvider* getProvide();
    Q_INVOKABLE void randomSeries();

	Q_INVOKABLE bool armed();
	Q_INVOKABLE void setArmed(bool value);
    Q_INVOKABLE QString time();

    qreal maxValue(){return maxValue_;}


	void setIndex(int dex);
	void setMinerProcess(MinerProcess *process);
	Q_INVOKABLE void startProcess();
	Q_INVOKABLE void stopProcess();
    Q_INVOKABLE bool isProcessMining();
    void restartProcesses();

    Q_INVOKABLE void setShouldMine(bool val);
    Q_INVOKABLE bool getShouldMine();
    Q_INVOKABLE  int chartMaxAmount(){return chartMaxValue;}
	Q_INVOKABLE QString providerTextValue() { return providerText;  }
	Q_INVOKABLE void saveMinerOutput();
private:
    QList<qreal> valueList;// y-axis
    QStringList labelList ;//x-axis;
    qreal summation;
    qreal count;
    qreal maxValue_ = 0.00;
	MinerProcess* process;
    ulong countMax =0;
    int chartMaxValue = 120;


    qreal high = 10.0;
    qreal low = 0.0;
    qreal mean = 0.5;
    qreal latest = 0.0;
    qreal average = 0.0;
    QString cardName = "gfore 10-22";
    QString status = "Inactive";
	QString providerText = "";
	int index;
	bool armed_ = false;
	bool first_run = true;
    bool shouldMine = false;

	void checkMinMax();
	friend class MinerProcess;

signals:
    void maxValueChanged(qreal value);
    void cardNameChanged(QString value);
    void statusChanged(QString value);
    void highChanged(qreal value);
    void lowChanged(qreal value);
    void meanChanged(qreal value);
    void latestChanged(qreal value);
    void averageChanged(qreal value);
    void dataAdded();
	void armedChanged(bool value);
	void miningStarted();
	void miningStopped();
	void minerOutput(QString text);


};

#endif // DATAPROVIDER_H
