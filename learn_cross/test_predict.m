clear
I = imread('womanhat.bmp');

h = waitbar(0,'testing¡­¡­');
set(h,'Name','test');

r = 0:0.004:0.4;
y = [];
for i = r
	y = [y; predict2(I, i, rand(1)*0.01, rand(1)*0.1)];
	waitbar(i/0.5);
end
figure(1)
plot(r, y(:, 1), 'b', r, r, 'r')
plot(r, y(:, 3), 'b', r, r, 'r')
xlabel('variance'), ylabel('variance')
legend('estimated variance', 'true variance')

%{
r = 0:0.005:0.1;
y = [];
for i = r
	y = [y; predict2(I, rand(1)*0.1, i, rand(1)*0.5)];
end
figure(2)
plot(r, y(:, 2), 'b', r, r, 'r')

r = 0:0.005:0.5;
y = [];
for i = r
	y = [y; predict2(I, rand(1)*0.1, rand(1)*0.1, i)];
	waitbar(i/0.5);
end
figure(3)
plot(r, y(:, 3), 'b', r, r, 'r')
xlabel('variance'), ylabel('variance')
legend('estimated variance', 'true variance')
%}
close(h);