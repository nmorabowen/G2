function el = element13(a,elno)
% ELEMENT13 2D Beam-column inelastic element for WF Section--flexibility approach
%
% Element Description
% -------------------------------------------
% Class:           element13
% Type:            Beam-column 
% Dimension:       2 (x-y plane)
% Number of Nodes: 2
% DOF per Node:    3
% Material:        Fiber section with bilinear
%			material using wfsection
% Kinematics:      Small displacements
% State Determ.:   Incremental
%
% Usage
% -------------------------------------------
% el=ELEMENT13(a,elno)
%
% Required:
% elno  = Element number
% a(1)  = Section height, h
% a(2)  = Flange width, bf
% a(3)  = Flange thickness, tf
% a(4)  = Web width, tw
% a(5)  = No. fibers per flange, nf
% a(6)  = No. fibers for web
% a(7)  = Modulus of elasticity, E
% a(8)  = Yield stress, sigma-y
% a(9)  = Strain hardening ratio, alpha
% a(10) = Number of sections in element
%		(number of integration points)
%		Default number is 4
%
% Object Fields
% ----------------------------------------
% Data:
% el.nsecs = Number of sections (integration points)
% el.secs  = Array of sections
% el.xip   = Integration points (natural coords.)
% el.weight= Integration weights
% 		Note: integration type is set by
%		function call in this m-file
% el.si    = basic forces (s1,s2,s3) at last commit
% el.ky    = Yield curvature (used for output)

% G2 - Matrix Structural Analysis with Matlab
% Version 0.1
% University of California, Berkeley
% Copyright 1999, Gregory L. Fenves
% fenves@ce.berkeley.edu
% ----------------------------------------

% Create WF section for each integration point

if length(a) > 9
	num = a(10);
else
	num = 4;
end

for i=1:num
	sections(i) = wfsection( a(1:4), a(5:6), a(7:9) );
end

% Get integration parameters for an integration rule
%[ el.xip, el.weight ] = Gauss ( num );
[ el.xip, el.weight ] = Lobatto ( num );

% Create element object

el.no    = elno;
el.nsecs = num;
el.secs  = sections;
el.si    = zeros(3,1);

% Output quantities
el.ky  =  a(8)/a(7)/( a(1)/ 2 ); % yield curvature

el = class(el,'element13');

