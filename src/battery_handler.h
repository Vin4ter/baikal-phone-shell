#pragma once
#include <QVariant>
#include <QDebug>

class battery_handler : public QObject {
    Q_OBJECT

public:
    battery_handler(QObject *parent = 0);

    Q_INVOKABLE QString battery_path();
    Q_INVOKABLE QString battery_level();
    Q_INVOKABLE QString battery_charge_status();

};
