# QtLearn2
QWidget 应用程序中与 QML 进行交互，几种常见的方式:
1. 使用 QQuickWidget 嵌入 QML:
QQuickWidget 继承自 QWidget，可以将 QML 视图嵌入到 QWidget 中。可以使用 QQuickWidget::setSource() 方法加载 QML 文件，并通过 rootObject() 获取 QML 的根对象，以便与其交互。
可以通过 findChild 方法找到 QML 中的子项，并直接访问和操作它们。
2. 通过 QQuickView 显示 QML:
QQuickView 也是一个常用的类，它可以将 QML 视图作为一个独立的窗口嵌入到 QWidget 中。可以通过 QQuickView 的 rootObject() 获取 QML 的根对象，并通过信号和槽进行交互。
这个方法更适合需要显示全屏 QML 内容的情况。
3. C++ 与 QML 通过 QObject 信号和槽进行交互:
可以在 C++ 中定义 QObject 类，并将其暴露给 QML，使得 QML 可以连接到这些对象的信号和槽。这种方式适用于需要频繁交互的场景，如实时数据更新、事件响应等。
可以通过 setContextProperty 将 C++ 对象暴露给 QML，从而在 QML 中访问该对象。
4. 使用 QML 的 C++ 扩展:
可以将 C++ 类型注册到 QML 中，使得它们可以作为普通 QML 对象在 QML 中使用。通过 qmlRegisterType 或 qmlRegisterSingletonType 可以将自定义 C++ 类注册到 QML 中，供 QML 使用。
5. 通过 QML 与 C++ 的 Properties 进行交互:
可以在 C++ 对象中定义 Q_PROPERTY，并将这些属性暴露给 QML。QML 可以访问并修改这些属性，同时 C++ 也可以响应 QML 中对这些属性的更改。