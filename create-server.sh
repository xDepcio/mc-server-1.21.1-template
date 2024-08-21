# remove old files
remove_old_files() {
    for file in ./.* ./*; do
        if [ $(basename $file) != $(basename $0) ]; then
            rm -rf $file
        fi
    done
}

build_server() {
    # dowload files
    curl -OJ https://meta.fabricmc.net/v2/versions/loader/1.21.1/0.16.2/1.0.1/server/jar
    mkdir -p .fabric/server/
    wget https://piston-data.mojang.com/v1/objects/59353fb40c36d304f2035d51e7d6e6baa98dc05c/server.jar -O .fabric/server/1.21.1-server.jar

    # mkdir mods
    cd mods
    wget https://cdn.modrinth.com/data/P7dR8mSH/versions/bK6OgzFj/fabric-api-0.102.1%2B1.21.1.jar
    wget https://cdn.modrinth.com/data/gvQqBUqZ/versions/5szYtenV/lithium-fabric-mc1.21.1-0.13.0.jar
    wget https://cdn.modrinth.com/data/Ps1zyz6x/versions/yGBzVpiV/ScalableLux-0.1.0%2Brc.1%2Bfabric.43c9882-all.jar
    wget https://cdn.modrinth.com/data/aZj58GfX/versions/8ZQEgc1i/easyauth-mc1.21-3.0.25.jar
    wget https://cdn.modrinth.com/data/LODybUe5/versions/4ndHE533/easywhitelist-mc1.20-rc1-1.0.1.jar
    cd ..

    # first run server
    java -Xmx2G -jar fabric-server-mc.1.21.1-loader.0.16.2-launcher.1.0.1.jar nogui

    # accept eula
    sed -i 's/eula=false/eula=true/g' eula.txt
}

print_help() {
    echo "Usage: $0 [build|run]"
    echo "  build: build the server"
    echo "  run: run the server"
    echo "  help: print this help"
    exit 1
}

server_properties() {
    echo "#Minecraft server properties
#Thu Aug 22 01:26:12 CEST 2024
accepts-transfers=false
allow-flight=false
allow-nether=true
broadcast-console-to-ops=true
broadcast-rcon-to-ops=true
bug-report-link=
difficulty=hard
enable-command-block=false
enable-jmx-monitoring=false
enable-query=false
enable-rcon=false
enable-status=true
enforce-secure-profile=true
enforce-whitelist=false
entity-broadcast-range-percentage=100
force-gamemode=false
function-permission-level=2
gamemode=survival
generate-structures=true
generator-settings={}
hardcore=false
hide-online-players=false
initial-disabled-packs=
initial-enabled-packs=vanilla
level-name=world
level-seed=
level-type=minecraft\:normal
log-ips=true
max-chained-neighbor-updates=1000000
max-players=20
max-tick-time=60000
max-world-size=29999984
motd=A Minecraft Server
network-compression-threshold=256
online-mode=true
op-permission-level=4
player-idle-timeout=0
prevent-proxy-connections=false
pvp=true
query.port=25565
rate-limit=0
rcon.password=
rcon.port=25575
region-file-compression=deflate
require-resource-pack=false
resource-pack=
resource-pack-id=
resource-pack-prompt=
resource-pack-sha1=
server-ip=
server-port=25565
simulation-distance=32
spawn-animals=true
spawn-monsters=true
spawn-npcs=true
spawn-protection=0
sync-chunk-writes=true
text-filtering-config=
use-native-transport=true
view-distance=32
white-list=true
"
}

update_server_properties() {
    echo "$(server_properties)" >| server.properties
}

run_server() {
    java -Xmx2G -jar fabric-server-mc.1.21.1-loader.0.16.2-launcher.1.0.1.jar nogui
}

case $1 in

  build)
    remove_old_files
    build_server
    update_server_properties
    ;;

  run)
    update_server_properties
    run_server
    ;;

  help|-h|--help)
    print_help
    ;;

  *)
    print_help
    ;;
esac
