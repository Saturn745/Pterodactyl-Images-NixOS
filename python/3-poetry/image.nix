{ pkgs ? import <nixpkgs> { system = "x86_64-linux"; }
}:
let buildImage = import ../../lib/buildImage.nix;
in
buildImage {
  tag = "python3-poetry";
  entryPoint = ''
    cd /home/container
    python3 --version
    echo "Starting up..."
    MODIFIED_STARTUP=`eval echo $(echo $STARTUP | ${pkgs.gnused}/bin/sed -e 's/{{/$\{/g' -e 's/}}/}/g')`
    echo ":/home/container$ $MODIFIED_STARTUP"
    $MODIFIED_STARTUP
  '';
  contents = [ pkgs.python3 pkgs.poetry ];
}

