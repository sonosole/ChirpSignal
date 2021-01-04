using Test
using ChirpSignal

@test begin
    fs = 16000.0;
    fl = 500.0;
    fh = 8000.0;
    T  = 5.0;

    wav = chirp(T, fs, fl, fh; method="linear");
    println("linear chirp ...");

    wav = chirp(T, fs, fl, fh; method="quadratic");
    println("quadratic chirp ...");

    wav = chirp(T, fs, fl, fh; method="logarithmic");
    println("logarithmic chirp ...");

    wav = chirp(T, fs, fl, fh; method="exponential");
    println("exponential chirp ...");

    fun(x) = 2000*x
    wav = chirp(2.0, 16000.0, fun);
    wav = chirp(1.0, 16000.0, x -> 2000*x^2);
    println("customizable chirp ...");
    true
end
