function [ mse ] = mse_clc( image1, image2 )

if ( ~ismatrix(image1) || ~ismatrix(image2) )
    error( 'Can get only vectors or 2D matrices.' )
end

if ( ~isequal(size(image1),size(image2)) )
    error( 'The input matrices have different dimensions.' )
end


diff = double(image1)-double(image2);
sse = sum(sum(diff.^2));
mse = sse / length(diff(:));

end
