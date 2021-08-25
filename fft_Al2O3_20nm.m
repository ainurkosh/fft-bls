%data = load('Downloads\Al 20nm on glass_400ps');
data = load('C:\Users\ainur.koshkinbayeva\Desktop\software\fft_bls\Al 20nm on 9e13 Al2O3_1p9MHz');
t = data(:, 2);     % picoseconds
a = data(:, 5);
%a = a(100:end);

T = (t(2) - t(1)) * 1e-12;    % sampling period in seconds
Fs = 1 / T;
%L = length(a);


ind = find(a == max(a));
%ind2 = 239;         % index corresponding to the cutoff of the time (max) 
ind2 = 70;         % index corresponding to the cutoff of the time (max) 

%c2 = mean(tau);

c1 = 9.5;
%c2 = 0.02: 0.001 : 0.03;
c2 = 0.027;
% efun = zeros(length(ind:ind2), length(c2));
% for i = 1 : length(c2)
%     efun(:,i) = c1*exp(-c2(i)*t(ind:ind2)) + 2;
% end
efun = c1*exp(-c2*t(ind:ind2)) + 2;
aa = a(ind:ind2) - efun;
L = length(aa);

figure
linewidth = 1.5;
plot(t(ind:ind2), a(ind:ind2), 'LineWidth',linewidth)
hold on
plot(t(ind:ind2), aa, 'LineWidth',linewidth)
hold off
%figure
hold on
plot(t(ind:ind2), efun, '--', 'LineWidth',linewidth)
hold off

A = fft(aa);
P2 = abs(A/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

w = Fs*(0:(L/2))/L;
%f = Fs*(0:(L-1))/L;
wB = 2.079e+10;
nglass = 1.5111;
v = wB * 783e-9 / (2*nglass);
display(v)

% figure
% plot(t, a)

figure
plot(w,P1) 
%plot(f,P2) 
%title('Single-Sided Amplitude Spectrum of A(t)')
xlabel('f (Hz)')
ylabel('|A(f)|')