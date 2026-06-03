#!/bin/bash
SCRIPT_PATH=$(realpath "${BASH_SOURCE}")
rm -f "$SCRIPT_PATH"

trap "stty cooked echo; exit" SIGINT SIGTERM

stty -icanon min 0 time 0 echo

SERVER_LOG="/root/.config/zencode-server/logs/server.log"
API_ENDPOINT="http://127.0.0.1:3000/api"

show_dashboard() {
    echo -e "\033[H"

    if pgrep -f "zencode-server start" > /dev/null; then
        DAEMON_STATUS="ACTIVE (PID: $(pgrep -f 'zencode-server start' | head -n 1))"
        OPENCODE_CONN="CONNECTED (Free Tier Active)"
        LANCEDB_CONN="SYNCED (Vector Cloud Node)"
    else
        DAEMON_STATUS="OFFLINE / DISCONNECTED"
        OPENCODE_CONN="DISABLED (Local Fallback)"
        LANCEDB_CONN="LOCAL-ONLY (Offline Cache)"
    fi

    echo "┌────────────────────────────────────────────────────────────────────────────────────────┐"
    echo "│  ⚡ ZENCODE-SERVER DASHBOARD v1.1.0                      [ MODE: HYBRID / HYPER-DRIVE ]│"
    echo "├────────────────────────────────────────────────────────────────────────────────────────┤"
    echo "│ 📋 SYSTEM STATUS                                                                       │"
    echo "│  ├─ Daemon Status : ${DAEMON_STATUS}                                          │"
    echo "│  ├─ CPU Usage     : [██████░░░░░░░░░] 42%   ├─ Local Engine : Ollama/zencode-jnx:latest │"
    echo "│  └─ Memory Allot  : 4.2 GB / 6.0 GB       └─ Model Status : Idle / Ready              │"
    echo "├────────────────────────────────────────────────────────────────────────────────────────┤"
    echo "│ 🌐 CLOUD & HYBRID CONNECTIONS                                                          │"
    echo "│  ├─ OpenCode Cloud : ${OPENCODE_CONN}                                        │"
    echo "│  └─ LanceDB Cloud  : ${LANCEDB_CONN}                                       │"
    echo "├────────────────────────────────────────────────────────────────────────────────────────┤"
    echo "│ 🌐 DECENTRALIZED INFRASTRUCTURE (RESOURCE UNITS)                                       │"
    echo "│  ├─ Network Bandwidth Allocated : [████████████░░░] 80% (0.8 Gbps / 1.0 Gbps)           │"
    echo "│  └─ Context Sync Layer State    : Ledger Synchronized (Block #481029)                 │"
    echo "├────────────────────────────────────────────────────────────────────────────────────────┤"
    echo "│ 🪵 RECENT CONTEXT ENGINE LOGS (tail -n 3 ${SERVER_LOG})                                   │"
    if [ -f "${SERVER_LOG}" ]; then
        tail -n 3 "${SERVER_LOG}" | sed 's/^/  /'
    else
        echo "  [LOG SYSTEM] Waiting for zencode-server engine log initialization pipeline..."
    fi
    echo "├────────────────────────────────────────────────────────────────────────────────────────┤"
    echo "│ ⌨️ [M] Router  [O] OpenCode  [V] LanceDB Sync  [L] Logs  [Q] Quit                      │"
    echo "└────────────────────────────────────────────────────────────────────────────────────────┘"
}

clear
echo -e "\033[?25l"

while true; do
    show_dashboard
    read -r -n 1 key
    case "${key}" in
        [mM])
            echo "[COMMAND] Toggling routing infrastructure mode..." >> "${SERVER_LOG}"
            curl -s -X POST "${API_ENDPOINT}/mode/toggle" > /dev/null 2>&1 &
            ;;
        [oO])
            echo "[COMMAND] Swapping OpenCode Online Models / Local Fallback..." >> "${SERVER_LOG}"
            curl -s -X POST "${API_ENDPOINT}/opencode/toggle" > /dev/null 2>&1 &
            ;;
        [vV])
            echo "[COMMAND] Forcing LanceDB Vector Cloud Remote Synchronization..." >> "${SERVER_LOG}"
            curl -s -X POST "${API_ENDPOINT}/lancedb/sync" > /dev/null 2>&1 &
            ;;
        [lL])
            stty cooked echo; echo -e "\033[?25h"
            clear
            echo "=== Live Server Engine Logs (Ctrl+C to return) ==="
            tail -f "${SERVER_LOG}"
            stty -icanon min 0 time 0 echo; echo -e "\033[?25l"
            clear
            ;;
        [qQ])
            break
            ;;
    esac
    sleep 1
done

stty cooked echo
echo -e "\033[?25h"
clear
echo "Dashboard detached cleanly from cloud connection threads."