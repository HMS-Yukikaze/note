#include "mainwindow.h"



MyWidget::MyWidget(QWidget *parent) : QWidget(parent) {
    QQuickWidget *quickWidget = new QQuickWidget(this);

    quickWidget->setSource(QUrl(QStringLiteral("qrc:/HomePage.qml")));
    quickWidget->setResizeMode(QQuickWidget::SizeRootObjectToView);

    // 设置布局
    QVBoxLayout *layout = new QVBoxLayout(this);
    layout->addWidget(quickWidget);
    setLayout(layout);

    // 获取 QML 根对象
    QObject *rootObject = (QObject*)quickWidget->rootObject();

    // 连接 QML 信号到 C++ 槽
    QObject::connect(rootObject, SIGNAL(buttonClicked()), this, SLOT(onButtonClicked()));
}
