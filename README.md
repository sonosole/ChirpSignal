# ChirpSignal
 Chirp Swept-frequency sine generator.

## Installation
Enter the REPL mode and add the module from the latest repository by :
```julia
]add https://github.com/sonosole/ChirpSignal.git
```
or from Julia's registries by :
```julia
]add ChirpSignal
```

## Two Public APIs
```julia
chirp(T, fs, fl, fh; method="linear", phase=0.0) -> Array{Float64,1}
chirp(T, fs, f::Function; phase::Real=0.0) -> Array{Float64,1}
```

The first API is enough for most usages. Detials could be found via Julia's helping mode.
```julia
help?> chirp
```

## Example
### Examples' public code
```julia
using WAV
using ChirpSignal

fs = 16000.0; # sampling frequency
fl = 500.0;   # lower bound frequency
fh = 8000.0;  # upper bound frequency
T  = 5.0 ;    # total time of chirp signal
```

### Linear chirp example
```julia
wav = chirp(T, fs, fl, fh; method="linear");
wavwrite(wav, "./doc/chirpLinear.wav", Fs=fs, nbits=32)
```
![chirpLinear_500_8000hz](/doc/chirpLinear_500_8000hz.png)

### Quadratic chirp example
```julia
wav = chirp(T, fs, fl, fh; method="quadratic");
wavwrite(wav, "./doc/chirpQuadratic.wav", Fs=fs, nbits=32)
```
![chirpQuadratic_500_8000hz](/doc/chirpQuadratic_500_8000hz.png)

### Logarithmic chirp example
```julia
wav = chirp(T, fs, fl, fh; method="logarithmic");
wavwrite(wav, "./doc/chirpLogarithmic.wav", Fs=fs, nbits=32)
```
![chirpLogarithmic_500_8000hz](/doc/chirpLogarithmic_500_8000hz.png)

### Customizable chirp example by user's own function
Customizable chirp by specifying `fun(t) = 2000*t`
```julia
fun(t) = 2000*t
wav = chirp(2.0, 16000.0, fun)
wavwrite(wav, "./doc/0_4000hz_linear.wav", Fs=fs, nbits=32)
```
![0_4000hz_linear](/doc/0_4000hz_linear.png)

### Customizable chirp example by user's anonymous function
Customizable chirp by specifying a anonymous function `t -> 2000*t^2`
```julia
wav = chirp(2.0, 16000.0, t -> 2000*t^2 )
wavwrite(wav, "./doc/0_8000hz_quadratic.wav", Fs=fs, nbits=32)
```
![0_8000hz_quadratic](/doc/0_8000hz_quadratic.png)
