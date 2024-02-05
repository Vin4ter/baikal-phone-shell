#ifndef ALSACONTROLLER_H
#define ALSACONTROLLER_H

#include <QObject>
#include <QProcess>
#include <QThread>

class alsaController : public QObject
{
    Q_OBJECT
public:
    explicit alsaController(QObject *parent = nullptr);

private:
    QProcess p_volume;
       QThread* thread;
signals:

public slots:
         void setVolume(int val);
};

#endif // ALSACONTROLLER_H
