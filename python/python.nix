{ config, lib, pkgs, ...}:

let 
  my-python-packages = ps: with ps; [
    python-lsp-server
    cvxopt
  ];
in
{
  environment.systemPackages = [
    (pkgs.python3.withPackages my-python-packages)
  ];
}
