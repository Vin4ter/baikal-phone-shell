#ifndef DISPLAY_BRIGHTNESS_H
#define DISPLAY_BRIGHTNESS_H

#include <QObject>
#include "QProcess"
#include "QThread"

class display_brightness : public QObject
{
    Q_OBJECT
public:
    explicit display_brightness(QObject *parent = nullptr);

private:
    QProcess p_lcd;
       QThread* thread;
signals:

public slots:
         void setBrightness(int val);
};

#endif // DISPLAY_BRIGHTNESS_H
