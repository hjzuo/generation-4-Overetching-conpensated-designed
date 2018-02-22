function out=phi2radius(phi)
    load('phase delay @ pitch=2um height=2um from Lei .mat');
    pdh=phase_delay;
    radius=radius/10;
    radius_interpolation=linspace(min(radius),max(radius),1000);
    pdh=pdh-pdh(1);
    phi_interpolation=interp1(radius,pdh,radius_interpolation,'spline');
    k = find(abs(phi_interpolation-phi) < 0.01);
    out=radius_interpolation(k(1))/2;   %diameter to radius
end


% plot(radius,pdh,'o',r adius_interpolation,phi_interpolation,':.');