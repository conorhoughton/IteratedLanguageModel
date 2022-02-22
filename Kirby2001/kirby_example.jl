
include("ilm.jl")

a = TerminalRule(Dict("A0"=>"wcpal","A1"=>"a","A2"=>"hnqmx","A3"=>"gpmhm","A4"=>"b"))
b = TerminalRule(Dict("B0"=>"sdqu","B1"=>"p","B2"=>"ihm"))

s1 = PredicateRule([a,b],[a,b])
s2 = PredicateRule([a,TerminalRule("B3")],["rkhxp",a,"mx"])
s3 = PredicateRule([a,TerminalRule("B4")],["cs",a,"bf"])

rules=[s1,s2,s3]

println(runRule(rules,["A0","B0"]))
println(runRule(rules,["A0","B3"]))
println(runRule(rules,["A1","B4"]))

meaningA=["A0","A1","A2","A3","A4"]
meaningB=["B0","B1","B2","B3","B4"]

makeTable(rules,meaningA,meaningB,"test.tex")
