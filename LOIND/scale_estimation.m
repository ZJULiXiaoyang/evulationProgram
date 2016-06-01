function [ radius]= scale_estimation( patch_pcloud,interestpoint,flag )
focal=570.3;
[ center, radii, evecs, v ] = ellipsoid_fit( patch_pcloud,3);
radius=radii(1)*focal/interestpoint(3);
if flag
    fprintf( 'Ellipsoid center: %.3g %.3g %.3g\n', center );
    fprintf( 'Ellipsoid radii : %.3g %.3g %.3g\n', radii );
    fprintf( 'Ellipsoid evecs :\n' );
    fprintf( '%.3g %.3g %.3g\n%.3g %.3g %.3g\n%.3g %.3g %.3g\n', ...
        evecs(1), evecs(2), evecs(3), evecs(4), evecs(5), evecs(6), evecs(7), evecs(8), evecs(9) );
    fprintf( 'Algebraic form  :\n' );
    fprintf( '%.3g ', v );
    fprintf( '\n' );
    
    % draw dat
    plot3( patch_pcloud(:,1), patch_pcloud(:,2), patch_pcloud(:,3), '.r' );
    hold on;
    
    %draw fit
    maxd = max(max( abs(radii(1)),abs(radii(2))),abs(radii(3)) );
    step = maxd / 50;
    [ x, y, z ] = meshgrid( -maxd+ center(1):step:maxd+ center(1), -maxd+ center(2):step:maxd+center(2), -maxd+ center(3):step:maxd+center(3)  );
    
    Ellipsoid = v(1) *x.*x +   v(2) * y.*y + v(3) * z.*z + ...
        2*v(4) *x.*y + 2*v(5)*x.*z + 2*v(6) * y.*z + ...
        2*v(7) *x    + 2*v(8)*y    + 2*v(9) * z;
    p = patch( isosurface( x, y, z, Ellipsoid, 1 ) );
    set( p, 'FaceColor', 'g', 'EdgeColor', 'none' );
    grid on;
    axis vis3d;
    camlight;
    lighting phong;
end
end

