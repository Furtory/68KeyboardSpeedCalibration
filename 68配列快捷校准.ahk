Process, Priority, , Realtime
#MenuMaskKey vkE8
#WinActivateForce
#InstallKeybdHook
#InstallMouseHook
#Persistent
#NoEnv
#SingleInstance Force
#MaxHotkeysPerInterval 2000
#KeyHistory 2000
SendMode Input
SetBatchLines -1
SetKeyDelay -1, 1
SetWorkingDir %A_ScriptDir%
CoordMode, Mouse Window

Menu, Tray, NoStandard ;不显示默认的AHK右键菜单
Menu, Tray, Add, 使用教程, 使用教程 ;添加新的右键菜单
Menu, Tray, Add
Menu, Tray, Add, 校准设置, 校准设置 ;添加新的右键菜单
Menu, Tray, Add, 开始校准, 开始校准 ;添加新的右键菜单
Menu, Tray, Add
Menu, Tray, Add, 重启软件, 重启软件 ;添加新的右键菜单
Menu, Tray, Add, 退出软件, 退出软件 ;添加新的右键菜单

IfExist, %A_ScriptDir%\设置.ini ;如果配置文件存在则读取
{
  IniRead, X1, 设置.ini, 设置, X1
  IniRead, X2, 设置.ini, 设置, X2
  IniRead, SY, 设置.ini, 设置, SY
  IniRead, JZX, 设置.ini, 设置, JZX
  IniRead, JZY, 设置.ini, 设置, JZY
  ; goto 开始校准
}
else
{
  goto 校准设置
}
return

使用教程:
MsgBox, , , 黑钨重工出品 免费开源 请勿商用 侵权必究`n更多免费软件教程尽在QQ群 1群763625227 2群643763519`n`n校准期间请勿改变窗口大小`n更改后需要重新校准设置
return

校准设置:
KeyWait, LButton
WinActivate, ahk_exe REDRAGON Gaming Keyboard.exe
loop
{
  MouseGetPos, TTX, TTY
  ToolTip 数字1左下角点击左键`nX%TTX% Y%TTY%
  if GetKeyState("LButton", "P")
  {
    MouseGetPos, X1, SY
    break
  }
  Sleep 30
}
KeyWait, LButton
loop
{
  MouseGetPos, TTX, TTY
  ToolTip 加号右下角点击左键`nX%TTX% Y%TTY%
  if GetKeyState("LButton", "P")
  {
    MouseGetPos, X2
    break
  }
  Sleep 30
}
KeyWait, LButton
loop
{
  MouseGetPos, TTX, TTY
  ToolTip 开始校准点击左键`nX%TTX% Y%TTY%
  if GetKeyState("LButton", "P")
  {
    MouseGetPos, JZX, JZY
    break
  }
  Sleep 30
}
IniWrite, %X1%, 设置.ini, 设置, X1
IniWrite, %X2%, 设置.ini, 设置, X2
IniWrite, %SY%, 设置.ini, 设置, SY
IniWrite, %JZX%, 设置.ini, 设置, JZX
IniWrite, %JZY%, 设置.ini, 设置, JZY
loop 30
{
  ToolTip 设置完成
  Sleep 30
}
ToolTip
return

TT:
ToolTip 按下任意键开始校准
return

开始校准:
WinActivate, ahk_exe REDRAGON Gaming Keyboard.exe
KD:=""
loop
{
  SetTimer, TT, 30
  KD:=KeyWaitAny()
  if (KD!="")
  {
    SetTimer, TT, Delete
    ToolTip
    Sleep 500
    break
  }
}
KW:=Round(abs(X2-X1)/12)
TX:=Round(X1-KW/2)
TY:=Round(SY-KW/2)
KT:=58
KD:=""
Hotkey, LWin, LWin
loop
{
  if (KT<=15) ;1
  {
    MTX:=TX+(KT-1)*KW
    if (KT=15)
    {
      MTX:=Round(TX+KW*15)
    }
  }
  else if (KT>15) and (KT<=30) ;2
  {
    MTX:=Round(TX+KW/2+(KT-16)*KW)
    if (KT=30)
    {
      MTX:=Round(TX+KW*15)
    }
  }
  else if (KT>30) and (KT<=44) ;3
  {
    MTX:=Round(TX+KW/4*3+(KT-31)*KW)
    if (KT=44)
    {
      MTX:=Round(TX+KW*15)
    }
  }
  else if (KT>44) and (KT<=58) ;4
  {
    MTX:=Round(TX+KW+KW/4+(KT-45)*KW)
    if (KT>=57) and (KT<=58)
    {
      MTX:=Round(TX+KW*(15-(58-KT)))
    }
  }
  else if (KT>58) and (KT<=62) ;5 left-space
  {
    MTX:=Round(TX+KW/8+(KT-59)*(KW+KW/4))
  }
  else if (KT>62) ;5 space-right
  {
    MTX:=Round(TX+KW*10+KW/8+(KT-63)*KW)
    if (KT=68)
    {
      MTX:=Round(TX+KW*15)
    }
  }
  
  if (KT<=15)
  {
    MTY:=TY
  }
  else if (KT>15) and (KT<=30)
  {
    MTY:=TY+1*KW
  }
  else if (KT>30) and (KT<=44)
  {
    MTY:=TY+2*KW
  }
  else if (KT>44) and (KT<=58)
  {
    MTY:=TY+3*KW
  }
  else if (KT>58)
  {
    MTY:=TY+4*KW
  }
  MouseMove, MTX, MTY, 0
  Send {LButton}
  if (KT<68)
  {
    MouseMove, JZX, JZY, 0
    Send {LButton}
  }
  SoundPlay, Speech On.wav
  ; ToolTip %KT%
  
  if (KT!=60) and (KT!=64)
  {
    KD:=KeyWaitAny()
    if (KD!="") 
    {
      ToolTip
      KeyWait, %KD%
      KD:=""
    }
  }
  else if (KT=60)
  {
    KeyWait, LWin, D
    loop
    {
      if !GetKeyState("LWin", "P")
      {
        break
      }
    }
  }
  else if (KT=64)
  {
    ToolTip Fn键校准成功不会有提示音`n看到校准成功后直接摁下一个即可
    Sleep 3000
  }
  
  KT:=KT+1
  if (KT>68)
  {
    Hotkey, LWin, Off
    break
  }
}
MsgBox, 48, 黑钨重工68配列快捷校准, 校准完成, 5
return

LWin:
return

KeyWaitAny(Options:="")
{
    ih := InputHook(Options)
    ih.KeyOpt("{All}", "E")  ; 结束
    ih.Start()
    ErrorLevel := ih.Wait()  ; 将 EndReason 存储在 ErrorLevel 中
    return ih.EndKey  ; 返回按键名称
}

重启软件:
Reload

退出软件:
ExitApp