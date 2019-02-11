#pragma once
#include <QtGui>
#include <QApplication>
#include <QtNetwork>

class QQmlEngine;
class QJSEngine;

namespace models
{
class LocationImageHandler;
}

namespace core
{
class AppCore : public QApplication
{
  Q_OBJECT
public:
  AppCore(int &argc, char **argv);
  virtual ~AppCore();

  int start();
private:
  void registerQmlTypes();
  static QObject * modelsFactoryCreator(QQmlEngine *engine, QJSEngine *scriptEngine);
  static QObject * locationImageHandlerCreator(QQmlEngine *engine, QJSEngine *scriptEngine);

  QSettings settings_;
  QSharedPointer<QNetworkAccessManager> networkManager_;
  QSharedPointer<models::LocationImageHandler> imageHandler_;
};
}
