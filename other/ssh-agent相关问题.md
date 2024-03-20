ssh-agent 工作原理：（本地客户端）

ssh-agent 工作原理

如何配置 ssh agent
首先需要运行 ssh agent

在 Linux 中： ssh-agent 在 X 会话 或 **登录会话 **之初就已经启动
在 Windows 中： 计算机管理 👉 服务 👉 OpenSSH Authentication Agent 设置为自动 启动。
在 Windows 中更多配置 ssh-agent 自动启动的方法，见下文的 “配置 ssh-agent 自 动启动” 。
也可以手动运行，有两条命令可以用来启动：

ssh-agent $SHELL ：它会在当前 shell 中启动一个默认 shell，作为当前 shell 的 子 shell，ssh-agent 会在子 shell 中运行；也可以明确指定 $SHELL ，比如 ssh-agent bash ， ssh-agent 会随者当前 ssh 会话的结束而结束，这是一种安全 机制。
eval `shell-agent` ， 在 windows 中为 eval $(ssh-agent) ： 它并不会启动一 个子 shell，而是直接启动一个 ssh-agent 进程；此时当我们退出当前 bash 后 ，ssh-agent 进程并不会自动关闭。我们可以在当前 bash 退出之前，使用 ssh-agent -k ，或者在当前 bash 退出之后，使用 kill 命令，关闭对应的 ssh-agent 进程。
运行 ssh agent 以后，会加载默认的私钥，

如果有多个密钥，则需要在 ~/.ssh/config 中进行配置：

一般来说 ssh agent 程序可以根据配置自动加载并管理这些密钥；但如果发现某个密钥 没有加载则

也可以手动使用 ssh-add 命令将某个私钥交给 ssh-agent 保管，

ssh-agent 相关问题
当我们在中尝试使用 Git 并通过 SSH 协议进行 push 或 pull 时，如果远程 Github 服务 器无法使用 SSH agent 提供的密钥进行身份验证，则可能会收到下面的某一条消息：

Permission denied (publickey)
No suitable response from remote
repository access denied
可能的两种原因：

你的 公钥 并没有添加到 Github 服务器中。检查 GitHub 是否有添加。

您的密钥未加载到 ssh agent 中 。解决方法：

检查相应的 ssh 密钥是否被加载：
ssh-add -l
如果没有被加载，则使用下面的命令加载私钥
#后面可以同时跟多个私钥
ssh-add ~/.ssh/<private_key_file>
运行 ssh-add 时， 如果提示 “Could not open a connection to your authentication agent.” 说明你的ssh-agent并没有运行；使用下面的命令运行 ssh agent，再使用ssh-add命令添加你的 ssh key。
# 先启动，再运行
# macOS/Linux
$ eval `ssh-agent`
ssh-add ~/.ssh/other_id_rsa

# 在Windows中的git-bash中
$ eval $(ssh-agent)
ssh-add ~/.ssh/other_id_rsa
配置 ssh-agent 自动启动
在 Linux 中 ssh-agent 在 X 会话 或 登录会话 之初就已经启动，一般都不 会有问题。

而在 Windows 中，我们可以这样配置：

在 计算机管理 👉 服务 👉 OpenSSH Authentication Agent 设置为自动启动。
也可以为 git bash 、 powershell 和 cmder 分别添加如下配置
git bash
方式一： Git for windows 提供的方式

在 .profile 或 .bashrc 添加 ：

# 在.profile 或  .bashrc 添加
# Git for windows 提供的方式
# ssh-agent auto-launch (0 = agent running with key; 1 = w/o key; 2 = not run.)
agent_run_state=$(ssh-add -l >| /dev/null 2>&1; echo $?)
if   [ $agent_run_state = 2 ]; then
  eval $(ssh-agent -s)
  ssh-add ~/.ssh/one_rsa # 添加你自己的私钥
  ssh-add ~/.ssh/two_rsa
elif [ $agent_run_state = 1 ]; then
  ssh-add ~/.ssh/one_rsa
  ssh-add ~/.ssh/two_rsa
fi
# 记得还要在 ~/.bash_logout 中添加，来关闭 ssh-agent
# ssh-agent -k
新建 ~/.bash_logout 文件，添加：

# 记得还要在 ~/.bash_logout 中添加，来关闭 ssh-agent
ssh-agent -k
方式二：GitHub 提供的方式

复制以下行并将其粘贴到 Git shell 中的 ~/.profile 或 ~/.bashrc 文件中：

env=~/.ssh/agent.env

agent_load_env () { test -f "$env" && . "$env" >| /dev/null ; }

agent_start () {
    (umask 077; ssh-agent >| "$env")
    . "$env" >| /dev/null ; }

agent_load_env

# agent_run_state: 0=agent running w/ key; 1=agent w/o key; 2= agent not running
agent_run_state=$(ssh-add -l >| /dev/null 2>&1; echo $?)

if [ ! "$SSH_AUTH_SOCK" ] || [ $agent_run_state = 2 ]; then
    agent_start
    ssh-add ~/.ssh/one_rsa # 添加你自己的私钥
elif [ "$SSH_AUTH_SOCK" ] && [ $agent_run_state = 1 ]; then
    ssh-add ~/.ssh/one_rsa
fi

unset env
现在，当您初次运行 Git Bash 时，系统将提示您输入密码：

> Initializing new SSH agent...
> succeeded
> Enter passphrase for /c/Users/you/.ssh/id_rsa:
> Identity added: /c/Users/you/.ssh/id_rsa (/c/Users/you/.ssh/id_rsa)
> Welcome to Git (version 1.6.0.2-preview20080923)
>
> Run 'git help git' to display the help index.
> Run 'git help ' to display help for specific commands.
ssh-agent 进程将继续运行，直到您注销、关闭计算机或终止该进程。

powershell
在 PowerShell 的配置文件中添加，通过 在 powershell 中运行 notepad $PROFILE 来 打开配置文件

# Start SshAgent if not already
# Need this if you are using github as your remote git repository
if (! (ps | ? { $_.Name -eq 'ssh-agent'})) {
    Start-SshAgent
}
该方法还不够完善。

cmd
如果你使用的是 cmder ，则还可以为 cmd 进 行如下配置：

首先在 cmder 中确认当前在 cmd 标签页中
再测试以下 git push 命令，或 运行 ssh -T git@github.com 来进行测试
如果还是提示 Permission denied ，则进行下面的操作：
在 cmd 模式中运行 start-ssh-agent 即可启动 ssh-agent ，然后进行 代码推送，推送 完成后可选择输入exit退出 ssh-agent。

如果想要 ssh-agent 在 cmd 模式中自动启动，需要在 %CMDER_ROOT%/config/user-profile.cmd 文件中取消注释 @call "%GIT_INSTALL_ROOT%/cmd/start-ssh-agent.cmd"