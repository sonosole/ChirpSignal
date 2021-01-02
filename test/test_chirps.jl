using WAV
using ChirpSignal

fs = 16000.0;
fl = 500.0
fh = 8000.0
T  = 5.0

wav = chirpLinear(T, fs, fl, fh);
wavwrite(wav, "./doc/chirpLinear.wav", Fs=fs, nbits=32)

wav = chirpQuadratic(T, fs, fl, fh);
wavwrite(wav, "./doc/chirpQuadratic.wav", Fs=fs, nbits=32)

wav = chirpLogarithmic(T, fs, fl, fh);
wavwrite(wav, "./doc/chirpLogarithmic.wav", Fs=fs, nbits=32)

fun(t) = 2000*t
wav = chirp(2.0, 16000.0, fun)
wavwrite(wav, "./doc/0_4000hz_linear.wav", Fs=fs, nbits=32)

wav = chirp(2.0, 16000.0, t -> 2000*t^2 )
wavwrite(wav, "./doc/0_8000hz_quadratic.wav", Fs=fs, nbits=32)
