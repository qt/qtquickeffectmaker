// Copyright (C) 2022 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QtCore/QCommandLineParser>
#include "src/effectmanager.h"
#include "src/nodeview.h"
#include "src/propertyhandler.h"
#include "src/fpshelper.h"
#include "src/syntaxhighlighter.h"
#include "src/qsbinspectorhelper.h"

#ifdef _WIN32
#include <Windows.h>
#endif

#define APP_VERSION_STR "0.40"

int main(int argc, char *argv[])
{
#ifdef _WIN32
    if (AttachConsole(ATTACH_PARENT_PROCESS)) {
        FILE *out, *err;
        freopen_s(&out, "CONOUT$", "w", stdout);
        freopen_s(&err, "CONOUT$", "w", stderr);
    }
#endif
    QGuiApplication app(argc, argv);
    app.setOrganizationName("The Qt Company");
    app.setOrganizationDomain("qt.io");
    app.setApplicationName("Qt Quick Effect Maker");
    app.setApplicationVersion(QLatin1String(APP_VERSION_STR));
    QQmlApplicationEngine engine;

    // Setup command line arguments
    QCommandLineParser cmdLineParser;
    cmdLineParser.addHelpOption();
    cmdLineParser.addVersionOption();

    // Add the cmd options
    QCommandLineOption effectsPath("effectspath",
                                   QStringLiteral("Path for effects in spcific QDS project"), "_");
    QCommandLineOption projectPath("projectpath",
                                   QStringLiteral("Effects project file (*.qep) to open"), "_");
    cmdLineParser.addOptions({effectsPath, projectPath});
    cmdLineParser.setOptionsAfterPositionalArgumentsMode(QCommandLineParser::ParseAsOptions);

    // Parsing args
    bool parsed = cmdLineParser.parse(app.arguments());
    if (!parsed) {
        auto parseError = cmdLineParser.errorText();
        qWarning() << qPrintable("Error: " + parseError);
        return 1;
    }

    // Store args
    if (cmdLineParser.isSet(effectsPath)) {
        auto val = cmdLineParser.value(effectsPath);
        g_propertyData.insert("effects_path", QVariant(val));
    }
    if (cmdLineParser.isSet(projectPath)) {
        auto val = cmdLineParser.value(projectPath);
        g_propertyData.insert("effects_project_path", QVariant(val));
    }

    qmlRegisterType<EffectManager>("QQEMLib", 1, 0, "EffectManager");
    qmlRegisterType<NodeView>("QQEMLib", 1, 0, "NodeViewItem");
    qmlRegisterType<FpsHelper>("QQEMLib", 1, 0, "FpsHelper");
    qmlRegisterType<SyntaxHighlighter>("QQEMLib", 1, 0, "SyntaxHighlighter");
    qmlRegisterType<QsbInspectorHelper>("QQEMLib", 1, 0, "QsbInspectorHelper");

    QQmlContext *context = engine.rootContext();
    if (context) {
        context->setContextProperty("g_propertyData", &g_propertyData);
        context->setContextProperty("buildQtVersion", QLatin1String(QT_VERSION_STR));
    } else {
        qWarning("Unable to get access into root QQmlContext!");
    }

    const QUrl url(QStringLiteral("qrc:/qml/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
