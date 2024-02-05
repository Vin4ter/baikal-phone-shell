#ifndef GLOBALPARAMS_H
#define GLOBALPARAMS_H

#include <QObject>

class globalParams : public QObject
{
    Q_OBJECT
public:
    explicit globalParams(QObject *parent = nullptr);
    int g_scale=1;
public slots:
   void setScale(int scale);
   void getScale();

signals:
 void set_qml_scale(int scale);
};

#endif // GLOBALPARAMS_H
