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
2. threadpool
```
#include <iostream>
#include <vector>
#include <deque>
#include <thread>
#include <mutex>
#include <condition_variable>
#include <atomic>
#include <functional>
#include <random>

class Task {
public:
    virtual void execute() = 0;
    virtual ~Task() = default;
};

class ThreadPool {
public:
    ThreadPool(size_t numThreads) : stop(false) {
        for (size_t i = 0; i < numThreads; ++i) {
            workers.emplace_back([this, i] {
                std::deque<std::unique_ptr<Task>> localQueue;
                while (true) {
                    std::unique_ptr<Task> task;
                    {
                        std::unique_lock<std::mutex> lock(queueMutex);
                        condition.wait(lock, [this, &localQueue] {
                            return stop || !globalQueue.empty() || !localQueue.empty();
                        });

                        if (stop && globalQueue.empty() && localQueue.empty()) {
                            break;
                        }

                        if (!localQueue.empty()) {
                            task = std::move(localQueue.front());
                            localQueue.pop_front();
                        } else if (!globalQueue.empty()) {
                            task = std::move(globalQueue.front());
                            globalQueue.pop_front();
                        }
                    }

                    if (task) {
                        task->execute();
                    } else {
                        // Try to steal a task from another worker
                        task = stealTask(i);
                        if (task) {
                            task->execute();
                        }
                    }
                }
            });
        }
    }

    ~ThreadPool() {
        {
            std::unique_lock<std::mutex> lock(queueMutex);
            stop = true;
        }
        condition.notify_all();
        for (std::thread &worker : workers) {
            worker.join();
        }
    }

    template<class F, class... Args>
    void enqueue(F&& f, Args&&... args) {
        auto task = std::make_unique<FunctionTask<F, Args...>>(std::forward<F>(f), std::forward<Args>(args)...);
        {
            std::unique_lock<std::mutex> lock(queueMutex);
            globalQueue.emplace_back(std::move(task));
        }
        condition.notify_one();
    }

private:
    struct TaskWrapper {
        std::deque<std::unique_ptr<Task>> tasks;
        std::mutex mutex;
    };

    std::unique_ptr<Task> stealTask(size_t victimIndex) {
        for (size_t i = 0; i < workers.size(); ++i) {
            size_t idx = (victimIndex + i) % workers.size();
            if (idx == victimIndex) continue; // Don't steal from yourself
            std::unique_lock<std::mutex> lock(taskWrappers[idx].mutex);
            if (!taskWrappers[idx].tasks.empty()) {
                auto task = std::move(taskWrappers[idx].tasks.back());
                taskWrappers[idx].tasks.pop_back();
                return task;
            }
        }
        return nullptr;
    }

    template<class F, class... Args>
    class FunctionTask : public Task {
    public:
        FunctionTask(F&& f, Args&&... args)
            : func(std::bind(std::forward<F>(f), std::forward<Args>(args)...)) {}

        void execute() override {
            func();
        }

    private:
        std::function<void()> func;
    };

    std::vector<std::thread> workers;
    std::vector<TaskWrapper> taskWrappers;
    std::deque<std::unique_ptr<Task>> globalQueue;
    std::mutex queueMutex;
    std::condition_variable condition;
    std::atomic<bool> stop;
};
```
