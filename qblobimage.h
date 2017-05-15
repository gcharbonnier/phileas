#ifndef QBLOBIMAGE_H
#define QBLOBIMAGE_H

#include <QObject>
#include <QQuickPaintedItem>
#include <QImage>
#include <QPainter>

class QBlobImage : public QQuickPaintedItem
{
    Q_OBJECT
    Q_PROPERTY(QImage image READ image WRITE setImage NOTIFY imageChanged)
    Q_PROPERTY(QByteArray imageData READ imageData WRITE setImageData NOTIFY imageChanged)

public:
    explicit QBlobImage (QQuickItem *parent = Q_NULLPTR) : QQuickPaintedItem(parent) {}

    QImage image() const { return m_image; }
    void setImage(const QImage &image);
    QByteArray imageData() const { /*qDebug() << "imageData";*/return QByteArray(); }
    void setImageData(const QByteArray &byteArray);

    void paint(QPainter *painter) Q_DECL_OVERRIDE;
signals :
    void imageChanged();
    void imageDataChanged();
private:
    QImage m_image = QImage();
    //QByteArray m_imageData;
};


#endif // QBLOBIMAGE_H
