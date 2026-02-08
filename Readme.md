# LeakOS Linux Dwm Cheatsheet
**MODKEY** = **Super / Windows key** (Mod4Mask)


| Tombol                        | Fungsi                                   | Keterangan / Aplikasi                     |
|-------------------------------|------------------------------------------|--------------------------------------------|
| **Super + Enter**             | Buka terminal                            | xfce4-terminal                             |
| **Super + m**                 | Buka menu utama                          | `leak` (custom launcher/menu)              |
| **Super + e**                 | File manager                             | Thunar                                     |
| **Super + f**                 | Buka Firefox → tag INTERNET              | Langsung ke tag 4                          |
| **Super + Shift + c**         | Buka VS Code → tag DEVEL                 | tag 2                                      |
| **Super + Shift + v**         | Buka vim di xterm → tag DEVEL            | tag 2                                      |
| **Super + w**                 | Tutup window aktif                       | killclient                                 |
| **Super + s**                 | Screenshot full screen                   | scrot                                      |
| **Super + Shift + s**         | Screenshot area (select region)          | scrot -s                                   |
| **Print Screen**              | Screenshot interaktif                    | xfce4-screenshooter -f                     |

## Navigasi & Manipulasi Window

| Tombol                        | Fungsi                                   |
|-------------------------------|------------------------------------------|
| **Super + j** / **k**         | Focus window berikutnya / sebelumnya     |
| **Super + Shift + j** / **k** | Rotate stack window (bawah / atas)       |
| **Super + Shift + f**         | Toggle floating ↔ tiling                 |
| **Super + Tab**               | Ganti layout berikutnya                  |
| **Super + Shift + Tab**       | Ganti layout sebelumnya                  |
| **Super + Shift + b**         | Munculkan / sembunyikan bar              |

## Ukuran & Master Area

| Tombol                        | Fungsi                                   |
|-------------------------------|------------------------------------------|
| **Super + Shift + h**         | Kurangi lebar master area                |
| **Super + Shift + l**         | Tambah lebar master area                 |
| **Super + i**                 | Tambah jumlah client di master           |
| **Super + Shift + i**         | Kurangi jumlah client di master          |
| **Super + g**                 | Kurangi ukuran gap                       |
| **Super + Shift + g**         | Tambah ukuran gap                        |

## Pindah Tag / Workspace

| Tombol              | Tag      | Nama Tag     |
|---------------------|----------|--------------|
| **Super + m**       | 1        | PENTEST      |
| **Super + 2**       | 2        | DEVEL        |
| **Super + 3**       | 3        | MISC         |
| **Super + 4**       | 4        | INTERNET     |
| **Super + 5**       | 5        | ⬚            |

**Tambahan kombinasi:**
- **Super + Ctrl + [1–5]**   → toggle view tag (tampilkan tambahan)
- **Super + Shift + [1–5]**  → pindahkan window aktif ke tag tersebut

## Pindah antar Monitor

| Tombol                        | Fungsi                                   |
|-------------------------------|------------------------------------------|
| **Super + ,**                 | Focus monitor sebelumnya                 |
| **Super + .**                 | Focus monitor berikutnya                 |
| **Super + Shift + ,**         | Pindah window ke monitor sebelumnya      |
| **Super + Shift + .**         | Pindah window ke monitor berikutnya      |

## Aplikasi & Tools Khusus

| Tombol                        | Aplikasi / Perintah                      | Tag tujuan   |
|-------------------------------|------------------------------------------|--------------|
| **Super + Shift + n**         | nano di xterm                            | INTERNET     |
| **Super + F3**                | VirtualBox                               | MISC         |
| **Super + F12**               | Toggle root mode (custom patch)          | —            |
| **Super + r**                 | Redshift malam (2400K)                   | —            |
| **Super + Shift + r**         | Matikan redshift                         | —            |
| **Super + ↑**                 | Brightness +10%                          | —            |
| **Super + ↓**                 | Brightness -10%                          | —            |

## Layout yang Tersedia

| Simbol   | Nama Layout          | Cara aktifkan                          |
|----------|----------------------|----------------------------------------|
| [F]      | Floating             | Default / no arrange function          |
| [M]      | Gapless Grid         | **Super + Shift + f** atau patch       |
| []=      | Tile                 | Klik kanan di LtSymbol bar             |

- **Super + Tab** / **Shift + Tab** → cycle layout

## Mouse Bindings (dengan Super)

| Aksi Mouse                              | Fungsi                     |
|-----------------------------------------|----------------------------|
| **Super + Klik kiri** di window         | Drag / pindah window       |
| **Super + Klik tengah** di window       | Toggle floating            |
| **Super + Klik kanan** di window        | Resize window              |
| **Klik tengah** di status text          | Buka terminal              |
| **Klik kiri** di tag bar                | Pindah ke tag              |
| **Klik kanan** di tag bar               | Toggle tag (tambah/tutup)  |
| **Klik kiri** di LtSymbol               | Reset / kembali layout     |
| **Klik kanan** di LtSymbol              | Ganti ke tile + cycle      |
