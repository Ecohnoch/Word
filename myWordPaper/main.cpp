#include <QApplication>
#include <QtQml/QQmlApplicationEngine>

#include "robotfile.h"
int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    app.setApplicationName("凤鸣Word");
    app.setApplicationVersion("1.3");
    app.setOrganizationName("Ecohnoch(XCY)");
    app.setOrganizationDomain("www.github.com/ecohnoch");
    qmlRegisterSingletonType<RobotFile>("File", 1, 0, "File", &RobotFile::qmlSingleton);
    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
