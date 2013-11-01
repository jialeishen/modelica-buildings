within Buildings.Electrical.Transmission.LowVoltageCables;
record PvcAl120 "Aluminum cable 120mm^2"
  extends Buildings.Electrical.Transmission.LowVoltageCables.Cable(
    material=Materials.Material.Al,
    RCha=0.269e-003,
    XCha=0.071e-003);
end PvcAl120;