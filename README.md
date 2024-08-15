# designed pattern
# environment
## debug environment
- llvm
- clang
- lldb
## debug configuration
launch.json:
```
{
    "version": "0.2.0",
    "configurations": [
        {
            "type": "lldb",
            "request": "launch",
            "name": "c++ lldb",
            "program": "${workspaceFolder}/build/designed_pattern",
            "args": [],
            "cwd": "${workspaceFolder}",
            "preLaunchTask": "CMake: Build All"
        }
    ]
}
```
1. Singleton pattern

