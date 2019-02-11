#include "core/app_core.h"
#include <QtQuick>
#include <QQuickStyle>
#include <exception>

#include "types/definitions.h"
#include "location_model.h"
#include "location_image_provider.h"
#include "location_image_handler.h"
#include "models_factory.h"

namespace core
{

namespace
{
const char * coreQmlName = "applicationCore";
}

AppCore::AppCore(int & argc, char ** argv)
  : QApplication (argc, argv)
  , settings_(QSettings::IniFormat, QSettings::UserScope, definitions::organizationName, definitions::productName)
  , networkManager_(new QNetworkAccessManager)
{
  QDir appDir(applicationDirPath());
  auto imagesLocation = settings_.value(definitions::settings::centralStorageLocationPropertyName, appDir.filePath("locationThumbnails"));
  if(!imagesLocation.canConvert<QString>())
  {
    throw std::runtime_error("Settings corrupted. Can't read images location");
  }
  imageHandler_.reset(new models::LocationImageHandler(imagesLocation.toString()));

  setAttribute(Qt::AA_EnableHighDpiScaling);
  QQuickStyle::setStyle("Material");
}

AppCore::~AppCore()
{
}

int AppCore::start()
{
  QQmlApplicationEngine engine;
  engine.addImportPath("qrc:///modules");
  engine.setProperty(coreQmlName, QVariant::fromValue(this));
  engine.rootContext()->setContextProperty(coreQmlName, this);

  engine.addImageProvider(QLatin1String(definitions::locationThumbnailImageProviderName), new models::LocationImageProvider(imageHandler_));

  registerQmlTypes();
  engine.rootContext()->setContextProperty("applicationDirPath", QGuiApplication::applicationDirPath());

  engine.load(QUrl("qrc:///main.qml"));
  return exec();
}

void AppCore::registerQmlTypes()
{
  qmlRegisterSingletonType<models::ModelsFactory>("DemoAppModels", 1, 0, "ModelFactory", AppCore::modelsFactoryCreator);
  qmlRegisterUncreatableType<models::LocationModel>("DemoAppModels", 1, 0, "LocationModel", "For C++ creation only");
}


QObject * AppCore::modelsFactoryCreator(QQmlEngine *engine, QJSEngine *scriptEngine)
{
  Q_UNUSED(scriptEngine);
  std::function<QWeakPointer<models::LocationImageHandler> ()> locationImageAccessor = [](){return QWeakPointer<models::LocationImageHandler>();};

  auto appCoreVariant = engine->property(coreQmlName);
  if(appCoreVariant.canConvert<AppCore *>())
  {
    AppCore * core = appCoreVariant.value<AppCore *>();
    locationImageAccessor = [=]() { return core->imageHandler_; };
  }
  return new models::ModelsFactory(locationImageAccessor);
}


}
