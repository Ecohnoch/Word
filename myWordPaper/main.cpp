#include <QApplication>
#include <QtQml/QQmlApplicationEngine>

#include "robotfile.h"
int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    qmlRegisterSingletonType<RobotFile>("File", 1, 0, "File", &RobotFile::qmlSingleton);
    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
