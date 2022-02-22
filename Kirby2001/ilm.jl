
mutable struct TerminalRule
    domain::Set{String}
    rule::Dict{String,String}

end

TerminalRule(rule::Dict{String,String})=TerminalRule(Set(keys(rule)),rule)

TerminalRule(c::String)=TerminalRule(Set([c]),Dict{String,String}())

RuleOrString=Union{TerminalRule,String}

mutable struct PredicateRule
    domain::Vector{TerminalRule}
    utterances::Vector{RuleOrString}
end

PredicateRule(domain::Vector{TerminalRule})=PredicateRule(domain,Vector{RuleOrString}())

function checkRule(rule::PredicateRule,meanings::Vector{String})
    pairs=zip([x.domain for x in rule.domain],meanings)

    for (x,y) in pairs  
        if !(y in x)
            return false
        end
    end
    return true
end

function runRule(rule::PredicateRule,meanings::Vector{String})
    utterance=""::String
    for thisUtterance in rule.utterances
        if isa(thisUtterance,String)
            utterance*=thisUtterance
        else
            for meaning in meanings
                if meaning in thisUtterance.domain
                    utterance*=thisUtterance.rule[meaning]
                end
            end
        end
    end
    utterance
end

function runRule(rules::Vector{PredicateRule},meanings::Vector{String})
    for r in rules
        if checkRule(r,meanings)
            return runRule(r,meanings)
        end
    end
    return "no rule"
end

function makeTable(rules,meaningA,meaningB,filename)
    open(filename,"w") do io
        println(io,"\\documentclass{article}")
        println(io,"\\begin{document}")
        aN=length(meaningA)
        bN=length(meaningB)
        println(io,"\\begin{center}")
        println(io,"\\begin{tabular}{c|"*"c"^aN*"}")
        for a in meaningA
            print(io,"&"*a)
        end
        println(io,"\\\\")
        println(io,"\\hline")
        for b in meaningB
            print(io,b)
            for a in meaningA
                print(io,"&"*runRule(rules,[a,b]))
            end
            println(io,"\\\\")
        end
        println(io,"\\end{tabular}")
        println(io,"\\end{center}")
        println(io,"\\end{document}")
    end
end


    



