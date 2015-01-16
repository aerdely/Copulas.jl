################################
## General cdf implementation ##
################################

function cdf(cop::PairCop, u::Float64, v::Float64)
    error("cdf function is not yet implemented for this type of copula")
end

function cdf(cop::ModPC, u::Float64, v::Float64)
    ## resolve transformation
    uHat, vHat = resolve_args(cop.mod, u, v)

    pVal = cdf(cop.cop, uHat, vHat)
    pValHat = resolve_pval(cop.mod, pVal, u, v)

    return pValHat
end

function cdf(cop::PairCop,
             u::FloatVec, v::FloatVec)
    error("cdf function is not yet implemented for this type of copula")
end

function cdf(cop::ModPC,
             u::FloatVec, v::FloatVec)
    ## resolve transformation
    uHat, vHat = resolve_args(cop.mod, u, v)

    pVal = cdf(cop.cop, uHat, vHat)
    pValHat = resolve_pval(cop.mod, pVal, u, v)

    return pValHat
end
