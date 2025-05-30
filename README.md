My nvim configs:

💯 Optimized for code retracing, especially c/cpp and python.

📋Syntax highlighting

📋Autocomplete with the ability to disable

📋Dedicated switch for internal terminal:  'Ctrl+\'

📋 File tree view-->'Ctrl+n' ; Suitable for multi-file projects and code.

![Screenshot (148)](https://github.com/user-attachments/assets/e58f2605-6af2-4c4d-8934-35fb32c21187)



📋Dedicated switch for compilation: '\\+c'

![Screenshot (149)](https://github.com/user-attachments/assets/d37c13d2-88bf-430c-a270-a7ad60600621)

📋Dedicated switch for execution: '\\+c'

![Screenshot (150)](https://github.com/user-attachments/assets/28a93a37-9949-492c-9054-4b65f56a4155)

Don't forget to write(:w) before compiling.

🧮 Requirements:

1- NeoVIM version + 0.9 

2- git

3- Python +3.7

4- g++ , gcc

5- Windows Terminal or PowerShell


Attention
To install gcc  and g++ on Windows, you must first install MSYS2(first install it and use its terminal) :
```bash
pacman -Syu
pacman -S mingw-w64-ucrt-x86_64-gcc
```
Make sure gcc and g++ are added to PATH.
After installing Nvim, go to the following address and make sure there is a folder named nvim.
```
Windows: C:\Users\USERNAME\AppData\Local\nvim\init.lua
Linux/Mac: ~/.config/nvim/init.lua
```
Sometimes the nvim folder is not created automatically. And sometimes you will find a folder with a similar name called nvim Data. In this case, create the folder yourself.

Save the config file in the nvim folder. Make sure to back up your previous config if you have one.

This configuration has been tested on Windows 10/11.


