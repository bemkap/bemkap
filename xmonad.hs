import XMonad
import XMonad.Util.EZConfig (additionalKeysP)
import XMonad.Util.Loggers
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Layout.WindowNavigation
import XMonad.Hooks.EwmhDesktops
import XMonad.Actions.CycleWS

main :: IO ()


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
  {ppTitle=green.shorten 100,
   ppHidden=gray,
   ppCurrent=green}

  where magenta=xmobarColor"#ff79c6" ""
        yellow=xmobarColor"#f1fa8c" ""
        green=xmobarColor"#00ff00" ""
        gray=xmobarColor"#888888" ""
        

myLayout=windowNavigation$tiled|||Mirror tiled|||Full
  where tiled=Tall 1 0.03 0.5

myKeys=[("M-w",spawn"chromium"),
        ("M-o",spawn"emacs"),
        ("M-y",spawn"thunar"),
        ("M-b",spawn"blueman-manager"),
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
  where myPrograms=[["Chorium","firefox"],
                    ["Emacs","Rstudio","jqt"],
                    ["URxvt","Alacritty"],
                    ["Evince","feh"],
                    ["Thunar"],
                    ["vlc"],
                    ["Xmaxima"],
                    ["Transmission-gtk"],
                    ["Gimp","Blueman-manager"]]
