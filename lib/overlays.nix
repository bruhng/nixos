{ inputs, system }:

with inputs;
[
  (import ../overlays/bazecor)
  inputs.nixvim.overlays.default
]
