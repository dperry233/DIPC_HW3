close all;
clear;
clc;

% sub section a
I = imread('house.jpg');
I = imresize(I, [512 512]);
I = rgb2gray(I);
figure
imshow(I);
title('Original Image')
J = I;
vector = zeros(1,512);
for j = 1:16:512
    J(:,j)= J(:,j) + 40;
    vector(j) = 40;
end
figure;
imshow(J)
title('Deteriorated Image');

% subsection b
W = exp((1i*2*pi)/512);
vector = fft(vector);

X = ['DFT components in which the iterference have strictly positive values: ', num2str(find(vector > 0 ) - 1)];
disp(X);
X = ['The value of each positive components is: ', num2str(vector(1))];
disp(X);
X = ['The value of all other components is: ', num2str(vector(2))];
disp(X);

% subsection c
DFT = ones(512,512);
for j = 1:1:512
    for k = 1:1:512
        DFT(j, k) = (1/sqrt(512))*W^((j-1)*(k-1));
    end
end
iDFT = ones(512,512);
for j = 1:1:512
    for k = 1:1:512
        iDFT(j, k) = (1/sqrt(512))*W^(-1*(j-1)*(k-1));
    end
end
restored = double(J);
for j = 1:1:512
    restored(j,:) = transpose(DFT * transpose(restored(j,:)));
end

H = ones(1, 512);
for k = 1:32:512
    H(k) = 0;
end
% the filter isn't applied on the DC component
H(1) = 1;
for j = 1:1:512
    restored(j,:) = restored(j,:) .* H;
    restored(j,:) = transpose(iDFT * transpose(restored(j,:)));
end
figure
imshow(uint8(restored))
title('Restored Image');
X = ['MSE of the deteriorated image: ', num2str(mse_clc(I, J))];
disp(X)
X = ['MSE of the restored image: ', num2str(mse_clc(I, uint8(restored)))];
disp(X)

