#ifndef NETWORKBINDER_H
#define NETWORKBINDER_H

#include <QObject>

#include <QProcess>
class networkBinder : public QObject
{
    Q_OBJECT
public:
    explicit networkBinder(QObject *parent = nullptr);
    QProcess *p_networkManager;
    //void run();

public slots:
        void run();
signals:


private slots:
     void getWifiSignal();
};

#endif // NETWORKBINDER_H
