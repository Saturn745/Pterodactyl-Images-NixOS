{ pkgs ? import <nixpkgs> { system = "x86_64-linux"; }
}:
let buildImage = import ../../lib/buildImage.nix;
in
buildImage {
  tag = "go-1.22";
  entryPoint = ''
    cd /home/container
    go version
    echo "Starting up..."
    MODIFIED_STARTUP=`eval echo $(echo $STARTUP | ${pkgs.gnused}/bin/sed -e 's/{{/$\{/g' -e 's/}}/}/g')`
    echo ":/home/container$ $MODIFIED_STARTUP"
    $MODIFIED_STARTUP
  '';
  contents = [ pkgs.go_1_22 ];
}

