#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QImage>
#include <QProcess>
#include <QDebug>
#include <QDir>
#include <QFile>
#include <QVariantMap>
#include <QIcon>
#include <QScreen>
#include <QQuickWindow>
#include <qdiriterator.h>
#include <QSettings>
#include "image_provider.h"
#include "process.h"
#include "battery_handler.h"
#include "QThread"
#include "QTimer"
#include <networkbinder.h>
#include <QtDBus/QDBusConnection>
#include <QtDBus/QDBusConnectionInterface>
#include <QtDBus/QDBusServiceWatcher>
#include <examplethreads.h>
#include <display_brightness.h>
#include <hwbuttons.h>
#include <alsacontroller.h>
#include <globalparams.h>

struct AppInfo {
    QString name;
    QString icon = "application";
    QString exec;
};

constexpr auto DESKTOP_FILE_SYSTEM_DIR = "/usr/share/applications";
constexpr auto DESKTOP_FILE_USER_DIR = "%1/.local/share/applications";
constexpr auto DESKTOP_ENTRY_STRING = "Desktop Entry";

class AppReader {
public:
    AppReader(QSettings &settings, const QString &groupName)
            : m_settings(settings) {
        m_settings.beginGroup(groupName);
    }

    ~AppReader() {
        m_settings.endGroup();
    }

private:
    QSettings &m_settings;
};

QVariantList createAppsList(const QString &path) {
    QDirIterator it(path, {"*.desktop"}, QDir::NoFilter, QDirIterator::Subdirectories);
    QVariantList ret;

    while (it.hasNext()) {
        const auto filename = it.next();
        QSettings desktopFile(filename, QSettings::IniFormat);

        if (!desktopFile.childGroups().contains(DESKTOP_ENTRY_STRING))
            continue;

        AppReader reader(desktopFile, DESKTOP_ENTRY_STRING);

        AppInfo app;
        app.exec = desktopFile.value("Exec").toString().remove("\"").remove(QRegExp(" %.")).remove(QRegExp(" --")).remove(QRegExp(" -b"));
      //  app.icon =
           app.icon = "/usr/share/icons/Papirus/48x48/apps/"+  desktopFile.value("Icon", "application").toString()+".svg";
        if (desktopFile.value("Name").toString().length() > 14){
            QString short_value = desktopFile.value("Name").toString().mid(0,14);
            short_value.append("...");
            app.name = short_value;

        } else {
            app.name = desktopFile.value("Name").toString();
        }
        if(desktopFile.value("NoDisplay") != "true" && desktopFile.value("Hidden") != "true") {
            ret.append(QStringList{app.name, app.icon, app.exec});
        }

    }

    return ret;
}
QVariantList apps() {
    QVariantList ret;
    ret.append(createAppsList(DESKTOP_FILE_SYSTEM_DIR));
    ret.append(createAppsList(QString(DESKTOP_FILE_USER_DIR).arg(QDir::homePath())));
    return ret;
}




int main(int argc, char *argv[]) {


    const int qt_scale_factor=1;
    const int device_halium = 0; //if hybris device 1 else mainline 0
    if(device_halium==0){
    qputenv("QT_SCALE_FACTOR", "1");


    qputenv("QT_QPA_PLATFORM", "xcb");
   // qputenv("LD_LIBRARY_PATH", "/usr/local/lib:$LD_LIBRARY_PATH");
  //  qputenv(" -plugin", "libinput");
     qputenv("QT_IM_MODULE", "qtvirtualkeyboard");
     qputenv("QT_VIRTUALKEYBOARD_LAYOUT_PATH", "qrc:/layouts/");
     // qputenv("QT_QAYLAND_CLIENT_BUFFER_INTEGRATION", "wayland-egl");
    }else{
     
    }




     //  qputenv("XDG_RUNTIME_DIR", "XDG_RUNTIME_DIR=$HOME/.xdg");


    QCoreApplication::setOrganizationName("Tikhanov-Alexey-Dmitrievich");
    QCoreApplication::setApplicationName("Baikal-Phone-shell");

    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;
    //ExampleThreads threadA("nm");

globalParams gbp;
gbp.setScale(qt_scale_factor);


       //    threadA.start();    // Запускаем потоки



display_brightness lcd_brightness;
alsaController alsa_controller;

  HWButtons *hwbutton_controller = new HWButtons(&engine);


    const QUrl url(QStringLiteral("qrc:/main.qml"));
    engine.setOfflineStoragePath(QDir::homePath() + "/.fluid/");
    engine.addImageProvider("icons", new ImageProvider());
    auto offlineStoragePath = QUrl::fromLocalFile(engine.offlineStoragePath());
    engine.rootContext()->setContextProperty("offlineStoragePath", offlineStoragePath);
    engine.rootContext()->setContextProperty("apps", apps());
    engine.rootContext()->setContextProperty("proc", new Process(&engine));
    engine.rootContext()->setContextProperty("battery_handler", new battery_handler());
    engine.rootContext()->setContextProperty( "displayBrightness", &lcd_brightness);
    engine.rootContext()->setContextProperty( "alsaController", &alsa_controller);
    engine.rootContext()->setContextProperty( "globalParams", &gbp);

   // engine.rootContext()->setContextProperty( "hwbuttons", hwbutton_controller);
      app.installEventFilter(hwbutton_controller);
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}

