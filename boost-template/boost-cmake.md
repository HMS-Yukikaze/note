Examples

仅查找 Boost 标头：
```
find_package(Boost 1.36.0)
if(Boost_FOUND)
  include_directories(${Boost_INCLUDE_DIRS})
  add_executable(foo foo.cc)
endif()
```

找到 Boost libraries 并使用导入的目标：
```
find_package(Boost 1.56 REQUIRED COMPONENTS
             date_time filesystem iostreams)
add_executable(foo foo.cc)
target_link_libraries(foo Boost::date_time Boost::filesystem
                          Boost::iostreams)
```

找到 Boost Python 3.6 libraries 并使用导入的目标：
```
find_package(Boost 1.67 REQUIRED COMPONENTS
             python36 numpy36)
add_executable(foo foo.cc)
target_link_libraries(foo Boost::python36 Boost::numpy36)
```
查找 Boost 标头和一些 static （仅限发布）库：

```
set(Boost_USE_STATIC_LIBS        ON)  # only find static libs
set(Boost_USE_DEBUG_LIBS        OFF)  # ignore debug libs and
set(Boost_USE_RELEASE_LIBS       ON)  # only find release libs
set(Boost_USE_MULTITHREADED      ON)
set(Boost_USE_STATIC_RUNTIME    OFF)
find_package(Boost 1.66.0 COMPONENTS date_time filesystem system ...)
if(Boost_FOUND)
  include_directories(${Boost_INCLUDE_DIRS})
  add_executable(foo foo.cc)
  target_link_libraries(foo ${Boost_LIBRARIES})
endif()
```