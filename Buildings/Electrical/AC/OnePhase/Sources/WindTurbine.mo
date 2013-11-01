within Buildings.Electrical.AC.OnePhase.Sources;
model WindTurbine
  import Buildings;
  extends Buildings.Electrical.Interfaces.PartialWindTurbine(redeclare package
      PhaseSystem = Buildings.Electrical.PhaseSystems.OnePhase, redeclare
      Interfaces.Terminal_p terminal);
  parameter Real pf(min=0, max=1) = 0.9 "Power factor"
    annotation (Dialog(group="AC-Conversion"));
  parameter Real eta_DCAC(min=0, max=1) = 0.9 "Efficiency of DC/AC conversion"
    annotation (Dialog(group="AC-Conversion"));
  replaceable Buildings.Electrical.AC.OnePhase.Loads.CapacitiveLoadP load(mode=Buildings.Electrical.Types.Assumption.VariableZ_P_input,
      pf=pf) annotation (Placement(transformation(extent={{12,-10},{32,10}})));
  Modelica.Blocks.Math.Gain gain_DCAC(k=eta_DCAC) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={52,0})));
equation
  connect(load.terminal, terminal) annotation (Line(
      points={{12,0},{-100,0}},
      color={0,120,120},
      smooth=Smooth.None));
  connect(gain_DCAC.y, load.Pow) annotation (Line(
      points={{41,0},{32,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(gain.y, gain_DCAC.u) annotation (Line(
      points={{13,20},{80,20},{80,0},{64,0}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics), Documentation(info="<html>
<p>
Model of a wind turbine whose power is computed as a function of wind-speed as defined in a table.
</p>
<p>
Input to the model is the local wind speed.
The model requires the specification of a table that maps wind speed in meters per second to generated
power <i>P<sub>t</sub></i> in Watts.
The model has a parameter called <code>scale</code> with a default value of one
that can be used to scale the power generated by the wind turbine.
The generated active electrical power is 
<p align=\"center\" style=\"font-style:italic;\">
P = P<sub>t</sub> scale &eta;<sub>DCAC</sub>
</p>
<p>
where <i>&eta;<sub>DCAC</sub></i> is the efficiency of the conversion of the DC electrical power to AC. 
For example, the following specification (with default <code>scale=1</code>) of a wind turbine
</p>
<pre>
  WindTurbine_Table tur(
    table=[3.5, 0;
           5.5,   100;    
           12, 900;
           14, 1000;
           25, 1000]) \"Wind turbine\";
</pre>
<p>
yields the performance shown below. In this example, the cut-in wind speed is <i>3.5</i> meters per second,
and the cut-out wind speed is <i>25</i> meters per second,
as entered by the first and last entry of the wind speed column.
Below and above these wind speeds, the generated power is zero.
</p>
<p align=\"center\">
<img src=\"modelica://Buildings/Resources/Images/Electrical/DC/Sources/WindTurbine_Table.png\"/>
</p>
</html>"));
end WindTurbine;