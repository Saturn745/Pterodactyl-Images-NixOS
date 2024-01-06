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
    MODIFIED_STARTUP=`eval echo $(echo $STARTUP | ${pkgs.gnused}/bin/sed -e 's/{{/$\{/g' -e 's/}}/}/g')`
    echo ":/home/container$ $MODIFIED_STARTUP"
    $MODIFIED_STARTUP
  '';
  contents = [ pkgs.openjdk17-bootstrap pkgs.stdenv.cc.cc.lib ];
}
