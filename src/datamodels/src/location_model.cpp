#include "location_model.h"
#include <QQuickItemGrabResult>
#include "location_image_handler.h"

namespace models
{
QHash<int, QByteArray> LocationModel::roleNames() const
{
  return {{Name, "name"},{Position, "location"}, {Thumbnail, "thumbnail"}};
}

LocationModel::LocationModel(QWeakPointer<LocationImageHandler> imageStorage, QObject * parent)
  : QAbstractListModel (parent)
  , imageStorage_(imageStorage)
{

}

LocationModel::~LocationModel()
{

}

int LocationModel::rowCount(const QModelIndex & parent) const
{
  if(parent.isValid())
  {
    return 0;
  }
//  auto storage = storage_.lock();
//  if(!storage)
  {
    return 0;
  }
//  return storage->count();
}

QVariant LocationModel::data(const QModelIndex & index, int role) const
{
  if(index.parent().isValid() || index.column() != 0)
  {
    return {};
  }
//  auto storageLocked = storage_.lock();
//  if(!storageLocked)
  {
    return {};
  }

//  auto location = storageLocked->location(index.row());
//  switch(role)
//  {
//  case Name:
//    return location.name_;
//  case Position:
//    return QVariant::fromValue(location.position_);
//  case Thumbnail:
//    return location.thumbnail_;
//  default:
//    return {};
  }
}


