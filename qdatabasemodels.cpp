#include "qdatabasemodels.h"
#include <QSqlError>

QSqlQmlTableModel::QSqlQmlTableModel(QSqlDatabase db):QSqlTableModel(Q_NULLPTR,db)
{
    setEditStrategy(QSqlTableModel::OnManualSubmit);

}

bool QSqlQmlTableModel::selectTable(const QString &tableName)
{
    setTable(tableName);
    QSqlError err = lastError();
    if (err.isValid()){
        qCritical() << "Error with setTable:" << err.text();
        return false;
    }

    if ( !generateRoleNames()) return false;


    return select();

}



QVariant QSqlQmlTableModel::data ( const QModelIndex & index, int role ) const
{
    if(index.row() >= rowCount())
        return QString("");

    if(role < Qt::UserRole)
        return QSqlQueryModel::data(index, role);
    else
    {
        int columnIdx = role - Qt::UserRole - 1;
        QModelIndex modelIndex = this->index(index.row(), columnIdx);
        QVariant value = QSqlQueryModel::data(modelIndex, Qt::DisplayRole);
        return value;
    }
}
bool QSqlQmlTableModel::generateRoleNames()
{

    roles.clear();
    int nbCols = this->columnCount();
    //qInfo() << "Retrieve " << nbCols << "field from table";
    for (int i = 0; i < nbCols; i++)
        roles[Qt::UserRole + i + 1] = QVariant(this->headerData(i, Qt::Horizontal).toString()).toByteArray();
    return nbCols > 0;
}

int QSqlQmlTableModel::selectedRow()
{
    return m_selectedRow;
}

void QSqlQmlTableModel::setSelectedRow(int _selectedRow)
{
    m_selectedRow = _selectedRow;
    m_selectedRecord = record(m_selectedRow);
    emit   selectedRowChanged();
}

QVariant QSqlQmlTableModel::selectedData(QString fieldName)
{
   //qDebug() << m_selectedRecord;
    QVariant var = m_selectedRecord.value( fieldName);
    return var;
}
