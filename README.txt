GUI of a simulink model. 

From this GUI be able to directly:
 - start/stop a simulation
 - change variables values used anyware (simulink blocks or plain script of Matlab) through slide
 - plot any scope of that simulink,. i.e. any:
	- scope
	- input
	- bus
 - plot multiple scopes from multiple simulations with their respectives variable values in legend
 - custome plot start-end and time-span
 - custome simulation start-end
 - custome linestyle
 
 ***********************************************************
 Example
 See SimulinkGIU_01_simulinkModel_08_resault_01_01.
 Varaibles:
  - C			capacitance of condensator
  - ..._freq	AC current frequency
  - ..._peak	AC current module
 
***********************************************************
Problem to solve:
Quicly to simulate Simulinks with multiple variables to optimize.