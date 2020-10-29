function [output]=demosaic(input)

% Bilinear Interpolation of the missing pixels
% Bayer CFA
%       R G R G
%       G B G B
%       R G R G
%       G B G B
%
