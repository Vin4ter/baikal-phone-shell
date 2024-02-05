#include "battery_handler.h"
#include <QFile>
#include <QDir>
#include <QDirIterator>

battery_handler::battery_handler(QObject *parent) : QObject(parent) {

}

QString battery_handler::battery_path() {
    QString battery_path;
    QDir dir("/sys/class/power_supply");
    QDirIterator it("/sys/class/power_supply", QDirIterator::Subdirectories);
    QFileInfoList hitList;
    // Iterate through the directory using the QDirIterator
        while (it.hasNext()) {
            QString filename = it.next();
            QFileInfo file(filename);

            // If the filename contains target string - put it in the hitlist
            if (file.fileName().contains("bat", Qt::CaseInsensitive)) {
                hitList.append(file);
            }
        }

        foreach (QFileInfo hit, hitList) {
           battery_path = hit.absoluteFilePath();
        }
        return battery_path;
}


QString battery_handler::battery_level() {
    QString battery_level;
    QFile file(battery_path() + "/capacity");
    if (file.open(QIODevice::ReadOnly)) {
        QTextStream in(&file);
        battery_level = in.readLine();
    }
    return battery_level;
}

QString battery_handler::battery_charge_status() {
    QString battery_charge_status;
    QFile file(battery_path() + "/status");
    if (file.open(QIODevice::ReadOnly)) {
        QTextStream in(&file);
        battery_charge_status = in.readLine();
    }
    return battery_charge_status;
}
