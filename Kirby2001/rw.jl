

include("ilm.jl")


terminalRule1=TerminalRule(Set(["A0","A1"]),Dict("A0"=>"a","A1"=>"b"))
terminalRule2=TerminalRule(Dict("B0"=>"c","B1"=>"d"))
singletonRule1=TerminalRule("A3")

predicateRule1=PredicateRule([terminalRule1,terminalRule2])

predicateRule2=PredicateRule([terminalRule1,terminalRule2],["sfgdfg",terminalRule1])

checkRule(predicateRule1,["A0","B1"])
