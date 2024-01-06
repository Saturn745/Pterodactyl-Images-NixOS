{ pkgs ? import <nixpkgs> { system = "x86_64-linux"; }
}:
let buildImage = import ../../lib/buildImage.nix;
in
buildImage {
  name = "codeberg.org/saturn745/pterodactyl-java-17-nix";
  entryPoint = ''
    cd /home/container
    java -version
    echo "Starting up..."
    MODIFIED_STARTUP=`eval echo $(echo $\{STARTUP} | sed -e 's/{{/$\{/g' -e 's/}}/}/g')`
    echo ":/home/container$ $\{MODIFIED_STARTUP}"
    $\{MODIFIED_STARTUP}
  '';
  contents = [ pkgs.jre17_minimal ];
}
