#set page(width: 210mm, height: 297mm)
#set text(size: 16pt)
姓名：#underline[王远浩] 学号：#underline[2023311I13]
班级：#underline[18班]
学期：#underline[大二]

实验项目：#underline[计数器实验]
上课地点：#underline[T2612]
实验完成时间：#underline[8h] 
#heading[*实验内容*]
仿真波形图
#image("屏幕截图 2024-10-26 182242.png",width:100%,height:20%)

流水灯仿真分析
#heading[仿真测试步骤及预期结果]
#set text(size: 13pt)
+ 复位 (Reset)
    - 操作：仿真开始时，将 rst 信号保持在高电平 20ns，确保被测模块 flowing_light复位清零。
    - 预期结果：此时 led 的输出应为 0，表示模块内状态已初始化。

+ 启动 (Start)
    - 操作：将 `rst` 信号拉低，并通过将 `button` 置高、再拉低的脉冲触发流水灯启动。
    - 预期结果：启动后，`led` 应该开始以 100MHz 频率（`freq_set = 2'b00`）向左移动的灯光效果。

+ 暂停 (Pause)
    - 操作：在流水灯启动后，模拟按下并释放按钮（`button` 信号置高后再置低），暂停流水灯。
    - 预期结果：`led` 状态保持不变，流水灯效果暂停。

+ 再次启动 (Restart)
    - 操作：再次按下并释放按钮来重新启动流水灯。
    - 预期结果：`led` 从当前位置继续按相同频率向左移动。

+ 间隔切换 (Frequency Change)
    - 操作：更改 `freq_set` 为 `2'b01`，对应较低频率（如10Hz）。
    - 预期结果：`led` 的移动速度应显著变慢，以此频率展示效果。

+ 方向切换 (Direction Change)
    - 操作：将 `dir_set` 信号置为 1，改变流水灯方向。
    - 预期结果：`led` 灯光将从右向左移动，验证方向切换功能。

+ 同时切换间隔和方向 (Combined Frequency and Direction Change)
    - 操作：频率和方向切换完成后，再观察一段时间，确保切换效果。
    - 预期结果：流水灯以新频率和新方向持续运行。
= RTL Analysis
#image("image.png")
#set text(size: 16pt)
_计算其最大值计算：_
公式：$n =T/T_"clk" $-1\
n为计数器最大值，T间隔时间，$T_"clk"$ 为时钟周期\
所以：\
T=0.01s,n=100000-1=99999\
T=0.1s,n=1000000-1=999999\
T=0.25s,n=2500000-1=2499999\
T=0,5s,n=5000000-1=4999999\
= 课后作业

== 对比一\
非阻塞赋值\
仿真图：\
#image("97b4ebcf2e9ad17dadaddb236f4cf68.png",width:100%,height:15%)
RTL分析图：\
#image("7b77c18338a2625470ee96b89e9b215.png",width:100%,height:15%)
Synthesis分析图：\
#image("b2f4e18bf5234de892a738dd7151db6.png",width:100%,height:15%)
阻塞赋值\
仿真图：\
#image("e8e24be4c62454b84ea3878f0138f63.png",width:100%,height:15%)
RTL分析图：\
#image("c67d9743b50b33551ff0a6d57ad2451.png",width:100%,height:15%)
Synthesis分析图：\
#image("c642d10ef4d38d998e3dc53a2d45b42.png",width:100%,height:15%)
一个时钟后，cnt为6\
两个时钟后，cnt为6\
== 对比二\
非阻塞赋值\
#image("c6bf05ecb1ed1a33404fe7f6d5aeb49.png",width:100%,height:15%)
RTL分析图：\
#image("366f1524ea3d255cec750aa98e24722.png",width:100%,height:15%)
Synthesis分析图：\
#image("74dbcf88b120d5a7f320f2eba0e2f4b.png",width:100%,height:15%)
阻塞赋值\
#image("a2d9491c85b304b11ebb8842e747fc6.png",width:100%,height:15%)
RTL分析图：\
#image("8e3e055277a42cb8492802d5c33f3c8.png",width:100%,height:15%)
Synthesis分析图：\
#image("fe58d12ab8bddce6a1d1b57c809955d.png",width:100%,height:15%)
阻塞赋值和非阻塞赋值的主要区别如下：\
1. 阻塞赋值存储的是前一个时钟周期的值，而非阻塞赋值存储的是前两个时钟周期的值。
2. RTL分析图：阻塞赋值只有一个寄存器，非阻塞赋值有两个级联的寄存器。
3. 电路图：阻塞赋值只有一个寄存器，非阻塞赋值有两个级联的寄存器。
