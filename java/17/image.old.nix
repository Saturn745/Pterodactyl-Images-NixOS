{ pkgs ? import <nixpkgs> { system = "x86_64-linux"; }
}:
let
  dockerEntrypoint = pkgs.writeScriptBin "entrypoint.sh" ''
    #!${pkgs.runtimeShell}
    cd /home/container
    java -version
    MODIFIED_STARTUP=`eval echo $(echo $\{STARTUP} | sed -e 's/{{/$\{/g' -e 's/}}/}/g')`
    echo ":/home/container$ $\{MODIFIED_STARTUP}"
    $\{MODIFIED_STARTUP}
  '';
in
pkgs.dockerTools.buildLayeredImage {
  name = "java-17";
  tag = "latest";
  contents = [ pkgs.jre17_minimal ];
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
    Cmd = [ dockerEntrypoint ];
    WorkingDir = "/home/container";
  };
}
