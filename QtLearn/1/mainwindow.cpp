#include "mainwindow.h"
#include "./ui_mainwindow.h"
#include <fmt/format.h>

MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::MainWindow)
{
    ui->setupUi(this);
    // 创建 QQuickWidget 实例
    auto quickWidget = new QQuickWidget(this);
    quickWidget->setSource(QUrl(QStringLiteral("qrc:/Mtest.qml"))); // 设置 QML 文件路径
    quickWidget->setResizeMode(QQuickWidget::SizeRootObjectToView);

    auto mainLayout=new QVBoxLayout;
    mainLayout->addWidget(quickWidget);

    ui->centralwidget->setLayout(mainLayout);

    quickWidget->show();






}

MainWindow::~MainWindow()
{
    delete ui;
}
