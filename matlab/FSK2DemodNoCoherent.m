function FSK2DemodNoCoherent(m, IsCont)
    if nargin < 1
        m=3.5;
        IsCont=1;
    end
    ps=10^6;
    N=1000;     %数据码元个数
    Fs=32*10^6; %采样频率
    fc=6*10^6;  %载波频率
    Len=N*Fs/ps;

    freqspace=m*ps;%两个频率的间隔
    nsamp=Fs/ps;%每个码元的采样点数
    x=randi([0,1],N,1);%数据
    
    if(IsCont == 1)
        data = fskmod(x,2,freqspace,nsamp,Fs,'cont');
    else
        data = fskmod(x,2,freqspace,nsamp,Fs,'discont');
    end
    t=0:1/Fs:(Len-1)/Fs;
    f0=cos(2*pi*fc.*t) + sin(2*pi*fc.*t)*sqrt(-1);
    fsk=real(data.*f0');
    m0_fsk=fft_value(fsk,2048);
    %带通滤波
    Wnf1=[(fc-m*ps)*2/Fs fc*2/Fs];
    %在设计数字滤波器时，尤其是使用 FIR 滤波器设计函数（如 fir1），滤波器的设计通常基于归一化频率。这些归一化频率是相对于采样频率的比例值，而不是实际的赫兹值。
    Wnf2=[fc*2/Fs (fc+m*ps)*2/Fs];
    b1=fir1(60,Wnf1);
    b2=fir1(60,Wnf2);
    bs1_fsk=filter(b1,1,fsk);
    bs2_fsk=filter(b2,1,fsk);

    m_fsk=20*log10(abs(fft(bs1_fsk,2048)));
    mbs1_fsk=m_fsk-max(m_fsk);
    m_fsk=20*log10(abs(fft(bs2_fsk,2048)));
    mbs2_fsk=m_fsk-max(m_fsk);
    %全波整流
    abs1_fsk=abs(bs1_fsk);
    abs2_fsk=abs(bs2_fsk);
    
    mabs1_fsk=fft_value(abs1_fsk, 2048);
    mabs2_fsk=fft_value(abs2_fsk, 2048);

    %低通滤波
    Lb=fir1(60,ps*2/Fs);
    Lpf1_fsk=filter(Lb,1,abs1_fsk);
    Lpf2_fsk=filter(Lb,1,abs2_fsk);
    
    mLpf1_fsk=fft_value(Lpf1_fsk,2048);
    mLpf2_fsk=fft_value(Lpf2_fsk,2048);

    Demod_fsk=Lpf1_fsk-Lpf2_fsk;
    mDemod_fsk=fft_value(Demod_fsk, 2048);

    %设置幅频响应的横坐标单位为MHz
x_f=1:length(m0_fsk);x_f=x_f*Fs/length(m0_fsk)/10^6;
%绘制连续相位的时域波形及频谱
figure(1);
subplot(621);
plot(x_f,m0_fsk);axis([0 Fs/2/10^6 -80 0]);
legend('中频信号频谱');
xlabel('频率(MHz)');ylabel('幅度(dB)');%grid on;
subplot(622);
plot([0:1/32:500/32],fsk(100:600));
legend('中频时域波形');
xlabel('时间(us)');ylabel('幅度(v)');%grid on;

subplot(623);
plot(x_f,mbs1_fsk);axis([0 Fs/2/10^6 -80 0]);
legend('带通滤波f1后频谱');
xlabel('频率(MHz)');ylabel('幅度(dB)');%grid on;
subplot(624);
plot([0:1/32:500/32],bs1_fsk(100:600));
legend('带通滤波后f1时域波形');
xlabel('时间(us)');ylabel('幅度(v)');%grid on;

subplot(625);
plot(x_f,mabs1_fsk);axis([0 Fs/2/10^6 -80 0]);
legend('整流后f1频谱');
xlabel('频率(MHz)');ylabel('幅度(dB)');%grid on;
subplot(626);
plot([0:1/32:500/32],abs1_fsk(100:600));
legend('整流后f1时域波形');
xlabel('时间(us)');ylabel('幅度(v)');%grid on;

subplot(627);
plot(x_f,mLpf1_fsk);axis([0 Fs/2/10^6 -80 0]);
legend('低通滤波后f1频谱');
xlabel('频率(MHz)');ylabel('幅度(dB)');%grid on;
subplot(628);
plot([0:1/32:500/32],Lpf1_fsk(100:600));
legend('低通滤波后f1时域波形');
xlabel('时间(us)');ylabel('幅度(v)');%grid on;

subplot(629);
plot(x_f,mLpf2_fsk);axis([0 Fs/2/10^6 -80 0]);
legend('低通滤波后f2频谱');
xlabel('频率(MHz)');ylabel('幅度(dB)');%grid on;
subplot(6,2,10);
plot([0:1/32:500/32],Lpf2_fsk(100:600));
legend('低通滤波后f2时域波形');
xlabel('时间(us)');ylabel('幅度(v)');%grid on;

subplot(6,2,11);
plot(x_f,mDemod_fsk);axis([0 Fs/2/10^6 -80 0]);
legend('解调后频谱');
xlabel('频率(MHz)');ylabel('幅度(v)');%grid on;
subplot(6,2,12);
plot([0:1/32:500/32],Demod_fsk(100:600));
legend('解调后时域波形');
xlabel('时间(us)');ylabel('幅度(v)');%grid on;


end