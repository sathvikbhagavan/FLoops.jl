module FLoops

# Use README as the docstring of the module:
@doc let path = joinpath(dirname(@__DIR__), "README.md")
    include_dependency(path)
    doc = read(path, String)
    doc = replace(doc, r"^```julia"m => "```jldoctest README")
    doc = replace(
        doc,
        "https://juliafolds.github.io/FLoops.jl/dev/tutorials/sequential/" =>
            "@ref tutorials-sequential",
    )
    doc = replace(
        doc,
        "https://juliafolds.github.io/FLoops.jl/dev/tutorials/parallel/#tutorials-executor" =>
            "@ref tutorials-executor",
    )
    doc = replace(
        doc,
        "https://juliafolds.github.io/FLoops.jl/dev/tutorials/parallel/" =>
            "@ref tutorials-parallel",
    )
    doc
end FLoops

export @floop, @init, @reduce, DistributedEx, SequentialEx, ThreadedEx

using Base.Meta: isexpr
using FLoopsBase: EXTRA_STATE_VARIABLES
using JuliaVariables: JuliaVariables, Var, simplify_ex
using MLStyle: @match
using Setfield: @set
using Transducers:
    @return_if_reduced,
    Cat,
    DistributedEx,
    Executor,
    IdentityTransducer,
    Map,
    MapCat,
    NotA,
    OnInit,
    PreferParallel,
    ReduceIf,
    Reduction,
    SequentialEx,
    ThreadedEx,
    Transducers,
    complete,
    extract_transducer,
    foldl_nocomplete,
    foldxd,
    foldxl,
    foldxt,
    maybe_set_simd,
    next,
    reduced,
    right,
    transduce,
    unreduced,
    whencombine

if isdefined(JuliaVariables, :solve!)
    using JuliaVariables: solve!
else
    const solve! = JuliaVariables.solve
end

if !@isdefined isnothing
    using Compat: isnothing
end

include("utils.jl")
include("macro.jl")
include("reduce.jl")
include("checkboxes.jl")

end # module
