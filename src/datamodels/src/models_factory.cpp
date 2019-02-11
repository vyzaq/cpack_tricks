#include "models_factory.h"
#include "location_model.h"
#include <QFutureWatcher>
#include <QtCore>

namespace models
{

ModelsFactory::ModelsFactory(std::function<QWeakPointer<LocationImageHandler>()> locationImageAccessor,
                             QObject * parent)
  : QObject(parent)
  , locationImageAccessor_(locationImageAccessor)
{
}

ModelsFactory::~ModelsFactory()
{
}

QObject * ModelsFactory::createLocationModel(QObject * parent)
{
  return new LocationModel(locationImageAccessor_(), parent);
}

}
