using WAV
using ChirpSignal

fs = 16000.0; # sampling frequency
fl = 500.0;   # lower bound frequency
fh = 8000.0;  # upper bound frequency
T  = 5.0 ;    # total time of chirp signal

wav = chirp(T, fs, fl, fh; method="linear");
wavwrite(wav, "./doc/chirpLinear.wav", Fs=fs, nbits=32)

wav = chirp(T, fs, fl, fh; method="quadratic");
wavwrite(wav, "./doc/chirpQuadratic.wav", Fs=fs, nbits=32)

wav = chirp(T, fs, fl, fh; method="logarithmic");
wavwrite(wav, "./doc/chirpLogarithmic.wav", Fs=fs, nbits=32)

wav = chirp(T, fs, fl, fh; method="exponential");
wavwrite(wav, "./doc/chirpExponential.wav", Fs=fs, nbits=32)

fun(t) = 2000*t
wav = chirp(2.0, 16000.0, fun)
wavwrite(wav, "./doc/0_4000hz_linear.wav", Fs=fs, nbits=32)

wav = chirp(2.0, 16000.0, t -> 2000*t^2)
wavwrite(wav, "./doc/0_8000hz_quadratic.wav", Fs=fs, nbits=32)
