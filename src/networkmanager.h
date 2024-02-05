#ifndef NETWORKMANAGER_H
#define NETWORKMANAGER_H

#include <QObject>

class networkManager : public QObject
{
    Q_OBJECT
public:
    explicit networkManager(QObject *parent = nullptr);

signals:

};

#endif // NETWORKMANAGER_H
