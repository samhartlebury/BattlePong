#ifndef MULTIPLAYER_H
#define MULTIPLAYER_H

#include <QObject>
#include <QTcpSocket>

class Multiplayer : public QObject
{
    Q_OBJECT
public:
    explicit Multiplayer(QObject *parent = 0);

    QStringList messageList;

public slots:
    void login(const QString &userName);
    void say(const QString &message);
    void readyRead();
    void connected();

signals:
    void connectionStateChanged(bool connected);
    void messageReceived(QString message);
    void userReceived(QStringList userList);
    void positionReceived(qreal position);

private:
    QString m_userName;
    QTcpSocket *socket;
};

#endif // MULTIPLAYER_H
