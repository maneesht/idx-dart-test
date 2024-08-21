{pkgs, sample ? "none", template ? "app", blank ? false, platforms ? "web,android", ...}: {
    packages = [
        pkgs.curl
        pkgs.gnutar
        pkgs.xz
        pkgs.git
        pkgs.busybox
        pkgs.flutter
    ];
    bootstrap = ''
        export HOME=/home/user
        PATH="$PATH":"$HOME/.pub-cache/bin"
        flutter create "$out" --template="${template}" --platforms="${platforms}" ${if sample == "none" then "" else "--sample=${sample}"} ${if blank then "-e" else ""}
        mkdir "$out"/.idx
        cp ${./dev.nix} "$out"/.idx/dev.nix
        install --mode u+rw ${./dev.nix} "$out"/.idx/dev.nix
    '';
}