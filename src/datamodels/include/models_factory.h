#pragma once
#include "datamodels_export.h"
#include <QtCore>
#include <functional>

namespace models
{
class LocationModel;
class LocationImageHandler;
class DATAMODELS_EXPORT ModelsFactory : public QObject
{
  Q_OBJECT
public:
  ModelsFactory(std::function<QWeakPointer<LocationImageHandler>()> locationImageAccessor,
                QObject * parent = nullptr);
  virtual ~ModelsFactory();

  Q_INVOKABLE QObject * createLocationModel(QObject * parent);
private:
  std::function<QWeakPointer<LocationImageHandler>()> locationImageAccessor_;
};
}
