function result=fft_value(data, n)
    temp=20*log10(abs(fft(data, n)));
    result=temp - max(temp);
end