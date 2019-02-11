#pragma once
#include "datamodels_export.h"
#include <QtCore>

class QQuickItemGrabResult;

namespace models
{
class DATAMODELS_EXPORT LocationImageHandler
{
public:
  LocationImageHandler(const QString & imagesLocation);
  virtual ~LocationImageHandler();

  virtual QImage getImage(const QUrl & thumbnailUrl);
  virtual bool saveImage(QQuickItemGrabResult * imageSource, const QUrl & thumbnailUrl);
  virtual bool deleteImage(const QUrl & thumbnailUrl);

private:
  QDir imagesLocation_;
};
}
