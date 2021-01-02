"""
    ChirpSignal
Chirp Swept-frequency sine generator.
"""
module ChirpSignal

export chirp


"""
    chirp(T, fs, fl, fh; method="linear", phase=0.0) -> Array{Float64,1}

Chirp Swept-frequency sine generator.
# Arguments
- `T`     : signal's length in second
- `fs`    : sampling rate
- `fl`    : lower frequency at the ending time step, fl <= fs
- `fh `   : higher frequency at the ending time step, fh <= fs
- `phase` : phase of the chirp sigal, like cos(wt + phase)
- `method`: available methods are 'linear','quadratic', and 'logarithmic'; the default is 'linear'
"""
function chirp(T, fs, fl, fh; method="linear", phase=0.0)
    method == "linear" && return chirpLinear(T, fs, fl, fh; phase=phase)
    method == "quadratic" && return chirpQuadratic(T, fs, fl, fh; phase=phase)
    method == "logarithmic" && return chirpLogarithmic(T, fs, fl, fh; phase=phase)
end


function chirpLinear(T, fs, fl, fh; phase=0.0)
    Δt = 1.0/fs;
    fl = min(fs/2,max(0,fl));
    fh = min(fs/2,max(0,fh));
    k  = (fh - fl)/T/2;
    t  = 0:Δt:T-Δt;
    y  = @. sin(6.2831853*(k*t + fl)*t + phase);
end


function chirpQuadratic(T, fs, fl, fh; phase=0.0)
    # f(t) = k * t^2 + fl, k = (fh-fl)/T^2
    # F(t) = k/3 * t^3 + fl*t
    Δt = 1.0/fs;
    fl = min(fs/2,max(0,fl));
    fh = min(fs/2,max(0,fh));
    t  = 0:Δt:T-Δt;
    y  = @. sin(6.2831853*( (fh-fl)/(3*T^2) * t^3 + fl * t) + phase)
end


function chirpLogarithmic(T, fs, fl, fh; phase=0.0)
    # f(t) = exp(k * t) + (fl-1), k = 1/T*log(fh-fl+1)
    # F(t) = 1/k * exp(k * t) + (fl-1)*t
    (fl <= fh) || error("fl <= fh not met")
    Δt = 1.0/fs;
    fl = min(fs/2,max(0,fl));
    fh = min(fs/2,max(0,fh));
    t  = 0:Δt:T-Δt;
    k  = 1/T*log(fh-fl+1);
    y  = @. sin(6.2831853*( (1/k) * exp(k*t) + (fl-1)*t ) + phase);
end


"""
    chirp(T, fs, f::Function; phase::Real=0.0) -> Array{Float64,1}

Function customizable chirp swept-frequency sine generator.
# Arguments
- `T`     : signal's length in second
- `fs`    : sampling rate
- `f`     : function that defines how the frequency changes vs time
- `phase` : phase of the chirp sigal, like cos(wt + phase)
"""
function chirp(T, fs, f::Function; phase::Real=0.0)
    Δt = 1.0/fs;
    τ  = 0:Δt:T-Δt;
    ϕ  = zeros(length(τ),1);
    x  = zeros(length(τ),1);
    ϕ[1] = f(0)*Δt;
    x[1] = sin(6.2831853*ϕ[1] + phase);
    for t = 2:length(τ)
        ϕ[t] = ϕ[t-1] + f(τ[t-1])*Δt;
        x[t] = sin(6.2831853*ϕ[t] + phase);
    end
    return x
end

end  # module
