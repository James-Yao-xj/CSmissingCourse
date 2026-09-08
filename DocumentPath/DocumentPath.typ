#import "@preview/ctyp:0.3.0": ctyp
#let (ctypset, cjk) = ctyp()
#let (song, hei, kai, fang) = cjk
#show: ctypset

#set page(
  paper: "a4",
  margin: (top: 2cm, bottom: 2cm, left: 1cm, right: 1cm),
  header: context [
    #text(10pt, black)[
      #align(center)[CS Missing Course]]
    #line(length: 100%, stroke: gray)
  ],
   footer: context [
    #set align(center)
    #counter(page).display("1")
  ]
)

#set heading(numbering: "1.")

#align(center)[
  #text(size: 24pt, weight: "bold")[文件、目录和路径]\
  #v(10pt)
  #text(size: 16pt)[_By：Happy49_]
]

= 总览
我希望借助这个机会讲解清楚：

- 文件和目录的区别
- 绝对路径与相对路径
- 当前工作目录
- .、..、~ 分别表示什么
- 文件扩展名只是命名约定，不决定文件本质
- 隐藏文件，例如 .gitignore、.bashrc
- 文本文件与二进制文件
- 字符编码：ASCII、Unicode、UTF-8
- 环境变量和 PATH
- 用户、用户组、管理员/root

学习完这些，希望你可以：

- 在终端中找到、创建、移动、复制和删除文件
- 判断一个程序为什么“找不到命令”
- 理解“权限不足”和“文件不可执行”


= 文件和目录

文件和目录的区别是：
+ 文件用来存储集体的内容，比如``photo.jpg``、``document.pdf``、``script.sh``等。
+ 目录用来组织和管理其他文件，也可以储存其他目录。例如，``/home/user/Documents``是一个目录，它可以包含多个文件和子目录。

= 绝对路径和相对路径

+ 绝对路径是从文件系统的起点开始的，写出文件或者目录的完整位置。例如，``/home/user/Documents/file.txt``是一个绝对路径，它从根目录``/``开始，依次经过``home``、``user``、``Documents``，最终指向文件``file.txt``。#footnote[这是MacOS和Linux的路径表示方法。]又例如``C:\Users\user\Documents\file.txt``。#footnote[这是Windows系统的绝对路径表示方法。]

+ 相对路径是相对于当前工作目录的路径表示方法。它不需要从根目录开始，而是从当前所在的目录出发。例如，如果当前工作目录是``/home/user``，那么``Documents/file.txt``就是一个相对路径，它指向``/home/user/Documents/file.txt``。

*相对路径会随着当前目录的变化而改变含义。*

== 两个特殊符号：`.`和`..`

- `.`表示当前目录；
- `..`表示上级目录。

假如当前处于`/home/user/Documents`目录下，那么：
- `.`表示`/home/user/Documents`；
- `..`表示`/home/user`。

所以`./file.txt`表示当前目录下的`file.txt`文件，也就是`/home/user/Documents/file.txt`。而`../file2.txt`表示上级目录下的`file2.txt`文件，也就是`/home/user/file2.txt`。

= 文件扩展名

== 什么是扩展名
一般来说是文件名的`.`之后的内容，比如：`exam.pdf`的扩展名是`.pdf`，`photo.jpg`的扩展名是`.jpg`。

== 扩展名的作用
- 提示用户文件可能是什么类型；
- 帮助操作系统选择打开它的软件；
- 方便软件和用户分类，筛选文件。

例如，在Windows系统中，`.txt`文件通常会用记事本打开，而`.jpg`文件会用图片查看器打开。

但是文件的本质是一串二进制数据，硬盘保存的不是这些图片本身，而是这些二进制顺序。扩展名就像给了一个解释规则，解释这些字节。这就是文件的格式。

总结来讲：*文件本质上是字节序列；文件格式是解释这些字节的规则；扩展名是对文件格式的外部提示。*

= 隐藏文件

在Linux和macOS系统中，以点`.`开头的文件被称为隐藏文件。例如，`.bashrc`、`.gitignore`等。这些文件默认不会在目录列表中显示，但可以通过特定的命令或设置来查看和操作它们。

隐藏文件通常用于存储配置信息、日志或其他系统相关的数据，它们不会干扰用户的日常操作，但对系统的正常运行至关重要。

具体来说有：

- ``.gitignore``：告诉 Git 哪些文件不需要记录。
- ``.bashrc``：保存命令行环境的个人配置。
- ``.env``：常用于保存程序的环境配置。

注意：隐藏文件并不意味着它们是安全的，用户仍然可以访问和修改它们，只是默认情况下不会显示在文件浏览器中。

= 文本文件与二进制文件

+ 文本文件：
  - 由可读的字符组成，可以用文本编辑器打开和编辑。
  - 通常使用特定的字符编码（如ASCII、UTF-8）来表示字符。
  - 示例：`.txt`、`.md`、`.html`等。#footnote[.md是markdown文件的扩展名，.html是网页文件的扩展名。不知道也没关系，总之就是一堆文字。]
+ 二进制文件：
  - 由不可读的字节组成，通常用于存储程序、图片、音频等数据。
  - 不能直接用文本编辑器打开，需要特定的软件来读取和解释。
  - 示例：`.exe`、`.jpg`、`.mp3`等。

核心区别：*文本文件的字节主要按照字符编码解释；二进制文件的字节按照专门的文件格式解释。*

= ASCII、Unicode和UTF-8

+ ASCII（American Standard Code for Information Interchange）是一种早期的字符编码标准，它使用7位二进制数表示128个字符，包括英文字母、数字、标点符号和一些控制字符。由于其字符集有限，ASCII无法表示其他语言的字符。

+ Unicode是一种字符编码标准，它为世界上所有的字符提供了一个唯一的数字标识符。Unicode的目的是解决ASCII的局限性，使得不同语言的字符都能被正确表示和处理。

+ UTF-8是Unicode的一种实现方式，它使用1到4个字节来表示一个字符，根据字符的不同，选择不同的字节数。UTF-8是目前最广泛使用的字符编码标准之一，它兼容ASCII，同时支持全世界所有的语言。

= 环境变量和PATH

首先看看这东西在哪：Windows直接搜索环境变量就能看到。

``TEMP → C:\\Users\\CapyThePig\\AppData\\Local\\Tempbies``是我的TEMP这个变量，含义是临时储存的文件就放在这个对应的目录下。


Path 也是一个环境变量，只不过它非常重要。

它的值不是一个目录，而是一组目录，例如：

```
C:\Users\CapyThePig\miniconda3
C:\Program Files\Eclipse Adoptium\jdk-17...\binrib```


当你在命令行输入：
``pythonaset``

Windows 会：

1. 先查看当前目录有没有 python.exe。

2. 再从上到下检查 Path 中的每个目录。

3. 找到 python.exe 后运行它。

4. 全部找不到就提示“无法识别该命令”。

所以，Miniconda 目录加入了用户 Path 后，你通常可以直接输入`` python``，而不用输入：

```
C:\Users\CapyThePig\miniconda3\python.exe```

= 管理员和用户

== 管理员 / root

它们是拥有高级权限的身份：
- Windows 中通常称为管理员
- Linux 和 macOS 中的最高权限用户称为 root

管理员或 root 可以安装软件、修改系统设置、管理其他用户，以及访问大多数文件。

== 用户
用户就是计算机中的一个身份，它有自己的用户名和密码。每个用户都有自己的主目录和权限设置。普通用户通常没有管理员权限，无法进行系统级的更改。

