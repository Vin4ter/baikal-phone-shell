#include "networkbinder.h"
#include "QTimer"
#include "QProcess"
#include "QThread"
#include "QDebug"
networkBinder::networkBinder(QObject *parent) : QObject(parent)
{

}


void networkBinder::run()
{





   // connect(getSignalTimer, &QTimer::timeout, this, ExampleThreads::getWifiSignal);
       qDebug()<<"run!!";




}

void networkBinder::getWifiSignal()
{
    p_networkManager->start("/bin/sh", QStringList()<< "-c"
                           << "nmcli dev wifi list | awk '/\*/{if (NR!=1) {print $8}}'");
    // p_networkManager->start();
     p_networkManager->waitForFinished();
     QByteArray processOutput = p_networkManager->readAllStandardOutput();
     qDebug()<<"signal >> "<<processOutput;

}
