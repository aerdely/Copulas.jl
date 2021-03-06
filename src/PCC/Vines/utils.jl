#######################
## sorting utilities ##
#######################

@doc doc"""
Lexicographical sorting of paths given as Array{Array{Int, 1}, 1}.
This is implicitly called by `CTreePaths` contructors.
"""->
function sortPaths(paths::IntArrays)
    pathsArr = _cTreePaths2arr(paths)
    sortedArr = sortcols(pathsArr)
    return paths = _arr2CTreePaths(sortedArr)
end

## write tree paths as matrix
##---------------------------

@doc doc"""
`Array{Int, 2}` rectangular matrix with paths as columns, filled to
maximum depth with zeros. This is not a conversion to parent notation,
but simply exists to make use of built-in lexicographic sorting
functions for arrays.
"""->
function _cTreePaths2arr(paths::IntArrays)
    ## transform array of array into matrix, filling empty fields with
    ## zero
    nRows = maxDepth(paths)
    vals = zeros(Int, nRows, length(paths))
    for ii=1:length(paths)
        nVals = length(paths[ii])
        vals[1:nVals, ii] = paths[ii]
    end
    return vals
end

@doc doc"""
`Array{Array{Int, 1}, 1}` of tree paths, obtained from a rectangular
matrix `Array{Int, 2}` with trailing zeros. Trailing zeros are simply
cut off, in order to get paths of different length.
"""->
function _arr2CTreePaths(arr::Array{Int, 2})
    ## remove trailing zeros
    maxDepth, nPaths = size(arr)
    paths = Array(Array{Int, 1}, nPaths)
    for ii=1:nPaths
        currPath = arr[:, ii]
        noZeros = (currPath .!= 0)
        if !isa(noZeros, Array)
            paths[ii] = [currPath[noZeros]]
        else
            paths[ii] = currPath[noZeros]
        end
    end
    return paths
end

##########################
## conversion functions ##
##########################

## @doc doc"""
## Convert `Array{Int, 1}` of tree information given in parent notation
## into a `Tree` instance. Parent notation specifies for each variable
## its single parent in an acyclic tree.

## The algorithm starts by finding all final nodes as those that are
## listed as parent node for any other variable. For the case of
## incomplete trees, nodes not yet connected are encoded with a value of
## -1. 
## """->
## function par2tree(parNot::Array{Int, 1})
##     ## transform single parent notation column to tree
##     tr = CTreeParRef(parNot)
##     return convert(CTreePaths, tr)
## end

## function par2tree(parNot::Array{Int, 2})
##     ## transform parent notation matrix to array of trees
##     nVars = size(parNot, 2)
##     trees = Array(CTreePaths, nVars)
##     for ii=1:nVars
##         trees[ii] = par2tree(parNot[:, ii])
##     end
##     return trees
## end

## @doc doc"""
## Transform `Tree` to `Array{Int, 1}` parent notation. Root nodes get
## parent value of 0. Not yet connected nodes are encoded as value -1.
## """->
## function tree2par(tP::Tree, nVars::Int)
##     return convert(CTreeParRef, tP, nVars)
## end

## @doc doc"""
## Transform `Array` of `Tree`s into parent notation square matrix.
## """->
## function tree2par(tPs::Array{Tree, 1}, nVars::Int)
##     ## transform array of trees to parent notation matrix
##     parNot = Array(Int, nVars, nVars)
##     for ii=1:nVars
##         tPar = convert(CTreeParRef, tPs[ii], nVars)
##         parNot[:, ii] = tPar.tree
##     end
##     return parNot
## end

## function vine2trees(vn::Vine)
##     return par2tree(vn.trees)
## end

## function trees2vine(trs::Array{Tree, 1}, nVars::Int)
##     return Vine(tree2par(trs, nVars))
## end
