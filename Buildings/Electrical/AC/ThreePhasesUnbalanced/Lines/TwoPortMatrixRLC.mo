within Buildings.Electrical.AC.ThreePhasesUnbalanced.Lines;
model TwoPortMatrixRLC
  "PI model of a line parameterized with impedance and admittance matrices"
  extends Buildings.Electrical.AC.ThreePhasesUnbalanced.Interfaces.TwoPort;
  parameter Modelica.SIunits.Voltage V_nominal(min=0, start=480)
    "Nominal voltage (V_nominal >= 0)"  annotation(Evaluate=true, Dialog(group="Nominal conditions"));
  parameter Modelica.SIunits.Impedance Z11[2] = {1,1}
    "Element [1,1] of impedance matrix";
  parameter Modelica.SIunits.Impedance Z12[2] = {1,1}
    "Element [1,2] of impedance matrix";
  parameter Modelica.SIunits.Impedance Z13[2] = {1,1}
    "Element [1,3] of impedance matrix";
  parameter Modelica.SIunits.Impedance Z22[2] = {1,1}
    "Element [2,2] of impedance matrix";
  parameter Modelica.SIunits.Impedance Z23[2] = {1,1}
    "Element [2,3] of impedance matrix";
  parameter Modelica.SIunits.Impedance Z33[2] = {1,1}
    "Element [3,3] of impedance matrix";
  final parameter Modelica.SIunits.Impedance[2] Z21 = Z12
    "Element [2,1] of impedance matrix";
  final parameter Modelica.SIunits.Impedance[2] Z31 = Z13
    "Element [3,1] of impedance matrix";
  final parameter Modelica.SIunits.Impedance[2] Z32 = Z23
    "Element [3,1] of impedance matrix";

  parameter Modelica.SIunits.Admittance B11 = 1
    "Element [1,1] of admittance matrix";
  parameter Modelica.SIunits.Admittance B12 = 1
    "Element [1,2] of admittance matrix";
  parameter Modelica.SIunits.Admittance B13 = 1
    "Element [1,3] of admittance matrix";
  parameter Modelica.SIunits.Admittance B22 = 1
    "Element [2,2] of admittance matrix";
  parameter Modelica.SIunits.Admittance B23 = 1
    "Element [2,3] of admittance matrix";
  parameter Modelica.SIunits.Admittance B33 = 1
    "Element [3,3] of admittance matrix";
  final parameter Modelica.SIunits.Admittance B21 = B12
    "Element [2,1] of admittance matrix";
  final parameter Modelica.SIunits.Admittance B31 = B13
    "Element [3,1] of admittance matrix";
  final parameter Modelica.SIunits.Admittance B32 = B23
    "Element [3,2] of admittance matrix";
protected
  function product = Buildings.Electrical.PhaseSystems.OnePhase.product
    "Product between complex quantities";
  Modelica.SIunits.Current Isr[3,2](
    start = zeros(3,Buildings.Electrical.PhaseSystems.OnePhase.n),
    stateSelect = StateSelect.prefer) "Currents that pass through the lines";
  Modelica.SIunits.Current Ish_p[3,2](
    start = zeros(3,Buildings.Electrical.PhaseSystems.OnePhase.n),
    stateSelect = StateSelect.prefer) "Shunt current on side p";
  Modelica.SIunits.Current Ish_n[3,2](
    start = zeros(3,Buildings.Electrical.PhaseSystems.OnePhase.n),
    stateSelect = StateSelect.prefer) "Shunt current on side n";

  Modelica.SIunits.Voltage v1_n[2](
    start = Buildings.Electrical.PhaseSystems.OnePhase.phaseVoltages(V_nominal/sqrt(3)),
    stateSelect = StateSelect.never) = terminal_n.phase[1].v
    "Voltage in line 1 at connector N";
  Modelica.SIunits.Voltage v2_n[2](
    start = Buildings.Electrical.PhaseSystems.OnePhase.phaseVoltages(V_nominal/sqrt(3)),
    stateSelect = StateSelect.never) = terminal_n.phase[2].v
    "Voltage in line 2 at connector N";
  Modelica.SIunits.Voltage v3_n[2](
    start = Buildings.Electrical.PhaseSystems.OnePhase.phaseVoltages(V_nominal/sqrt(3)),
    stateSelect = StateSelect.never) = terminal_n.phase[3].v
    "Voltage in line 3 at connector N";
  Modelica.SIunits.Voltage v1_p[2](
    start = Buildings.Electrical.PhaseSystems.OnePhase.phaseVoltages(V_nominal/sqrt(3)),
    stateSelect = StateSelect.never) = terminal_p.phase[1].v
    "Voltage in line 1 at connector P";
  Modelica.SIunits.Voltage v2_p[2](
    start = Buildings.Electrical.PhaseSystems.OnePhase.phaseVoltages(V_nominal/sqrt(3)),
    stateSelect = StateSelect.never) = terminal_p.phase[2].v
    "Voltage in line 2 at connector P";
  Modelica.SIunits.Voltage v3_p[2](
    start = Buildings.Electrical.PhaseSystems.OnePhase.phaseVoltages(V_nominal/sqrt(3)),
    stateSelect = StateSelect.never) = terminal_p.phase[3].v
    "Voltage in line 3 at connector P";
equation

  // Link the connectors to propagate the overdetermined variable
  for i in 1:3 loop
      Connections.branch(terminal_p.phase[i].theta, terminal_n.phase[i].theta);
      terminal_p.phase[i].theta = terminal_n.phase[i].theta;
  end for;

  // Kirkoff current law for the terminal n (left side)
  Isr[1,:] = terminal_n.phase[1].i - Ish_n[1,:];
  Isr[2,:] = terminal_n.phase[2].i - Ish_n[2,:];
  Isr[3,:] = terminal_n.phase[3].i - Ish_n[3,:];

  // Kirkoff current law for the terminal p (right side)
  Isr[1,:] + terminal_p.phase[1].i = Ish_p[1,:];
  Isr[2,:] + terminal_p.phase[2].i = Ish_p[2,:];
  Isr[3,:] + terminal_p.phase[3].i = Ish_p[3,:];

  // Voltage drop caused by the impedance matrix
  terminal_n.phase[1].v - terminal_p.phase[1].v = product(Z11, terminal_n.phase[1].i)
                                                + product(Z12, terminal_n.phase[2].i)
                                                + product(Z13, terminal_n.phase[3].i);
  terminal_n.phase[2].v - terminal_p.phase[2].v = product(Z21, terminal_n.phase[1].i)
                                                + product(Z22, terminal_n.phase[2].i)
                                                + product(Z23, terminal_n.phase[3].i);
  terminal_n.phase[3].v - terminal_p.phase[3].v = product(Z31, terminal_n.phase[1].i)
                                                + product(Z32, terminal_n.phase[2].i)
                                                + product(Z33, terminal_n.phase[3].i);

  // Current loss at the terminal n
  Ish_n[1,:] = product({0, B11/2}, v1_n)
             + product({0, B12/2}, v2_n)
             + product({0, B13/2}, v3_n);
  Ish_n[2,:] = product({0, B21/2}, v1_n)
             + product({0, B22/2}, v2_n)
             + product({0, B23/2}, v3_n);
  Ish_n[3,:] = product({0, B31/2}, v1_n)
             + product({0, B32/2}, v2_n)
             + product({0, B33/2}, v3_n);

  // Current loss at the terminal n
  Ish_p[1,:] = product({0, B11/2}, v1_p)
             + product({0, B12/2}, v2_p)
             + product({0, B13/2}, v3_p);
  Ish_p[2,:] = product({0, B21/2}, v1_p)
             + product({0, B22/2}, v2_p)
             + product({0, B23/2}, v3_p);
  Ish_p[3,:] = product({0, B31/2}, v1_p)
             + product({0, B32/2}, v2_p)
             + product({0, B33/2}, v3_p);

  annotation (
  defaultComponentName="line",
  Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics), Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
                                               graphics={
          Line(points={{-92,0},{-72,0}}, color={0,0,0}),
          Line(points={{68,0},{88,0}}, color={0,0,0}),
        Rectangle(
          extent={{-72,40},{70,-40}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
          Text(
            extent={{-140,100},{140,60}},
            lineColor={0,0,0},
          textString="%name"),
          Text(
            extent={{-72,30},{70,10}},
            lineColor={0,0,0},
          textString="R+jX 3x3"),
          Text(
            extent={{-72,-10},{70,-30}},
            lineColor={0,0,0},
          textString="C 3x3")}),
    Documentation(revisions="<html>
<ul>
<li>
October 6, 2014, by Marco Bonvini:<br/>
Revised documentation and model.
</li>
<li>
June 5, 2014, by Marco Bonvini:<br/>
Added model.
</li>
</ul>
</html>", info="<html>
<p>
RLC line model (&pi;-model) that connects two AC three phases 
unbalanced interfaces. This model can be used to represent a
cable in a three phases unbalanced AC system.
</p>

<p align=\"center\">
<img alt=\"image\" src=\"modelica://Buildings/Resources/Images/Electrical/AC/ThreePhasesUnbalanced/Lines/twoPortRLCMatrix.png\"/>
</p>

<p>
The model is parameterized with an impedance matrix <i>Z</i>.
The matrix is symmetric thus just the upper triangular
part of it has to be defined, and an admittance matrix <i>B</i>.
</p>

<p>
This model is a more detailed version of the model <a href=\"modelica://Buildings.Electrical.AC.ThreePhasesUnbalanced.Lines.TwoPortMatrixRL\">
Buildings.Electrical.AC.ThreePhasesUnbalanced.Lines.TwoPortMatrixRL</a> that includes
the capacitive effects of the line.
</p>

</html>"));
end TwoPortMatrixRLC;
