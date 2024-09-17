alias server='./script/server | tee /tmp/log.log'

slog() {
    rg $1 -C ${2:-"1"} --context-separator "\n\n" /tmp/log.log
}
