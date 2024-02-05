#include "alsacontroller.h"

alsaController::alsaController(QObject *parent) : QObject(parent)
{
   thread = new QThread;
}

void alsaController::setVolume(int val)
{
    p_volume.moveToThread(thread);
    p_volume.start("/bin/sh", QStringList()<< "-c"
                            << "amixer set Master "+QString::number(val)+"%");
    p_volume.waitForFinished();
    p_volume.close();
}
