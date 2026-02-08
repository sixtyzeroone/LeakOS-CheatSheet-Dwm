DWM Cheatsheet
📋 Informasi Konfigurasi

    Gap antar window: 12px

    Border window: 1px

    Bar position: Top

    Bar height: 24px

    Master area factor: 0.55

    Master windows: 2

🪟 Window Management
Navigasi Window
Shortcut	Action
Super + J	Fokus ke window berikutnya
Super + K	Fokus ke window sebelumnya
Super + Tab	Cycle layout berikutnya
Super + Shift + Tab	Cycle layout sebelumnya
Super + .	Fokus ke monitor berikutnya
Super + ,	Fokus ke monitor sebelumnya
Super + F	Buka Firefox (auto ke workspace INTERNET)
Super + F12	Toggle root mode
Ukuran & Posisi Window
Shortcut	Action
Super + Shift + H	Perkecil area master (-5%)
Super + Shift + L	Perbesar area master (+5%)
Super + I	Tambah jumlah window di area master
Super + Shift + I	Kurangi jumlah window di area master
Super + G	Kurangi gap antar window
Super + Shift + G	Tambah gap antar window
Super + Shift + F	Toggle floating mode
Super + Shift + J	Rotate stack ke atas
Super + Shift + K	Rotate stack ke bawah
Layout Management
Shortcut	Action
Super + Shift + F	Switch ke layout floating
Super + ←	Toggle color scheme
Super + →	Cycle color scheme
Window Actions
Shortcut	Action
Super + W	Kill window aktif
Super + Shift + .	Pindah window ke monitor berikutnya
Super + Shift + ,	Pindah window ke monitor sebelumnya
🏢 Workspace Management
Workspace Navigation
Workspace	Shortcut	Deskripsi
PENTEST	Super + M	Terminal & pentesting tools
DEVEL	Super + 2	Development (VS Code, Vim)
MISC	Super + 3	Miscellaneous applications
INTERNET	Super + 4	Browser & internet apps
⭒	Super + 5	Extra workspace
Workspace dengan Modifier
Shortcut	Action
Super + Ctrl + 1-5	Toggle view workspace
Super + Shift + 1-5	Pindah window ke workspace
Super + Ctrl + Shift + 1-5	Toggle tag window
🚀 Application Launchers
Terminals
Shortcut	Application	Note
Super + Enter	XFCE4 Terminal	Default terminal
Super + A	XTerm hijau	84x26, black background
Super + B	URxvt kuning	55x26, black background
Super + C	URxvt merah	55x26, black background
Super + D	URxvt putih	55x26, black background
Development Tools
Shortcut	Application	Workspace
Super + Shift + C	VS Code	DEVEL
Super + Shift + V	Vim	DEVEL
Super + Shift + N	Nano	INTERNET
Aplikasi Lain
Shortcut	Application	Deskripsi
Super + M	Launch menu	leak/dmenu
Super + N	Dmenu run	Application launcher
Super + E	Thunar	File manager
Super + F3	VirtualBox	MISC workspace
Super + F	Firefox	Auto ke INTERNET workspace
⚙️ System & Hardware
Screenshots
Shortcut	Action
Print Screen	Full screenshot (xfce4-screenshooter)
Super + S	Scrot screenshot
Super + Shift + S	Scrot area selection
Display & Brightness
Shortcut	Action
Super + ↑	Brightness +10%
Super + ↓	Brightness -10%
Super + R	Redshift ON (2400K)
Super + Shift + R	Redshift OFF
System Controls
Shortcut	Action
Super + Ctrl + R	Restart DWM
Super + Shift + B	Toggle bar visibility
🖱️ Mouse Controls
Layout Symbol (Area kiri atas)
Action	Function
Left click	Set layout default
Right click	Cycle layouts
Window Title Bar
Action	Function
Middle click	Zoom/maximize window
Status Bar
Action	Function
Middle click	Buka terminal (urxvt)
Window Client Area
Shortcut	Function
Super + Left click	Move window
Super + Middle click	Toggle floating
Super + Right click	Resize window
Tag Bar (Workspace)
Shortcut	Function
Left click	Switch workspace
Right click	Toggle view workspace
Super + Left click	Tag window ke workspace
Super + Right click	Toggle tag window
🎨 Layouts Tersedia

    [F] - Floating layout (semua window floating)

    [M] - Gapless grid layout (grid tanpa gap)

    []= - Tile layout (master-slave)

🎯 Auto-Assign Rules
Application	Workspace	Floating
Firefox	INTERNET	No
Chromium	INTERNET	No
VS Code	DEVEL	No
XTerm (devterm)	DEVEL	No
URxvt	PENTEST	No
VirtualBox	INTERNET	No
XFCE4 Terminal	PENTEST	No
💡 Tips & Tricks
Workflow Cepat:

    Development: Super + 2 → Super + Shift + C untuk VS Code

    Internet: Super + 4 → Super + F untuk Firefox

    Terminal cepat: Super + Enter untuk XFCE4 terminal

Window Management:

    Gunakan Super + Shift + F untuk toggle floating window

    Super + Tab untuk cepat pindah layout

    Workspace spesifik app akan auto-launch di workspace yang ditentukan

    Gunakan mouse dengan modifier Super untuk window manipulation

Color Scheme Cycling:

    Tekan Super + → untuk cycle melalui 4 color schemes:

        Normal scheme

        Selection scheme

        Main scheme

        Root bar scheme

Catatan: Super = Windows/Meta key (Mod4Mask)
