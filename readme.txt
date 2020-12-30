一个可以便捷切换hosts文件，以及增加hosts条目的shell脚本（本意是为了督促自己不要在学习时间上B站和贴吧）。原理很简单，就是利用hosts文件将B站和贴吧解析到127.0.0.1。
适用于macos10.15.7版本

关于hosts文件：
其中记录的是一些域名及其ip的映射，如果以后访问的域名在这个文件里有相应的映射，则不需要dns服务直接以此映射得出访问域名的ip。早些年Pixiv被大陆的一些dns解析到不正确的ip，有网友就使用改hosts文件的方法应对，不过现在已经不管用了，防火墙应该是禁了ip。

使用说明：
1、在 ～/.bash_profile（根据系统可能有不同，反正就是启动shell时就会运行的那个脚本）中加入一行：
alias SHost='sudo -i source ~/bin/SHosts.sh'     
后面那个是SHosts.sh的目录，放个合适的地方就行
2、然后 source ～/.bash_profile
3、在/etc/下执行：
cp hosts hosts_ori && cp hosts hosts_changed
前者为你最初版本hosts的备份，后者为以后你增加的条目所在的文件。开启时，用后者覆盖掉hosts，关闭时用前者覆盖掉hosts。

输入命令：
SHost open 开始屏蔽相关域名
SHost shut 关闭此功能
SHost add 根据后续提示在文件中增加相应屏蔽条目

以上命令有的需要root权限