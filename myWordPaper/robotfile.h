#ifndef ROBOTFILE_H
#define ROBOTFILE_H

#include <QDebug>
#include <QObject>
#include <QtCore>

class QQmlEngine;
class QJSEngine;
class RobotFile : public QObject
{
    Q_OBJECT
public:
    // ------------------ Singleton Func -----------------------
    Q_DISABLE_COPY(RobotFile)
    RobotFile() {}
public:
    static QObject* qmlSingleton(QQmlEngine *engine, QJSEngine *scriptEngine){
        Q_UNUSED(engine);
        Q_UNUSED(scriptEngine);
        static RobotFile* _singleton=nullptr;
        if(!_singleton)
            _singleton=new RobotFile;
        return _singleton;
    }

    static RobotFile* singleton(){
        return qobject_cast<RobotFile*>(qmlSingleton(nullptr,nullptr));
    }

    // ------------------ QML Property -----------------------


    // ------------------- QML Func ---------------------------
    //  File Path
    Q_INVOKABLE QString dataPath(QString file){
        QString path=QStandardPaths::writableLocation(QStandardPaths::AppDataLocation);
        QDir dir(path);
        if(!dir.exists())
            dir.mkpath(path);
        return path+'/'+file;
    }

    Q_INVOKABLE bool exist(QString path){
        return QFile(path).exists();
    }

    Q_INVOKABLE QString resourcePath(QString file){
        return QString(":/")+file;
    }

    //  File IO
    Q_INVOKABLE QString read(QString path){
        QFile f(path);
        if(!f.exists()) return "";
        if(!f.open(QIODevice::ReadOnly)) return "";
        QByteArray byteArray(f.readAll());
        f.close();
        return QString(byteArray);  // maybe empty
    }

    Q_INVOKABLE bool write(QString path, QString data){
        QFile f(path);
        if(!f.open(QIODevice::WriteOnly)) return false;
        if(f.write(data.toUtf8())==-1){     // writing failed
            f.close();
            return false;
        }else{
            f.close();
            return true;
        }
    }
    Q_INVOKABLE bool remove(QString path){
        QFile f(path);
        return f.remove();
    }

    // ------------------- C++ Func ---------------------------

    // ------------------- Private Func ---------------------------
private:
};


#endif // ROBOTFILE_H
