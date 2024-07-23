ps=10^6;    %码元速率
N=5;     %数据码元个数
Fs=32*10^6; %采样频率
fc=6*10^6;  %载波频率
Len=N*Fs/ps;

m=0.5;
freqspace=m*ps;%两个频率的间隔
nsamp=Fs/ps;%每个码元的采样点数
x=randi([0,1],N,1);%数据

ContData=fskmod(x,2,freqspace,nsamp,Fs,'cont');%连续
DisContData=fskmod(x,2,freqspace,nsamp,Fs,'discont');%非连续

t=0:1/Fs:(Len-1)/Fs;
f0=cos(2*pi*fc.*t) + sin(2*pi*fc.*t)*sqrt(-1);%exp(2*pi*fc*t)
Contfsk=real(ContData.*f0');
DisContfsk=real(DisContData.*f0');
plot(t,ContData);
figure;
m_Contfsk=20*log10(abs(fft(Contfsk,2048)));
m_Disfsk=20*log10(abs(fft(DisContfsk,2048)));
m05_Contfsk=m_Contfsk-max(m_Contfsk);
m05_Disfsk=m_Disfsk-max(m_Disfsk);

x_f=1:length(m_Contfsk);x_f=x_f*Fs/length(m_Contfsk)/10^6;
subplot(421);
plot(x_f,m05_Contfsk);axis([0 Fs/2/10^6 -80 0]);
legend('h=0.5 CPFSK');
xlabel('频率(MHz)');ylabel('幅度(dB)');
subplot(422);
plot(x_f,m05_Disfsk);axis([0 Fs/2/10^6 -80 0]);
legend('h=0.5 FSK');
xlabel('频率(MHz)');ylabel('幅度(dB)');%grid on;

m=0.715;
freqspace=m*ps;%两个频率的间隔
nsamp=Fs/ps;%每个码元的采样点数
x=randi([0,1],N,1);%数据

ContData=fskmod(x,2,freqspace,nsamp,Fs,'cont');%连续
DisContData=fskmod(x,2,freqspace,nsamp,Fs,'discont');%非连续

t=0:1/Fs:(Len-1)/Fs;
f0=cos(2*pi*fc.*t) + sin(2*pi*fc.*t)*sqrt(-1);
Contfsk=real(ContData.*f0');
DisContfsk=real(DisContData.*f0');

m_Contfsk=20*log10(abs(fft(Contfsk,2048)));
m_Disfsk=20*log10(abs(fft(DisContfsk,2048)));
m0715_Contfsk=m_Contfsk-max(m_Contfsk);
m0715_Disfsk=m_Disfsk-max(m_Disfsk);

subplot(423);
plot(x_f,m0715_Contfsk);axis([0 Fs/2/10^6 -80 0]);
legend('h=0.715 CPFSK');
xlabel('频率(MHz)');ylabel('幅度(dB)');
subplot(424);
plot(x_f,m0715_Disfsk);axis([0 Fs/2/10^6 -80 0]);
legend('h=0.715 FSK');
xlabel('频率(MHz)');ylabel('幅度(dB)');%grid on;

m=1;
freqspace=m*ps;%两个频率的间隔
nsamp=Fs/ps;%每个码元的采样点数
x=randi([0,1],N,1);%数据

ContData=fskmod(x,2,freqspace,nsamp,Fs,'cont');%连续
DisContData=fskmod(x,2,freqspace,nsamp,Fs,'discont');%非连续

t=0:1/Fs:(Len-1)/Fs;
f0=cos(2*pi*fc.*t) + sin(2*pi*fc.*t)*sqrt(-1);
Contfsk=real(ContData.*f0');
DisContfsk=real(DisContData.*f0');

m_Contfsk=20*log10(abs(fft(Contfsk,2048)));
m_Disfsk=20*log10(abs(fft(DisContfsk,2048)));
m1_Contfsk=m_Contfsk-max(m_Contfsk);
m1_Disfsk=m_Disfsk-max(m_Disfsk);

subplot(425);
plot(x_f,m1_Contfsk);axis([0 Fs/2/10^6 -80 0]);
legend('h=1 CPFSK');
xlabel('频率(MHz)');ylabel('幅度(dB)');
subplot(426);
plot(x_f,m1_Disfsk);axis([0 Fs/2/10^6 -80 0]);
legend('h=1 FSK');
xlabel('频率(MHz)');ylabel('幅度(dB)');%grid on;

m=3.5;
freqspace=m*ps;%两个频率的间隔
nsamp=Fs/ps;%每个码元的采样点数
x=randi([0,1],N,1);%数据

ContData=fskmod(x,2,freqspace,nsamp,Fs,'cont');%连续
DisContData=fskmod(x,2,freqspace,nsamp,Fs,'discont');%非连续

t=0:1/Fs:(Len-1)/Fs;
f0=cos(2*pi*fc.*t) + sin(2*pi*fc.*t)*sqrt(-1);
Contfsk=real(ContData.*f0');
DisContfsk=real(DisContData.*f0');

m_Contfsk=20*log10(abs(fft(Contfsk,2048)));
m_Disfsk=20*log10(abs(fft(DisContfsk,2048)));
m35_Contfsk=m_Contfsk-max(m_Contfsk);
m35_Disfsk=m_Disfsk-max(m_Disfsk);

subplot(427);
plot(x_f,m35_Contfsk);axis([0 Fs/2/10^6 -80 0]);
legend('h=3.5 CPFSK');
xlabel('频率(MHz)');ylabel('幅度(dB)');
subplot(428);
plot(x_f,m35_Disfsk);axis([0 Fs/2/10^6 -80 0]);
legend('h=3.5 FSK');
xlabel('频率(MHz)');ylabel('幅度(dB)');%grid on;
