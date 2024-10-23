# 3rd party modudle
using Pkg
Pkg.add("HTTP")

include("async_server.jl")
using .AsyncServer

AsyncServer.start_server(8420)