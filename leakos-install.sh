#!/bin/bash

# --- Konfigurasi Direktori ---
LFS_PACKAGES_DIR="/usr/share/leakos/packages"
LFS_BUILD_DIR="/usr/share/leakos/build"
LFS_LOG_DIR="/var/log/leakos/packages"
PACKAGE_LIST_URL="https://raw.githubusercontent.com/LeakOSID/meta-packages/main/packages.txt"

# --- Warna Terminal ---
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
WHITE='\033[1;37m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# --- Fungsi Banner ---
show_banner() {
    clear
    echo -e "${CYAN}"
    echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
    echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
    echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
    echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
    echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
    echo "@@@@@@@@@@@@%%#=%@@@@@@@@@@@@@@@@@@@@@@@@@%##%%@@@@@@@@@@@@"
    echo "@@@@@@@@@@@@#:::*%@@@@@%%%%%%%%%%%%%@@@@@%*:::#@@@@@@@@@@@@"
    echo "@@@@@@@@@@@%#.@@@:####:::*@@@@@@@#:::###*:@@@-#%@@@@@@@@@@@"
    echo "@@@@@@@@@@@@#:@%@@#%@@@@@@@@@@@@@@@%#%@%@:#@@@@@@@@@@@@@@@@"
    echo "@@@@@@@@@@@@%#:@@@@@@%@@@@@@@@@@@@@@@%@@@@@@:*%@@@@@@@@@@@@"
    echo "@@@@@@@@@@@@@#-:@@@@@%#@@@@@@%%@@@%@%@@@@@@.##%@@@@@@@@@@@@"
    echo "@@@@@@@@@@@@%*=@@@@@@%@%%@@@@@@@@@%%@%%@@@@@#+%@@@@@@@@@@@@"
    echo "@@@@@@@@@@@%=:@@@@@@@=..#%@@@@@@@%#:..@@@@@@@::%@@@@@@@@@@@"
    echo "@@@@@@@@@@%-%@@@@@@@@%+...@@@@@@@...-%@@@@@@@@@:%@@@@@@@@@@"
    echo "@@@@@@@@@@%:@@@@@@@%@@@%%%%#*=*#%%%%@@@@@@@@@@@:#@@@@@@@@@@"
    echo "@@@@@@@@@%*#%@@@@@@@%@@@@@@%#+*#@@@@@@%@@@@@@@@@+%@@@@@@@@@"
    echo "@@@@@@@@@%:@@@@@@@@@@@@@@@@@@%@@@@@@@@@@@@@@@@@@:#@@@@@@@@@"
    echo "@@@@@@@@@%:@@@@@%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@:%@@@@@@@@@"
    echo "@@@@@@@@@%#:%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@:#%@@@@@@@@@"
    echo "@@@@@@@@@@@%-:%@@@@%@@%%@@@@%@%@@@@@@@@%@@@@@-:%%@@@@@@@@@@"
    echo "@@@@@@@@@@@@%%#:%%@@@@@@%%@@%%%@@%%@@@@@@%%:#%%@@@@@@@@@@@@"
    echo "@@@@@@@@@@@@@@@%##:%%%%@@@%@%#%@%@@@@%%%:*#%@@@@@@@@@@@@@@@"
    echo "@@@@@@@@@@@@@@@@@@%##:+##*@@@%@@@###+:#%%@@@@@@@@@@@@@@@@@@"
    echo "@@@@@@@@@@@@@@@@@@@@@%#-.**+++*#.:#%%@@@@@@@@@@@@@@@@@@@@@@"
    echo "@@@@@@@@@@@@@@@@@@@@@@@@%##:::##%@@@@@@@@@@@@@@@@@@@@@@@@@@"
    echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
    echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
    echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
    echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
    echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@+@@@"
    echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
    echo -e "${NC}"

    echo -e "${YELLOW}  =[ leakos.org | @LeakOSID                ]="
    echo -e "  =[ v2.0-dev                              ]="
    echo -e "  =[ Author: LeakOSID Team                 ]="
    echo -e "  =[ Contributors: Open Source Community   ]=${NC}"
    echo ""
}

# Inisialisasi Direktori
mkdir -p "$LFS_BUILD_DIR"
mkdir -p "$LFS_LOG_DIR"

if [[ $EUID -ne 0 ]]; then
    show_banner
    echo -e "${RED}Error: Skrip ini harus dijalankan sebagai root (sudo).${NC}"
    exit 1
fi

# --- Fungsi Pendukung ---

get_package_url() {
    local package_name=$1
    local url
    url=$(curl -s "$PACKAGE_LIST_URL" | grep -E "^${package_name} " | cut -d ' ' -f 2)
    if [[ -z "$url" ]]; then
        echo -e "${RED}[-] Error: Paket '$package_name' tidak ditemukan.${NC}"
        return 1
    fi
    echo "$url"
}

extract_package() {
    local package_file=$1
    case "$package_file" in
        *.tar.gz)  tar -xzf "$package_file" ;;
        *.tar.xz)  tar -xJf "$package_file" ;;
        *.tar.bz2) tar -xjf "$package_file" ;;
        *) echo "Format arsip tidak didukung."; return 1 ;;
    esac
}

# --- Fungsi Format Ukuran File (dengan fallback) ---
format_size() {
    local size=$1
    
    # Cek apakah bc tersedia
    if command -v bc &>/dev/null; then
        if (( $(echo "$size > 1073741824" | bc -l 2>/dev/null) )); then
            echo "$(echo "scale=2; $size/1073741824" | bc)G"
        elif (( $(echo "$size > 1048576" | bc -l 2>/dev/null) )); then
            echo "$(echo "scale=2; $size/1048576" | bc)M"
        elif (( $(echo "$size > 1024" | bc -l 2>/dev/null) )); then
            echo "$(echo "scale=2; $size/1024" | bc)K"
        else
            echo "${size}B"
        fi
    else
        # Fallback tanpa bc (pembulatan ke integer)
        if [[ $size -gt 1073741824 ]]; then
            echo "$((size / 1073741824))G"
        elif [[ $size -gt 1048576 ]]; then
            echo "$((size / 1048576))M"
        elif [[ $size -gt 1024 ]]; then
            echo "$((size / 1024))K"
        else
            echo "${size}B"
        fi
    fi
}

# --- Fungsi Mendapatkan Info Paket ---
get_package_info() {
    local package_name=$1
    local package_dir="${LFS_BUILD_DIR}/${package_name}"
    local info=""
    
    if [[ -d "$package_dir" ]]; then
        # Hitung ukuran folder dalam bytes
        local size=$(du -sb "$package_dir" 2>/dev/null | cut -f1)
        info=$(format_size $size)
    else
        info="N/A"
    fi
    echo "$info"
}

# --- Fungsi Utama ---

install_package() {
    local package_name=$1
    local package_url
    package_url=$(get_package_url "$package_name") || return 1

    local package_dir="${LFS_BUILD_DIR}/${package_name}"
    local log_file="${LFS_LOG_DIR}/${package_name}.log"

    cd "$LFS_BUILD_DIR" || exit

    # --- LOGIKA DOWNLOAD / UPDATE ---
    if [[ -d "$package_dir" ]]; then
        echo -e "${YELLOW}[!] Direktori $package_name sudah ada.${NC}"
        cd "$package_dir" || exit
        if [[ -d ".git" ]]; then
            echo -e "${BLUE}[*] Menarik pembaruan dari GitHub (git pull)...${NC}"
            git pull
        else
            echo -e "${YELLOW}[!] Folder bukan repositori git, menggunakan file yang ada.${NC}"
        fi
    else
        echo -e "${BLUE}[*] Mengunduh: $package_name...${NC}"
        if [[ "$package_url" == *.tar.* ]]; then
            wget -q "$package_url" -O "$package_name.archive"
            extract_package "$package_name.archive"
            rm -f "$package_name.archive"
            # Coba masuk ke folder hasil ekstrak
            local extracted_dir=$(find . -maxdepth 1 -type d -name "*$package_name*" | head -n 1)
            if [[ -n "$extracted_dir" ]]; then
                cd "$extracted_dir" || exit
            else
                cd "$(ls -d */ 2>/dev/null | head -n 1)" || exit
            fi
        else
            git clone --depth 1 "$package_url" "$package_name"
            cd "$package_name" || exit
        fi
    fi

    echo -e "${BLUE}[*] Mendeteksi sistem build...${NC}"
    # Mencari file .pl atau binary tanpa ekstensi yang bisa dijalankan
    local script_file=$(find . -maxdepth 3 -type f \( -name "${package_name}.pl" -o -name "${package_name}" \) -executable | head -n 1)

    if [[ -n "$script_file" && ! -f "Makefile" && ! -f "meson.build" && ! -f "CMakeLists.txt" ]]; then
        echo -e "${YELLOW}[!] Manual Script detected (e.g. Nikto).${NC}"
        chmod +x "$script_file"
        ln -sf "$(pwd)/${script_file#./}" "/usr/bin/${package_name}"
        echo "/usr/bin/${package_name}" > "$log_file"
        echo -e "${GREEN}[+] Symlink created: /usr/bin/${package_name}${NC}"

    # --- ALUR DETEKSI BUILD SYSTEM ---
    elif [[ -f "Makefile.PL" ]]; then
        echo -e "${YELLOW}[!] Perl detected.${NC}"
        perl Makefile.PL INSTALLDIRS=vendor && make && make install | tee "$log_file"

    elif [[ -f "meson.build" ]]; then
        echo -e "${YELLOW}[!] Meson detected.${NC}"
        rm -rf build 
        meson setup build --prefix=/usr && ninja -j$(nproc) -C build && ninja -C build install | tee "$log_file"

    elif [[ -f "configure" ]]; then
        echo -e "${YELLOW}[!] Autotools detected.${NC}"
        ./configure --prefix=/usr && make -j$(nproc) && make install | tee "$log_file"

    elif [[ -f "CMakeLists.txt" ]]; then
        echo -e "${YELLOW}[!] CMake detected.${NC}"
        rm -rf build && mkdir build && cd build
        cmake -DCMAKE_INSTALL_PREFIX=/usr .. && make -j$(nproc) && make install | tee "$log_file"
        cd ..

    elif [[ -f "setup.py" || -f "pyproject.toml" ]]; then
        echo -e "${YELLOW}[!] Python detected.${NC}"
        pip3 install . --break-system-packages 2>/dev/null || pip3 install .
        touch "$log_file"

    elif [[ -f "Gemfile" ]] || ls *.gemspec 2>/dev/null | grep -q . || [[ -f "Rakefile" ]]; then
        echo -e "${YELLOW}[!] Ruby project detected.${NC}"
        
        if [[ -f "Gemfile" ]]; then
            echo -e "${BLUE}[*] Running bundle install...${NC}"
            bundle install | tee "$log_file"
        fi

        local gemspec=$(ls *.gemspec 2>/dev/null | head -n 1)
        if [[ -n "$gemspec" ]]; then
            echo -e "${BLUE}[*] Building and installing Ruby Gem...${NC}"
            gem build "$gemspec"
            gem install ./*.gem --no-document | tee -a "$log_file"
        elif [[ -f "Rakefile" ]]; then
            echo -e "${BLUE}[*] Running rake install...${NC}"
            rake install | tee -a "$log_file" 2>/dev/null || rake | tee -a "$log_file"
        fi
        
    elif [[ -f "go.mod" ]]; then
        echo -e "${YELLOW}[!] Go detected.${NC}"
        go build -o "$package_name" && cp -v "$package_name" /usr/bin/ | tee "$log_file"

    elif [[ -f "package.json" ]]; then
        echo -e "${YELLOW}[!] Node.js detected.${NC}"
        npm install -g | tee "$log_file"

    elif [[ -f "Cargo.toml" ]]; then
        echo -e "${YELLOW}[!] Rust detected.${NC}"
        cargo install --path . --root /usr | tee "$log_file"

    elif [[ -f "Makefile" ]]; then
        echo -e "${YELLOW}[!] Makefile detected.${NC}"
        make clean 2>/dev/null
        make -j$(nproc) && make install | tee "$log_file"

    else
        echo -e "${RED}[-] Gagal: Sistem build tidak dikenali.${NC}"
        return 1
    fi

    echo -e "${GREEN}[+] Berhasil: $package_name telah terpasang/diperbarui.${NC}"
}

uninstall_package() {
    local package_name=$1
    local log_file="${LFS_LOG_DIR}/${package_name}.log"
    local package_dir="${LFS_BUILD_DIR}/${package_name}"

    echo -e "${YELLOW}[*] Menghapus paket: $package_name...${NC}"

    # 1. Log-based cleanup
    if [[ -f "$log_file" ]]; then
        echo -e "${BLUE}[*] Membersihkan file sistem...${NC}"
        
        while IFS= read -r line; do
            # Cari path yang dimulai dengan direktori sistem
            local path=""
            for dir in /usr /etc /bin /sbin /lib /var /opt /home; do
                if [[ "$line" == *"$dir"* ]]; then
                    # Ekstrak path menggunakan parameter expansion
                    local temp="${line#*$dir}"
                    temp="$dir${temp%% *}"
                    # Bersihkan dari karakter khusus
                    path=$(echo "$temp" | sed "s/['\",:;]//g")
                    
                    if [[ -e "$path" ]]; then
                        rm -rf "$path"
                        echo "  Menghapus: $path"
                    fi
                    break
                fi
            done
        done < "$log_file"
        
        rm -f "$log_file"
    fi
    
    # 2. Package manager cleanups
    if command -v gem &>/dev/null; then
        gem list -i "$package_name" &>/dev/null && gem uninstall "$package_name" -a -x --force &>/dev/null
    fi
    
    if command -v pip3 &>/dev/null; then
        pip3 uninstall -y "$package_name" --break-system-packages &>/dev/null
    fi
    
    if command -v npm &>/dev/null; then
        npm uninstall -g "$package_name" &>/dev/null
    fi
    
    if command -v cargo &>/dev/null; then
        cargo uninstall "$package_name" &>/dev/null
    fi
    
    # 3. Binary cleanup
    if [[ -L "/usr/bin/$package_name" || -f "/usr/bin/$package_name" ]]; then
        rm -f "/usr/bin/$package_name"
        echo "  Menghapus: /usr/bin/$package_name"
    fi

    # 4. Hapus folder source
    if [[ -d "$package_dir" ]]; then
        echo -e "${BLUE}[*] Menghapus folder sumber...${NC}"
        rm -rf "$package_dir"
    fi

    echo -e "${GREEN}[+] $package_name berhasil dihapus total.${NC}"
}

list_installed() {
    # Dapatkan lebar terminal
    local term_width=$(tput cols 2>/dev/null || echo 80)
    
    # Minimal lebar 60, maksimal 120
    if [[ $term_width -lt 60 ]]; then
        term_width=60
    elif [[ $term_width -gt 120 ]]; then
        term_width=120
    fi
    
    # Hitung lebar kolom
    local no_width=4
    local date_width=12
    local size_width=10
    local name_width=$((term_width - no_width - date_width - size_width - 15))
    
    # Header atas
    echo -e "${MAGENTA}╔$(printf '═%.0s' $(seq 1 $((term_width-2))))╗${NC}"
    
    # Judul
    local title="LEAKOS PACKAGE MANAGER"
    local title_padding=$(( (term_width - ${#title} - 4) / 2 ))
    printf "${MAGENTA}║${NC}%*s${WHITE}${BOLD}%s${NC}%*s${MAGENTA}║${NC}\n" $title_padding "" "$title" $title_padding ""
    
    echo -e "${MAGENTA}╠$(printf '═%.0s' $(seq 1 $((term_width-2))))╣${NC}"
    
    # Subjudul
    local subtitle="INSTALLED PACKAGES"
    local subtitle_padding=$(( (term_width - ${#subtitle} - 4) / 2 ))
    printf "${MAGENTA}║${NC}%*s${YELLOW}${BOLD}%s${NC}%*s${MAGENTA}║${NC}\n" $subtitle_padding "" "$subtitle" $subtitle_padding ""
    
    echo -e "${MAGENTA}╠$(printf '═%.0s' $(seq 1 $((term_width-2))))╣${NC}"
    
    # Header tabel
    printf "${MAGENTA}║${WHITE}${BOLD} %-${no_width}s │ %-${name_width}s │ %-${size_width}s │ %-${date_width}s ${MAGENTA}║${NC}\n" "No" "Package Name" "Size" "Install Date"
    
    # Garis pemisah header
    printf "${MAGENTA}╠${NC}"
    printf "${MAGENTA}═%.0s${NC}" $(seq 1 $((no_width+2)))
    printf "${MAGENTA}╪${NC}"
    printf "${MAGENTA}═%.0s${NC}" $(seq 1 $((name_width+2)))
    printf "${MAGENTA}╪${NC}"
    printf "${MAGENTA}═%.0s${NC}" $(seq 1 $((size_width+2)))
    printf "${MAGENTA}╪${NC}"
    printf "${MAGENTA}═%.0s${NC}" $(seq 1 $((date_width+2)))
    printf "${MAGENTA}╣${NC}\n"
    
    local count=0
    local total_size=0
    declare -a package_names
    declare -a package_sizes
    declare -a package_dates
    
    # Baca paket terinstall
    if [[ -d "$LFS_LOG_DIR" ]]; then
        while IFS= read -r log_file; do
            count=$((count + 1))
            package_name=$(basename "$log_file" .log)
            package_names+=("$package_name")
            
            local size_info=$(get_package_info "$package_name")
            package_sizes+=("$size_info")
            
            if [[ -f "$log_file" ]]; then
                install_date=$(stat -c %y "$log_file" 2>/dev/null | cut -d'.' -f1 | cut -d' ' -f1)
            else
                install_date="N/A"
            fi
            package_dates+=("$install_date")
            
            # Hitung total size
            if [[ "$size_info" != "N/A" ]]; then
                local num_value=$(echo "$size_info" | sed 's/[A-Za-z]//g')
                local unit=$(echo "$size_info" | sed 's/[0-9.]//g')
                
                if command -v awk &>/dev/null; then
                    case $unit in
                        "K") total_size=$(awk "BEGIN {printf \"%.0f\", $total_size + ($num_value * 1024)}") ;;
                        "M") total_size=$(awk "BEGIN {printf \"%.0f\", $total_size + ($num_value * 1048576)}") ;;
                        "G") total_size=$(awk "BEGIN {printf \"%.0f\", $total_size + ($num_value * 1073741824)}") ;;
                        "B") total_size=$(awk "BEGIN {printf \"%.0f\", $total_size + $num_value}") ;;
                    esac
                else
                    # Fallback tanpa floating point
                    case $unit in
                        "K") total_size=$((total_size + $(echo "$num_value * 1024" | bc 2>/dev/null || echo 0))) ;;
                        "M") total_size=$((total_size + $(echo "$num_value * 1048576" | bc 2>/dev/null || echo 0))) ;;
                        "G") total_size=$((total_size + $(echo "$num_value * 1073741824" | bc 2>/dev/null || echo 0))) ;;
                        "B") total_size=$((total_size + $(echo "$num_value" | bc 2>/dev/null || echo 0))) ;;
                    esac
                fi
            fi
        done < <(find "$LFS_LOG_DIR" -name "*.log" -type f 2>/dev/null)
    fi
    
    # Tampilkan data paket
    if [[ $count -eq 0 ]]; then
        local empty_msg="✗ No packages installed"
        local empty_padding=$(( (term_width - ${#empty_msg} - 4) / 2 ))
        printf "${MAGENTA}║${NC}%*s${RED}${BOLD}%s${NC}%*s${MAGENTA}║${NC}\n" $empty_padding "" "$empty_msg" $empty_padding ""
    else
        for ((i=0; i<count; i++)); do
            local display_name="${package_names[$i]}"
            if [[ ${#display_name} -gt $name_width ]]; then
                display_name="${display_name:0:$((name_width-3))}..."
            fi
            
            if (( (i+1) % 2 == 0 )); then
                printf "${MAGENTA}║${CYAN} %-${no_width}s │ %-${name_width}s │ %-${size_width}s │ %-${date_width}s ${MAGENTA}║${NC}\n" \
                    "$((i+1))" "$display_name" "${package_sizes[$i]}" "${package_dates[$i]}"
            else
                printf "${MAGENTA}║${GREEN} %-${no_width}s │ %-${name_width}s │ %-${size_width}s │ %-${date_width}s ${MAGENTA}║${NC}\n" \
                    "$((i+1))" "$display_name" "${package_sizes[$i]}" "${package_dates[$i]}"
            fi
        done
    fi
    
    # Garis pemisah footer
    printf "${MAGENTA}╠${NC}"
    printf "${MAGENTA}═%.0s${NC}" $(seq 1 $((no_width+2)))
    printf "${MAGENTA}╧${NC}"
    printf "${MAGENTA}═%.0s${NC}" $(seq 1 $((name_width+2)))
    printf "${MAGENTA}╧${NC}"
    printf "${MAGENTA}═%.0s${NC}" $(seq 1 $((size_width+2)))
    printf "${MAGENTA}╧${NC}"
    printf "${MAGENTA}═%.0s${NC}" $(seq 1 $((date_width+2)))
    printf "${MAGENTA}╣${NC}\n"
    
    # Footer statistik
    if [[ $count -gt 0 ]]; then
        local total_size_formatted=$(format_size $total_size)
        local stats_msg="Total: $count packages  •  Size: $total_size_formatted"
        local stats_padding=$(( (term_width - ${#stats_msg} - 4) / 2 ))
        printf "${MAGENTA}║${NC}%*s${WHITE}${BOLD}%s${NC}%*s${MAGENTA}║${NC}\n" $stats_padding "" "$stats_msg" $stats_padding ""
        
        local dir_msg="Dir: $LFS_BUILD_DIR"
        if [[ ${#dir_msg} -gt $((term_width-6)) ]]; then
            dir_msg="Dir: ...${LFS_BUILD_DIR: -$((term_width-20))}"
        fi
        local dir_padding=$(( (term_width - ${#dir_msg} - 4) / 2 ))
        printf "${MAGENTA}║${NC}%*s${BLUE}%s${NC}%*s${MAGENTA}║${NC}\n" $dir_padding "" "$dir_msg" $dir_padding ""
    fi
    
    # Garis bawah
    echo -e "${MAGENTA}╚$(printf '═%.0s' $(seq 1 $((term_width-2))))╝${NC}"
    
    # Menu bantuan
    echo ""
    local help_width=$((term_width - 10))
    [[ $help_width -gt 80 ]] && help_width=80
    
    echo -e "${YELLOW}${BOLD}⚡ QUICK COMMANDS ⚡${NC}"
    echo -e "${GREEN}┌$(printf '─%.0s' $(seq 1 $help_width))┐${NC}"
    printf "${GREEN}│${NC} ${WHITE}%-${help_width}s ${GREEN}│${NC}\n" "install   <package>   : Install or update a package"
    printf "${GREEN}│${NC} ${WHITE}%-${help_width}s ${GREEN}│${NC}\n" "uninstall <package>   : Remove a package completely"
    printf "${GREEN}│${NC} ${WHITE}%-${help_width}s ${GREEN}│${NC}\n" "list                  : Show installed packages list"
    printf "${GREEN}│${NC} ${WHITE}%-${help_width}s ${GREEN}│${NC}\n" "help                  : Show usage information"
    echo -e "${GREEN}└$(printf '─%.0s' $(seq 1 $help_width))┘${NC}"
    
    # Contoh penggunaan
    echo ""
    echo -e "${BLUE}${BOLD}📦 EXAMPLE:${NC}"
    echo -e "  ${GREEN}▶${NC} ${WHITE}./leak-tools install nikto${NC}"
    echo -e "  ${GREEN}▶${NC} ${WHITE}./leak-tools uninstall nikto${NC}"
    echo -e "  ${GREEN}▶${NC} ${WHITE}./leak-tools list${NC}"
    echo ""
}

usage() {
    echo "Usage: $0 {install|uninstall|list}"
    echo "  install <name>   - Install/Update packages"
    echo "  uninstall <name> - Cleanly remove the package"
    echo "  list             - View installed packages"
    echo "  help             - Show this help message"
}

# --- Eksekusi ---
show_banner

case "$1" in
    install)
        [[ -z "$2" ]] && usage && exit 1
        install_package "$2"
        ;;
    uninstall)
        shift
        if [[ -z "$1" ]]; then
            echo -e "${RED}Error: Masukkan nama paket yang ingin dihapus.${NC}"
            exit 1
        fi
        for pkg in "$@"; do
            uninstall_package "$pkg"
        done
        ;;
    list)
        list_installed
        ;;
    help|--help|-h)
        usage
        ;;
    *)
        usage
        exit 1
        ;;
esac
