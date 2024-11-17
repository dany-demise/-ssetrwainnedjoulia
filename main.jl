# 3rd party modudle
using Pkg


# 3rd party libraries
Pkg.add("HTTP")


include("async_server.jl")
using .AsyncServer

AsyncServer.start_server(8420)