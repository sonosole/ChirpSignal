# ChirpSignal
 Chirp Swept-frequency sine generator.

## Installation
Enter the REPL mode and add the module
```julia
]add https://github.com/sonosole/ChirpSignal.git
```
or
```julia
]add ChirpSignal
```

## Example
### Step [1]
```julia
using WAV
using ChirpSignal

fs = 16000.0; # sampling frequency
fl = 500.0;   # lower bound frequency
fh = 8000.0;  # upper bound frequency
T  = 5.0 ;    # total time of chirp signal
```

### Step [2]
```julia
wav = chirp(T, fs, fl, fh; method="linear");
wavwrite(wav, "./doc/chirpLinear.wav", Fs=fs, nbits=32)
```
![chirpLinear_500_8000hz](/doc/chirpLinear_500_8000hz.png)

### Step[3]
```julia
wav = chirp(T, fs, fl, fh; method="quadratic");
wavwrite(wav, "./doc/chirpQuadratic.wav", Fs=fs, nbits=32)
```
![chirpQuadratic_500_8000hz](/doc/chirpQuadratic_500_8000hz.png)

### Step [4]
```julia

wav = chirp(T, fs, fl, fh; method="logarithmic");
wavwrite(wav, "./doc/chirpLogarithmic.wav", Fs=fs, nbits=32)
```
![chirpLogarithmic_500_8000hz](/doc/chirpLogarithmic_500_8000hz.png)

### Step [5]
customizable chirp by specify `fun(t) = 2000*t`
```julia
fun(t) = 2000*t
wav = chirp(2.0, 16000.0, fun)
wavwrite(wav, "./doc/0_4000hz_linear.wav", Fs=fs, nbits=32)
```
![0_4000hz_linear](/doc/0_4000hz_linear.png)

### Step [6]
customizable chirp by specify `t -> 2000*t^2`
```julia
wav = chirp(2.0, 16000.0, t -> 2000*t^2 )
wavwrite(wav, "./doc/0_8000hz_quadratic.wav", Fs=fs, nbits=32)
```
![0_8000hz_quadratic](/doc/0_8000hz_quadratic.png)
