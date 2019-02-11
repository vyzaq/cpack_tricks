#pragma once
#include "datamodels_export.h"
#include <QtCore>

namespace models
{
class LocationImageHandler;
class DATAMODELS_EXPORT LocationModel : public QAbstractListModel
{
  Q_OBJECT
  Q_ENUMS(ValidationErrors)
public:
  enum Roles
  {
    Name,
    Position,
    Thumbnail
  };

  enum ValidationErrors
  {
    Ok,
    InvalidCharacters,
    TooShort,
    TooLong,
    Duplicated
  };

  LocationModel(QWeakPointer<LocationImageHandler> imageStorage, QObject * parent = nullptr);
  virtual ~LocationModel() override;

  // QAbstractItemModel interface
  virtual int rowCount(const QModelIndex & parent) const override;
  virtual QVariant data(const QModelIndex & index, int role) const override;
  virtual QHash<int, QByteArray> roleNames() const override;

private:
  void saveThumbnailToStorage(const QUrl & thumbnailUrl, const QVariant & thumbnailStorage);
  void removeThumbnailFromStorage(const QUrl & thumbnailUrl);
  QWeakPointer<LocationImageHandler> imageStorage_;
};
}
