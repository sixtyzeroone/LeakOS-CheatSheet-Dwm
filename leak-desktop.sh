#!/usr/bin/env bash
set -e

# ==================================================
# COLOR DEFINITIONS
# ==================================================
RESET="\e[0m"
BOLD="\e[1m"

RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
MAGENTA="\e[35m"
CYAN="\e[36m"
WHITE="\e[37m"

# Category colors
C_MITM="$RED"
C_INTEL="$CYAN"
C_VULN="$MAGENTA"
C_SERVICE="$GREEN"

# ==================================================
# ASCII BANNER LEAKOS (CUSTOM)
# ==================================================
clear
echo -e "${BOLD}${BLUE}"
cat << "EOF"
██╗     ███████╗ █████╗ ██╗  ██╗ ██████╗ ███████╗
██║     ██╔════╝██╔══██╗██║ ██╔╝██╔═══██╗██╔════╝
██║     █████╗  ███████║█████╔╝ ██║   ██║███████╗
██║     ██╔══╝  ██╔══██║██╔═██╗ ██║   ██║╚════██║
███████╗███████╗██║  ██║██║  ██╗╚██████╔╝███████║
╚══════╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝

     LeakOS Network Desktop Auto-Fix PRO
   SAFE MODE • Colored • Progress • XFCE
EOF
echo -e "${RESET}"

# ==================================================
# CONFIG
# ==================================================
APPDIR="/usr/share/applications"
ICON="/usr/share/icons/Treepata/apps/48/Terminal.png"

# ==================================================
# PROGRESS BAR
# ==================================================
progress_bar() {
  local current=$1
  local total=$2
  local width=30
  local filled=$(( current * width / total ))
  local empty=$(( width - filled ))

  printf "\r${BOLD}["
  printf "%0.s█" $(seq 1 $filled)
  printf "%0.s " $(seq 1 $empty)
  printf "] %d/%d${RESET}" "$current" "$total"
}

# ==================================================
# WRITE DESKTOP (SAFE MODE)
# ==================================================
write_desktop() {
  local name="$1"
  local category="$2"
  local comment="$3"
  local color="$4"
  local file="$APPDIR/$name.desktop"

  if [ -f "$file" ]; then
    echo -e "${YELLOW}[SKIP]${RESET} $name.desktop already exists"
    return
  fi

  cat > "$file" <<EOF
[Desktop Entry]
Name=$name
Comment=$comment
Exec=/bin/bash -c "$name; exec bash"
Icon=$ICON
Terminal=true
Type=Application
Categories=$category;
StartupNotify=true
EOF

  chmod 644 "$file"
  echo -e "${color}[CREATED]${RESET} $name → ${category}"
}

# ==================================================
# TOOL DEFINITIONS
# ==================================================

declare -A MITM_TOOLS=(
  [wireshark]="GUI network packet analyzer"
  [tshark]="CLI packet capture and analysis tool"
  [tcpdump]="Command-line packet sniffer"
  [ngrep]="Network grep packet analyzer"
  [netsniff-ng]="High performance packet sniffer"
  [ssldump]="SSL/TLS traffic analyzer"
  [tcpreplay]="Replay captured network traffic"
  [hping3]="Packet crafting and TCP/IP testing tool"
  [netcat]="Network utility for reading and writing data"
  [socat]="Multipurpose bidirectional data relay"
)

declare -A INTEL_TOOLS=(
  [nmap]="Network exploration and reconnaissance tool"
  [netdiscover]="ARP-based network reconnaissance tool"
  [arp-scan]="ARP scanning and host discovery tool"
  [traceroute]="Trace network route to host"
  [mtr]="Network diagnostic traceroute tool"
  [p0f]="Passive OS fingerprinting tool"
)

declare -A VULN_TOOLS=(
  [masscan]="Fast TCP port scanner"
  [zmap]="Internet-wide network scanner"
)

declare -A SERVICE_TOOLS=(
  [iftop]="Display bandwidth usage on network interfaces"
  [nethogs]="Per-process network bandwidth monitor"
  [iptraf-ng]="Interactive IP traffic monitor"
  [bmon]="Bandwidth monitor and rate estimator"
  [zeek]="Network security monitoring framework"
  [snort]="Intrusion detection system"
  [suricata]="Network threat detection engine"
)

TOTAL=$(( ${#MITM_TOOLS[@]} + ${#INTEL_TOOLS[@]} + ${#VULN_TOOLS[@]} + ${#SERVICE_TOOLS[@]} ))
COUNT=0

# ==================================================
# PROCESS FUNCTION
# ==================================================
process_group() {
  local -n tools=$1
  local category="$2"
  local color="$3"
  local title="$4"

  echo -e "\n${BOLD}${color}[*] $title${RESET}"

  for t in "${!tools[@]}"; do
    command -v "$t" &>/dev/null || continue
    COUNT=$((COUNT+1))
    progress_bar "$COUNT" "$TOTAL"
    write_desktop "$t" "$category" "${tools[$t]}" "$color"
    sleep 0.05
  done
}

# ==================================================
# RUN
# ==================================================
process_group MITM_TOOLS "LEAKOS-mitm" "$C_MITM" "MITM / Sniffing Tools"
process_group INTEL_TOOLS "LEAKOS-intelligent-gather" "$C_INTEL" "Intelligent Gathering"
process_group VULN_TOOLS "LEAKOS-vuln-analysis" "$C_VULN" "Vulnerability Analysis"
process_group SERVICE_TOOLS "LEAKOS-service" "$C_SERVICE" "Service & Monitoring"

echo -e "\n\n${GREEN}${BOLD}[✓] COMPLETED${RESET} LeakOS Network desktop entries generated safely."
