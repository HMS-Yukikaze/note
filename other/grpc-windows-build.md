## grpc c++ windows build by cmake

## 下载源码

```
git clone -b RELEASE_TAG_HERE https://github.com/grpc/grpc
> cd grpc
> git submodule update --init
```
RELEASE_TAG_HERE 为release版本号  

## 安装环境配置
1. Install Visual Studio 2019 or later (Visual C++ compiler will be used).
2. Install Git.
3. Install CMake.
4. Install nasm and add it to PATH (choco install nasm) - required by boringssl  
5. (Optional) Install Ninja (choco install ninja)  
**注**:Ninja为可选项


## Cmake从源码构建grpc  
**命令行**
```
> md .mbuild
> cd .mbuild
> cmake .. -G "Visual Studio 16 2019"
> cmake --mbuild . --config Release
```
**GUI**
如图：
![](./Cmakecfg.PNG)

**遇到的问题**：
``git submodule update --init``` 失败
解决办法：使用git 代理
1. cd grpc
2. 找到./.git/config文件夹
3. 将url前加上文件代理加速下载服务的地址，这里推荐一个[ghproxy](https://ghproxy.com/)
4. 重新执行命令 `git submodule update --init`
设置git  socks5代理：
```
git config --global http.proxy socks5 127.0.0.1:7890
git config --global https.proxy socks5 127.0.0.1:7890
```
设置git  http/https 代理：
```
git config --global http.proxy 127.0.0.1:7890
git config --global https.proxy 127.0.0.1:7890
```

``git submodule update --init --recursive``` 
递归地初始化和更新存储库中的所有子模块。

## grpc windows 服务端开发

1. 编写.proto文件，在 .proto 文件中添加 gRPC 服务定义  
   eg:  
   ```
   //test.proto
   syntax = "proto3";

   package helloworld;

   // rpc请求的定义
   message HelloRequest {
   optional string name = 1;
   }
   // rpc响应的定义
   message HelloReply {
   optional string message = 1;
   }
   
   // gRPC服务的定义
   service Greeter {
    // Sends a greeting
    rpc SayHello(HelloRequest) returns(HelloReply) {}
    }
    ```

- 添加了“package”语句，用于标识此文件的协议包名称  
- 将服务名称为“Greeter”  
- 使用“rpc”关键字定义 gRPC 服务的方法  
- 使用“message”关键字定义请求和响应  

2. 通过**protoc**命令生成`c++`代码
    `<path to protoc.exe> --grpc_out=. --cpp_out=. --plugin=protoc-gen-grpc=<path to grpc_cpp_plugin.exe> <your proto file>.proto`  

3. 编写对应的服务端与客户端代码


// Enum to represent severity levels
enum Severity {
   LOW = 0;
   MEDIUM = 1;
   HIGH = 2;
}

enum Type {
   intrusion=0;      
   fireSmoke=1;      
   cloth=2;          
   smoking=3;        
   mobliePhone=4;    
   fallDown=5;      
   patrol=6;         
}

message PatorlEvent {
   bool isPassed = 1;
   uint32 Pos = 2;                   
   uint64 eventId = 3;               
   int64 cameraID = 4;              
   google.protobuf.TimeStamp arriveTime = 5;         
   string picFullPath = 6;          
}


message StartAlam {
   uint64 eventId = 1;               
   int64 cameraID = 2;               //相机id
   string alarm_description = 3;     //描述
   google.protobuf.TimeStamp StartTime = 4;          //报警起始时间
   Severity severity = 5;            //危险等级
   Type  alarmType  = 6;             //报警类型
   string picFullPath = 7;           //报警图片(完整路径)
 }

 message EndAlarm {
   uint64 eventId = 1;               //报警事件唯一标识
   int64 cameraID = 2;               //相机id
   string alarm_description = 3;     //描述
   google.protobuf.TimeStamp endTime = 4;            //报警结束时间
   string vidFullPath = 5;           //报警视频(完整路径)
 }

 message Rectangle {
   uint64 eventId = 1;               //唯一标识
   
   Point LT = 2;                     //左上角坐标
 
   Point RB = 3;                      //右上角坐标
 }

 message Response {
   int32  retCode = 1;                 //响应码
   string detail  = 2;                 //描述
 }

 service AlarmService {
   rpc SendStartAlam(stream StartAlam) returns (Response);  //发送报警开始消息

   rpc SendEndAlarm(stream EndAlarm) returns (Response);    //发送报警结束消息

   rpc SendRealTimeRect(stream Rectangle)returns (Response); //发送报警框

   rpc PostPatorlEvent(stream PatorlEvent) returns (Response);//发送巡检事件
 }






