#include "examplethreads.h"
#include <QDebug>
#include <sleeper.h>

ExampleThreads::ExampleThreads(QString threadName) :
    name(threadName)
{

}

void ExampleThreads::run()
{
    while(true){
 qDebug()<<"run";
 QThread* thread = new QThread;
 QProcess Prozess;
   Prozess.moveToThread(thread);
   Prozess.start("/bin/sh", QStringList()<< "-c"
                           << "nmcli dev wifi list | awk '/\*/{if (NR!=1) {print $8}}'");

   Prozess.waitForFinished();
    qDebug()<<"signal >> "<<Prozess.readAllStandardOutput();

    Sleeper::sleep(5);
}
   // connect(getSignalTimer, &QTimer::timeout, this, ExampleThreads::getWifiSignal);
/*

        QThread* somethread = new QThread(this);
        QTimer* timer = new QTimer(0); //parent must be null
        timer->setInterval(1000);
        timer->moveToThread(somethread);
        //connect what you want
           connect(timer, &QTimer::timeout, this, &ExampleThreads::getWifiSignal);
        somethread->start();
*/

}

void ExampleThreads::getWifiSignal()
{

}
