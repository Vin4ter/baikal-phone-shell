#ifndef EXAMPLETHREADS_H
#define EXAMPLETHREADS_H

#include <QThread>
#include "QProcess"
#include "qtimer.h"

class ExampleThreads : public QThread
{
public:
    explicit ExampleThreads(QString threadName);

    // Переопределяем метод run(), в котором будет
    // располагаться выполняемый код
    void run();
      static void sleep(unsigned long secs){QThread::sleep(secs);}

private:
    QString name;   // Имя потока
    QProcess *p_networkManager;
    QTimer * getSignalTimer;
public slots:
        void getWifiSignal();
signals:
        void sendNetworkStrength(int strength);
};

#endif // EXAMPLETHREADS_H
