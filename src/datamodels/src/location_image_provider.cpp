#include "location_image_provider.h"
#include <QQuickItem>
#include "types/definitions.h"
#include "location_image_handler.h"


namespace models
{

LocationImageProvider::LocationImageProvider(QWeakPointer<LocationImageHandler> locationHandler)
  : QQuickImageProvider(QQmlImageProviderBase::Image, QQmlImageProviderBase::ForceAsynchronousImageLoading)
  , locationHandler_(locationHandler)
{
}

LocationImageProvider::~LocationImageProvider()
{
}

QImage LocationImageProvider::requestImage(const QString & id, QSize * size, const QSize & requestedSize)
{
  auto locationHandlerLocked = locationHandler_.lock();
  if(!locationHandlerLocked)
  {
    return {};
  }
  return locationHandlerLocked->getImage(id);
}
}


