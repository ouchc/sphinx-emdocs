.. _SerialEM_LD-mP-nP:

SerialEM Note: Setup LD with Mix of mP and nP Modes
===================================================

:Author: Chen Xu
:Contact: <chen.xu@umassmed.edu>
:Date-created: 2018-03-31
:Last-updated: 2018-07-15

.. glossary::

   Abstract
      There are cases and situations that people want to use nanoprobe(*nP*) mode , but *nP* is not comfortable for lower mag range 
      such as first a few magnifications just above LM, because the beam doesn't spread wide enough to cover entire camera area. 
      This forces us to use *mP* for View and nP for rest of LD areas, namely F, T and R etc.. 
      
      However, most people find it hard to setup LD conditions with the mix of *nP* and *mP* modes. I had frustrated time doing so too. 
      This is, I think, mainly because *nP* and *mP* don't share the same origins for beam shift and defocus - they have their one origins. 
      In SerialEM, all the LD conditions are linked together. Therefore, the seprate origins of focus and beam shift for *mP* and *nP* 
      modes give extra hard time setting up LD in this mix use of *nP* and *mP*. 
      
      SerialEM already has a way to deal with this problem. I hope this doc makes it clearer to easier to follow practically. 
      
.. _procedure_setting_up_LD:

Procedure Setting Up LD with *mP* and *nP*  
--------------------------------------

In my case, I use *mP* for View area with -300 microns focus offset. All other areas - F, T and R are with *nP*. I usually use the same 
spot size for everything. 

0. Before LD is turned on, make sure beam is centered for both *mP* and *nP* beam. I usually use Direct Alignments to do this with 
   *mP* and *nP* beam. That is, turn *mP* on, Directly Alignments - Beam Shift (multi-function to center) - done. Repeat with *nP* mode. 
1. Turn on SerialEM LD.
#. Lower Down large screen or insert screen.
#. From Task - Specialized Options, make sure the "Adjust Focus on Probe Mode Change" is NOT checked. 
#. Set View Defocus Offset to 0 using dial Up-Down button on SerialEM LD Control Panel.
#. Select R area (radio button) on LD control panel. 
#. On microscope right panel, press "Eucentric Focus".
#. Reset Defocus (L2 button on our current setup for soft buttons, yours could different), this makes defocus display 0. 
#. Select V area (radio button) on LD control panel.
#. wait 6-7 seconds to allow scope to switch to this mag and *mP* mode.
#. On microscope right panel, press "Eucentric Focus".
#. Reset Defocus (L2 button on our current setup for soft buttons, yours could different), this makes defocus display 0. 
#. Set View Defocus Offset to target value (-300 in my case) using dial Up-Down button on SerialEM LD Control Panel.
#. From Task - Specialized Options, make sure the "Adjust Focus on Probe Mode Change" is **NOW** checked. 

That's it. 
