#ifndef UPDATEMANAGER_H
#define UPDATEMANAGER_H

#include <QObject>



class UpdateManager : public QObject
{
    Q_OBJECT
public:
    explicit UpdateManager(QObject *parent = 0);

signals:

public slots:
};

#endif // UPDATEMANAGER_H
