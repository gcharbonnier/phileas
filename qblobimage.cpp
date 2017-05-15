#include <QBuffer>
#include "qblobimage.h"


void QBlobImage::setImageData(const QByteArray &byteArray)
{
    if (byteArray.isNull()) return;

    QByteArray b2 = byteArray;
    QBuffer buffer(&b2);
    m_image.load(&buffer, "PNG");
    emit imageDataChanged();
    update();

    setImplicitWidth(m_image.width());
    setImplicitHeight(m_image.height());

}

void QBlobImage::setImage(const QImage &image)
{
    if (image.isNull()) return;

    m_image = image;

    emit imageChanged();
    update();

    setImplicitWidth(m_image.width());
    setImplicitHeight(m_image.height());
}

void QBlobImage::paint(QPainter *painter)
{
    if (m_image.isNull()) return;
    QImage scaledImg = m_image.scaled(width(), height(), Qt::KeepAspectRatio);
    painter->drawImage(QPoint((width()-scaledImg.width())/2,(height()-scaledImg.height())/2), scaledImg);
}
