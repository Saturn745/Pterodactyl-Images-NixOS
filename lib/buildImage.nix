{ pkgs ? import <nixpkgs> { system = "x86_64-linux"; }
, name
, entryPoint
, contents
}:

let
  dockerEntrypoint = pkgs.writeScriptBin "entrypoint.sh" ''
    #!${pkgs.runtimeShell}
    ${entryPoint}
  '';
in
pkgs.dockerTools.buildLayeredImage {
  name = name;
  tag = "latest";
  created = "now";
  contents = contents;
  maxLayers = 125;
  fakeRootCommands = ''
    mkdir -p \
      /etc \
      /tmp \
      /src \
      /usr/bin
    ${pkgs.dockerTools.shadowSetup}
    useradd --home /home/container -m container
    # Echo the id of the user to the console
    echo "Container User: $(id -u container)"
  '';
  config = {
    Cmd = [ "${pkgs.bash}/bin/bash" dockerEntrypoint ];
    WorkingDir = "/home/container";
  };
}

