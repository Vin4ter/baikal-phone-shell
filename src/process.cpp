#include "process.h"
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
Process::Process(QObject *parent) : QProcess(parent) {

}

void Process::start(const QString &program, const QVariantList &arguments) {
    qputenv("CUTIE_SHELL", QByteArray("true"));
       qputenv("QT_QPA_PLATFORM", QByteArray("wayland"));
       qputenv("EGL_PLATFORM", QByteArray("wayland"));
       qunsetenv("QT_QPA_GENERIC_PLUGINS");
       qunsetenv("QT_IM_MODULE");
       qunsetenv("QT_SCALE_FACTOR");
      qputenv("WAYLAND_DISPLAY", "wayland-1");
    QStringList args;

    qDebug() << "Running" << program;
    // convert QVariantList from QML to QStringList for QProcess

    for (int i = 0; i < arguments.length(); i++)
        args.append(arguments[i].toString());

    QProcess proc;
    proc.setProgram(program);
    proc.startDetached();

}

QByteArray Process::readAll() {
    return QProcess::readAll();
}
