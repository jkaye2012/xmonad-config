import XMonad
import XMonad.Actions.UpdatePointer
import XMonad.Config.Prime (ScreenId (..))
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Layout.ThreeColumns
import qualified XMonad.StackSet as W
import XMonad.Util.EZConfig
import XMonad.Util.Loggers
import XMonad.Util.Ungrab

dark1 = xmobarColor "#2e3440" ""

dark2 = xmobarColor "#434c5e" ""

dark3 = xmobarColor "#3b4252" ""

dark4 = xmobarColor "#4c566a" ""

light1 = xmobarColor "#d8dee9" ""

light2 = xmobarColor "#e5e9f0" ""

light3 = xmobarColor "#eceff4" ""

opal = xmobarColor "#8fbcbb" ""

lightBlue = xmobarColor "#88c0d0" ""

blue = xmobarColor "#81a1c1" ""

darkBlue = xmobarColor "#5e81ac" ""

red = xmobarColor "#bf616a" ""

orange = xmobarColor "#d08770" ""

yellow = xmobarColor "#ebcb8b" ""

seaGreen = xmobarColor "#a3be8c" ""

purple = xmobarColor "#b48ead" ""

myXmobarPP :: PP
myXmobarPP =
  def
    { ppSep = orange " • ",
      ppTitleSanitize = xmobarStrip,
      ppCurrent = darkBlue . wrap " " "" . xmobarBorder "Top" "#5e81ac" 2,
      ppHidden = light3 . wrap " " "",
      ppHiddenNoWindows = dark4 . wrap " " "",
      ppUrgent = red . wrap (yellow "!") (yellow "!"),
      ppOrder = \[ws, l, _, wins] -> [ws, l, wins],
      ppExtras = [logTitles formatFocused formatUnfocused]
    }
  where
    formatFocused = wrap (light2 "[") (light2 "]") . orange . ppWindow
    formatUnfocused = wrap (light1 "[") (light1 "]") . lightBlue . ppWindow

    ppWindow :: String -> String
    ppWindow = xmobarRaw . (\w -> if null w then "untitled" else w) . shorten 30

myStartupHook :: X ()
myStartupHook = do
  spawn "~/.xmonad/trayer.sh"

myLayout = Tall 1 (3 / 100) (1 / 2) ||| Mirror (Tall 1 (3 / 100) (1 / 2)) ||| Full ||| ThreeColMid 1 (3 / 100) (1 / 3)

-- Non-numeric num pad keys, sorted by number
numPadKeys =
  [ xK_KP_End,
    xK_KP_Down,
    xK_KP_Page_Down,
    xK_KP_Left,
    xK_KP_Begin,
    xK_KP_Right,
    xK_KP_Home,
    xK_KP_Up,
    xK_KP_Page_Up
  ]

myWorkspaces = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]

myConfig =
  def
    { borderWidth = 0,
      logHook = updatePointer (0.5, 0.5) (0, 0),
      startupHook = myStartupHook,
      layoutHook = myLayout
    }
    `additionalKeysP` [ ("M-S-=", unGrab *> spawn "scrot -s -e 'xclip -selection clipboard -t image/png -i $f' ~/Pictures/Screenshots/%Y-%m-%d-%H-%M-%S.png"),
                        ("M-s", unGrab *> spawn "slock"),
                        ("M-S-s", spawn "systemctl suspend"),
                        ("M-<Return>", spawn "gnome-terminal"),
                        ("M-;", spawn "rofi -show run"),
                        ("M-'", spawn "rofi -show window"),
                        ("M-c", kill),
                        -- Audio controls
                        ("<XF86AudioLowerVolume>", spawn "amixer -q -D pulse sset Master 5%-"),
                        ("<XF86AudioRaiseVolume>", spawn "amixer -q -D pulse sset Master 5%+"),
                        ("<XF86AudioMute>", spawn "amixer -q -D pulse sset Master toggle"),
                        ("<XF86AudioPlay>", spawn "dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause"),
                        ("<XF86AudioPrev>", spawn "dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Previous"),
                        ("<XF86AudioNext>", spawn "dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Next")
                      ]
    `additionalKeys` [ ((m .|. mod1Mask, k), windows $ f i)
                       | (i, k) <- zip myWorkspaces numPadKeys,
                         (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]
                     ]

main :: IO ()
main =
  xmonad
    . ewmhFullscreen
    . ewmh
    . dynamicEasySBs (\(S sid) -> pure $ statusBarProp ("xmobar -x " <> show sid <> " ~/.xmonad/xmobarrc") $ pure myXmobarPP)
    $ myConfig
  where
    toggleStrutsKey :: XConfig Layout -> (KeyMask, KeySym)
    toggleStrutsKey XConfig {modMask = m} = (m, xK_x)
