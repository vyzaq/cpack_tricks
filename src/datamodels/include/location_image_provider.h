#pragma once
#include <functional>
#include "datamodels_export.h"
#include <QQuickImageProvider>
#include <QtCore>

namespace models
{
class LocationImageHandler;
class DATAMODELS_EXPORT LocationImageProvider : public QQuickImageProvider
{
public:
  LocationImageProvider(QWeakPointer<LocationImageHandler> locationHandler);
  virtual ~LocationImageProvider() override;

  // QQuickImageProvider interface
  virtual QImage requestImage(const QString & id, QSize * size, const QSize & requestedSize) override;
private:
  QWeakPointer<LocationImageHandler> locationHandler_;
};
}
