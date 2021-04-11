# ChirpSignal
 Chirp Swept-frequency sine generator.

## Installation
Enter the REPL mode and add the module from the latest repository by :
```julia
]add https://github.com/sonosole/ChirpSignal.git
```
or from Julia's official registries by :
```julia
]add ChirpSignal
```

## Two Public APIs
```julia
chirp(T, fs, fl, fh; method="linear", phase=0.0) -> Array{Float64,1}
chirp(T, fs, f::Function; phase=0.0) -> Array{Float64,1}
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
# f(t) = (fh-fl)/T * t + fl
wav = chirp(T, fs, fl, fh; method="linear");
wavwrite(wav, "./doc/chirpLinear.wav", Fs=fs, nbits=32)
```
![chirpLinear_500_8000Hz](/doc/chirpLinear.png)

### Quadratic chirp example
```julia
# f(t) = k * t^2 + fl, k = (fh-fl)/T^2
wav = chirp(T, fs, fl, fh; method="quadratic");
wavwrite(wav, "./doc/chirpQuadratic.wav", Fs=fs, nbits=32)
```
![chirpQuadratic_500_8000Hz](/doc/chirpQuadratic.png)

### Logarithmic chirp example
```julia
# f(t) = k*log(t+1) + fl, k = (fh-fl)/log(T+1)
wav = chirp(T, fs, fl, fh; method="logarithmic");
wavwrite(wav, "./doc/chirpLogarithmic.wav", Fs=fs, nbits=32)
```
![chirpLogarithmic_500_8000Hz](/doc/chirpLogarithmic.png)

### Exponential chirp example
```julia
# f(t) = exp(k * t) + (fl-1), k = 1/T*log(fh-fl+1)
wav = chirp(T, fs, fl, fh; method="exponential");
wavwrite(wav, "./doc/chirpExponential.wav", Fs=fs, nbits=32)
```
![chirpExponential_500_8000Hz](/doc/chirpExponential.png)

### Customizable chirp example by user's own function
Customizable chirp by specifying `fun(t) = 2000*t`
```julia
fun(t) = 2000*t
wav = chirp(2.0, 16000.0, fun)
wavwrite(wav, "./doc/0_4000hz_linear.wav", Fs=fs, nbits=32)
```
![0_4000Hz_linear](/doc/0_4000Hz_linear_fn.png)

### Customizable chirp example by user's anonymous function
Customizable chirp by specifying a anonymous function `t -> 2000*t^2`
```julia
wav = chirp(2.0, 16000.0, t -> 2000*t^2 )
wavwrite(wav, "./doc/0_8000Hz_quadratic.wav", Fs=fs, nbits=32)
```
![0_8000hz_quadratic](/doc/0_8000Hz_quadratic_fn.png)

### PS
For `method="linear"` and `method="quadratic"` cases, the lower bound frequency `fl` could be set lager than the upper bound frequency `fh`, but not for the `method="logarithmic"` and `method="exponential"`.
