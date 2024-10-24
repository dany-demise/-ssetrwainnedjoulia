# 3rd party modudle
using Pkg


include("async_server.jl")
using .AsyncServer

AsyncServer.start_server(8420)