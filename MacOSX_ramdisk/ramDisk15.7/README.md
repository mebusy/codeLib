

```txt
boot
 └─ launchd (system)
     └─ LaunchDaemon 创建 RamDisk
         └─ 拷贝 cache / tmp / profile data
             └─ loginwindow
                 └─ 用户 profile 加载
                     └─ ln -s 已经指向存在的 RamDisk
```
