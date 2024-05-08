# boost cmake build
在 Linux 下，只需要在链接中使用 .a 的静态库就行了。以 boost 为例，CMake 自带的 FindBoost 就可以指定搜索静态库
```
set(Boost_USE_STATIC_LIBS ON)
set(Boost_USE_STATIC_RUNTIME ON)
```

同理,当想使用动态库时
```
set(Boost_USE_STATIC_LIBS OFF)
set(Boost_USE_MULTITHREADED ON)#多线程,非必需
set(Boost_USE_STATIC_RUNTIME OFF)
```

查找 Boost 标头和一些 static （仅发布）库：
```
set(Boost_USE_STATIC_LIBS        ON)  # 只查找静态库
set(Boost_USE_DEBUG_LIBS        OFF)  # 忽略debug库
set(Boost_USE_RELEASE_LIBS       ON)  # 只查找release库
set(Boost_USE_MULTITHREADED      ON)
set(Boost_USE_STATIC_RUNTIME    OFF)
find_package(Boost 1.66.0 COMPONENTS date_time filesystem system ...)
if(Boost_FOUND)
  include_directories(${Boost_INCLUDE_DIRS})
  add_executable(foo foo.cc)
  target_link_libraries(foo ${Boost_LIBRARIES})
endif()
```
