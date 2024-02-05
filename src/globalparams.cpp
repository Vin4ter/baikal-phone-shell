#include "globalparams.h"

globalParams::globalParams(QObject *parent) : QObject(parent)
{

}

void globalParams::setScale(int scale)
{
  g_scale = scale;

}

void globalParams::getScale()
{
     emit set_qml_scale(g_scale);
}
