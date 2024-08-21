# remove old files
if [ ! -z $1 ]; then
    echo $1
    echo $0
    for file in ./.* ./*; do
        echo $file
        if [ $(basename $file) != $(basename $0) ]; then
            rm -rf $file
        fi
    done
fi


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
cd ..

# first run server
java -Xmx2G -jar fabric-server-mc.1.21.1-loader.0.16.2-launcher.1.0.1.jar nogui

# accept eula
sed -i 's/eula=false/eula=true/g' eula.txt

# run server
java -Xmx2G -jar fabric-server-mc.1.21.1-loader.0.16.2-launcher.1.0.1.jar nogui
