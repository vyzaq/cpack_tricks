#include "location_image_handler.h"
#include <QQuickItemGrabResult>

namespace models
{
QString filePathFromUrl(const QDir & root, const QUrl url)
{
  return root.filePath(url.path().remove(QRegExp("[\\/]?")));
}
LocationImageHandler::LocationImageHandler(const QString & imagesLocation)
  : imagesLocation_(imagesLocation)
{
  if(!imagesLocation_.exists())
  {
    imagesLocation_.mkdir(".");
  }
}

LocationImageHandler::~LocationImageHandler()
{
}

QImage LocationImageHandler::getImage(const QUrl & thumbnailUrl)
{
  QImage requiredImage;
  if(thumbnailUrl.isValid())
  {
    requiredImage.load(filePathFromUrl(imagesLocation_, thumbnailUrl));
  }
  return requiredImage;
}

bool LocationImageHandler::saveImage(QQuickItemGrabResult * imageSource, const QUrl & thumbnailUrl)
{
  if(!thumbnailUrl.isValid())
  {
    return false;
  }
  return imageSource->image().save(filePathFromUrl(imagesLocation_, thumbnailUrl));
}

bool LocationImageHandler::deleteImage(const QUrl & thumbnailUrl)
{
  return QFile::remove(filePathFromUrl(imagesLocation_, thumbnailUrl));
}

}


