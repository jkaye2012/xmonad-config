import XMonad
import XMonad.Actions.UpdatePointer
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import qualified XMonad.StackSet as W
import XMonad.Util.EZConfig
import XMonad.Util.Loggers
import XMonad.Util.Ungrab

grey1, grey2, grey3, grey4, cyan, orange :: String -> String
grey1 = xmobarColor "#2B2E37" ""
grey2 = xmobarColor "#555E70" ""
grey3 = xmobarColor "#697180" ""
grey4 = xmobarColor "#8691A8" ""
cyan = xmobarColor "#8BABF0" ""
orange = xmobarColor "#C45500" ""

myXmobarPP :: PP
myXmobarPP =
  def
    { ppSep = orange " • ",
      ppTitleSanitize = xmobarStrip,
      ppCurrent = blue . wrap " " "" . xmobarBorder "Top" "#5294E2" 2,
      ppHidden = white . wrap " " "",
      ppHiddenNoWindows = lowWhite . wrap " " "",
      ppUrgent = red . wrap (yellow "!") (yellow "!"),
      ppOrder = \[ws, l, _, wins] -> [ws, l, wins],
      ppExtras = [logTitles formatFocused formatUnfocused]
    }
  where
    formatFocused = wrap (white "[") (white "]") . orange . ppWindow
    formatUnfocused = wrap (lowWhite "[") (lowWhite "]") . cyan . ppWindow

    ppWindow :: String -> String
    ppWindow = xmobarRaw . (\w -> if null w then "untitled" else w) . shorten 30

    blue, lowWhite, magenta, red, white, yellow :: String -> String
    magenta = xmobarColor "#ff79c6" ""
    blue = xmobarColor "#5294E2" ""
    white = xmobarColor "#7C818C" ""
    yellow = xmobarColor "#f1fa8c" ""
    red = xmobarColor "#ff5555" ""
    lowWhite = xmobarColor "#4B5162" ""

myStartupHook :: X ()
myStartupHook = do
  spawn "killall trayer; trayer --edge top --align right --widthtype request --padding 15 --iconspacing 5 --SetDockType true --SetPartialStrut true --expand true --transparent true --alpha 0 --tint 0x383C4A  --height 30 --distance 5 --distancefrom top &"

myConfig =
  def
    { borderWidth = 0,
      logHook = updatePointer (0.5, 0.5) (0, 0),
      startupHook = myStartupHook
    }
    `additionalKeysP` [ ("M-S-=", unGrab *> spawn "scrot -s -e 'xclip -selection clipboard -t image/png -i $f' ~/Pictures/Screenshots/%Y-%m-%d-%H-%M-%S.png"),
                        ("M-s", unGrab *> spawn "xscreensaver-command -lock"),
                        ("M-<Return>", spawn "gnome-terminal"),
                        ("M-;", spawn "rofi -show run"),
                        ("M-'", spawn "rofi -show window"),
                        -- Audio controls
                        ("<XF86AudioLowerVolume>", spawn "amixer -q -D pulse sset Master 5%-"),
                        ("<XF86AudioRaiseVolume>", spawn "amixer -q -D pulse sset Master 5%+"),
                        ("<XF86AudioMute>", spawn "amixer -q -D pulse sset Master toggle"),
                        ("<XF86AudioPlay>", spawn "dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause"),
                        ("<XF86AudioPrev>", spawn "dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Previous"),
                        ("<XF86AudioNext>", spawn "dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Next")
                      ]

main :: IO ()
main =
  xmonad
    . ewmhFullscreen
    . ewmh
    . withEasySB (statusBarProp "xmobar ~/.xmonad/xmobarrc" $ pure myXmobarPP) toggleStrutsKey
    $ myConfig
  where
    toggleStrutsKey :: XConfig Layout -> (KeyMask, KeySym)
    toggleStrutsKey XConfig {modMask = m} = (m, xK_x)
