#include "display_brightness.h"

display_brightness::display_brightness(QObject *parent) : QObject(parent)
{
    thread = new QThread;
}

void display_brightness::setBrightness(int val)
{

    p_lcd.moveToThread(thread);
    p_lcd.start("/bin/sh", QStringList()<< "-c"
                            << "brightnessctl set "+QString::number(val)+"%");
    p_lcd.waitForFinished();
    p_lcd.close();
}
