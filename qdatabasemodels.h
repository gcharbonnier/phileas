#ifndef QENTERPRISEMODEL_H
#define QENTERPRISEMODEL_H

#include <QObject>
#include <QDebug>
#include <QSqlTableModel>
#include <QSqlRecord>
#include <QSqlField>


class QSqlQmlTableModel : public QSqlTableModel
{
    Q_OBJECT
    Q_PROPERTY(int selectedRow READ selectedRow WRITE setSelectedRow NOTIFY selectedRowChanged)
public:
    QSqlQmlTableModel(QSqlDatabase db = QSqlDatabase::database());
    Q_INVOKABLE QVariant data(const QModelIndex &index, int role=Qt::DisplayRole ) const;

    virtual QHash<int, QByteArray> roleNames() const{return roles;}
    bool selectTable(const QString &tableName);

    Q_INVOKABLE QVariant getdata(int row, int columnIdx){
        QModelIndex modelIndex = this->index(row, columnIdx);

        return  QSqlQueryModel::data(modelIndex, Qt::DisplayRole);

    }

    int selectedRow();
    void setSelectedRow(int _selectedRow);

    Q_INVOKABLE QVariant selectedData( QString fieldName);

signals:
    void selectedRowChanged();

private:
    bool generateRoleNames();
    bool removeDynamicProperties();
    bool createDynamicProperties();
    QHash<int, QByteArray> roles;
    int m_selectedRow = -1;
    QSqlRecord m_selectedRecord;
};




#endif // QENTERPRISEMODEL_H
