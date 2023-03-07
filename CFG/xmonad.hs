import XMonad
import XMonad.Util.EZConfig (additionalKeysP,additionalMouseBindings)
import XMonad.Util.Loggers
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Layout.WindowNavigation
import XMonad.Hooks.EwmhDesktops
import XMonad.Actions.CycleWS

main=xmonad.(withEasySB(statusBarProp"xmobar"(pure myXmobarPP))defToggleStrutsKey).ewmhFullscreen.ewmh$def
    {modMask=mod4Mask,
     layoutHook=myLayout,
     manageHook=myManageHook,
     workspaces=myWorkspaces,
     borderWidth=3,
     focusedBorderColor="#1111aa",
     normalBorderColor="#222222",
     terminal="alacritty"} `additionalKeysP` myKeys

myXmobarPP=def
  {ppHidden=lightgray,
   ppCurrent=blue,
   ppLayout=iconSelector,
   ppOrder=take 2,
   ppHiddenNoWindows=darkgray}
  where blue=xmobarFont 1.xmobarColor"#3377dd" ""
        lightgray=xmobarColor"#888888" ""
        darkgray=xmobarColor"#333333" ""
        iconSelector"Full"="F"
        iconSelector"Tall"="T"
        iconSelector"Mirror Tall"="M"
        iconSelector x=x

myLayout=windowNavigation$tiled|||Mirror tiled|||Full
  where tiled=Tall 1 0.03 0.5

myKeys=[("M-w",spawn"chromium"),
        ("M-o",spawn"emacs"),
        ("M-y",spawn"thunar"),
        ("M-x",spawn"blueman-manager"),
        ("M-j",spawn"multimc"),
        ("M-v",spawn"jqt -style gtk2 ~/doc/b/V/vwd.ijs"),
        ("M-a",spawn"jqt"),
        ("M-s",sendMessage$Go R),
        ("M-r",sendMessage$Go L),
        ("M-t",sendMessage$Go D),
        ("M-n",sendMessage$Go U),
        ("M-<Tab>",toggleWS)]

myWorkspaces=["1","2","3","4","5","6","7","8","9"]

myManageHook=composeAll.concat$zipWith(\x y->[className=?a-->doShift x|a<-y]) myWorkspaces myPrograms
  where myPrograms=[["Chromium","firefox"],
                    ["Emacs","Rstudio","jqt"],
                    ["URxvt","Alacritty"],
                    ["Evince","feh"],
                    ["Thunar"],
                    ["vlc"],
                    ["Xmaxima","Blueman-manager"],
                    ["Transmission-gtk"],
                    ["Gimp-2.10"]]
