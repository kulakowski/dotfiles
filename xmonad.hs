import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName
import XMonad.Hooks.UrgencyHook
import XMonad.Layout.Named
import XMonad.Layout.NoBorders
import XMonad.Layout.Tabbed
import XMonad.Util.EZConfig
import XMonad.Util.Run

main = do
  xmobar <- spawnPipe "/${HOME}/bin/xmobar"
  xmonad $ withUrgencyHook NoUrgencyHook $ docks $ defaultConfig
             { borderWidth = 2
             , terminal = "urxvt"
             , normalBorderColor = "#202030"
             , focusedBorderColor = "#A0A0D0"
             , layoutHook = myLayout
             , modMask = mod4Mask
             , logHook = myLogHook xmobar
             , handleEventHook = ewmhDesktopsEventHook
             , manageHook = myManageHook
             } `additionalKeys`
                 [ ((myMask, xK_b), spawn "google-chrome --profile-directory='Profile 1'")
                 , ((myMask, xK_s), spawn "subl -n")
                 , ((myMask, xK_Escape), spawn "xscreensaver-command -lock")
                 ]
  where
    myMask = mod4Mask
    myLayout = tall ||| wide ||| tabbed ||| single ||| fullscreen where
        tall = named "tall" $ avoidStruts $ smartBorders $ tiled
        wide = named "wide" $ avoidStruts $ smartBorders $ Mirror tiled
        single = named "single" $ avoidStruts $ noBorders Full
        fullscreen = named "fullscreen" $ noBorders Full
        tabbed = named "tabbed" $ avoidStruts $ smartBorders $ simpleTabbed
        tiled = Tall nmaster delta ratio
            where
              nmaster = 1
              ratio = 1/2
              delta = 3/100
    myManageHook = composeAll
                  [ isFullscreen --> doFullFloat
                  , className =? "Qemu-system-x86_64" --> doFloat
                  , className =? "qemu-system-x86_64" --> doFloat
                  ]
    myLogHook xmobar = do
        ewmhDesktopsLogHook >> setWMName "LG3D"
        dynamicLogWithPP $ defaultPP { ppOutput = hPutStrLn xmobar
                                     , ppTitle = xmobarColor "#f0c674" "" . shorten 120
                                     , ppUrgent = xmobarColor "#282a2e" ""
                                     , ppCurrent = \wID -> xmobarColor "#1d1f21" "#c5c8c6" $ "[" ++ wID ++ "]"
                                     }
