#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQml>

#include "multiplayer.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    qmlRegisterType<Multiplayer>("Sam.Multiplayer", 1, 0, "Multiplayer");
    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
