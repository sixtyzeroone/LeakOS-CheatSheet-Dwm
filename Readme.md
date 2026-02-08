
DWM Configuration Cheatsheet

    A comprehensive guide to the keyboard shortcuts and mouse controls for my custom DWM setup

📁 Project Structure
text

dwm/
├── config.h          # Main configuration file
├── patches/
│   └── gaplessgrid.c # Custom layout patch
└── layouts.c         # Layout definitions

🎨 Theme & Appearance

    Colors: Nord color scheme variant

    Bar: Top bar, 24px height

    Gaps: 12px between windows

    Borders: 1px window borders

    Font: Terminus (15px, no antialiasing)

⌨️ Keyboard Shortcuts
Workspace Navigation
Shortcut	Action	Workspace
Super + M	Switch to workspace 1	PENTEST
Super + 2	Switch to workspace 2	DEVEL
Super + 3	Switch to workspace 3	MISC
Super + 4	Switch to workspace 4	INTERNET
Super + 5	Switch to workspace 5	⭒
Super + Ctrl + 1-5	Toggle view workspace	-
Super + Shift + 1-5	Move window to workspace	-
Super + Ctrl + Shift + 1-5	Toggle tag window	-
Window Management
Shortcut	Action
Super + J	Focus next window
Super + K	Focus previous window
Super + Tab	Cycle to next layout
Super + Shift + Tab	Cycle to previous layout
Super + W	Kill focused window
Super + Shift + F	Toggle floating mode
Super + Shift + J	Rotate stack up
Super + Shift + K	Rotate stack down
Super + .	Focus next monitor
Super + ,	Focus previous monitor
Super + Shift + .	Move window to next monitor
Super + Shift + ,	Move window to previous monitor
Layout & Size Control
Shortcut	Action
Super + Shift + H	Decrease master area (-5%)
Super + Shift + L	Increase master area (+5%)
Super + I	Increase number of master windows
Super + Shift + I	Decrease number of master windows
Super + G	Decrease gaps between windows
Super + Shift + G	Increase gaps between windows
Super + ←	Toggle color scheme
Super + →	Cycle color scheme
Application Launchers
Shortcut	Application	Description
Super + Enter	XFCE4 Terminal	Default terminal
Super + A	XTerm (green)	84x26, black background
Super + B	URxvt (yellow)	55x26, black background
Super + C	URxvt (red)	55x26, black background
Super + D	URxvt (white)	55x26, black background
Super + F	Firefox	Auto to INTERNET workspace
Super + Shift + C	VS Code	Auto to DEVEL workspace
Super + Shift + V	Vim	Auto to DEVEL workspace
Super + Shift + N	Nano	Auto to INTERNET workspace
Super + M	Launch Menu	Custom leak/dmenu
Super + N	Dmenu Run	Application launcher
Super + E	Thunar	File manager
Super + F3	VirtualBox	Auto to MISC workspace
System Controls
Shortcut	Action
Super + Ctrl + R	Restart DWM
Super + Shift + B	Toggle bar visibility
Super + ↑	Increase brightness (+10%)
Super + ↓	Decrease brightness (-10%)
Super + R	Enable Redshift (2400K)
Super + Shift + R	Disable Redshift
Super + S	Take screenshot (scrot)
Super + Shift + S	Take area screenshot
Print Screen	Screenshot (xfce4-screenshooter)
Super + F12	Toggle root mode
🖱️ Mouse Controls
Layout Indicator (Top-left)
Button	Action
Left Click	Set default layout
Right Click	Cycle through layouts
Window Title Bar
Button	Action
Middle Click	Zoom/maximize window
Status Bar
Button	Action
Middle Click	Open terminal (urxvt)
Window Client Area
Shortcut + Button	Action
Super + Left Click	Move window
Super + Middle Click	Toggle floating
Super + Right Click	Resize window
Tag Bar (Workspaces)
Shortcut + Button	Action
Left Click	Switch workspace
Right Click	Toggle view workspace
Super + Left Click	Tag window to workspace
Super + Right Click	Toggle tag window
🏗️ Layouts

The configuration includes three layouts:

    [F] - Floating layout

    [M] - Gapless grid layout

    []= - Tile layout (master-slave)

⚙️ Auto-Assign Rules

Applications are automatically assigned to specific workspaces:
Application	Workspace	Floating
Firefox	INTERNET (4)	No
Chromium	INTERNET (4)	No
VS Code	DEVEL (2)	No
XTerm (devterm)	DEVEL (2)	No
URxvt	PENTEST (1)	No
VirtualBox	INTERNET (4)	No
XFCE4 Terminal	PENTEST (1)	No
🎯 Configuration Details
Colors

    Normal: #D8DEE9 on #0f101a with #2F343F border

    Selected: #2e3440 on #C0C0C0 with #C0C0C0 border

    Main: #888888 on #0f101a with #0f101a border

    Root Bar: #00ffff on #0f101a with #550000 border

Workspace Tags
c

static const char *tags[] = { "PENTEST", "DEVEL", "MISC", "INTERNET", "\u25f2" };

Key Modifiers

    Super = Mod4Mask (Windows/Meta key)

    Shift = ShiftMask

    Ctrl = ControlMask

🚀 Quick Start Workflows
Development Session
bash

Super + 2        # Switch to DEVEL workspace
Super + Shift + C # Launch VS Code
Super + Enter     # Open terminal

Internet Browsing
bash

Super + 4        # Switch to INTERNET workspace  
Super + F        # Launch Firefox

Terminal Multi-tasking
bash

Super + M        # Switch to PENTEST workspace
Super + A        # Open green XTerm (large)
Super + B        # Open yellow URxvt
Super + C        # Open red URxvt

🐛 Troubleshooting
Common Issues

    Applications not launching in correct workspace: Check auto-assign rules in config.h

    Gaps not changing: Ensure gaplessgrid patch is properly installed

    Colors not updating: Restart DWM with Super + Ctrl + R

Dependencies

    dmenu or rofi for application launcher

    scrot for screenshots

    xfce4-screenshooter for Print Screen functionality

    redshift for color temperature control

    brightnessctl for backlight control

    urxvt and xterm terminals

📝 Notes

    All shortcuts use the Super (Windows/Meta) key as modifier

    Workspace numbers start from 1 (not 0)

    The 5th workspace uses a special Unicode symbol (⭒)

    Color schemes can be cycled through 4 different configurations

    The bar can be toggled on/off with Super + Shift + B

License: MIT
Maintainer: Your Name
Last Updated: $(date)
