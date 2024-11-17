module AsyncServer

#3rd party and standard imports
using HTTP

#Local imports
include("./query_queue.jl")
import .QueryQueue

# Middleware function
function logging_middleware(handler)
    return (req::HTTP.Request) -> begin
        # Log the incoming request
        println("Received request: $(req.method) $(req.target)")

        # Call the next handler in the chain
        response = handler(req)

        # Optionally modify the response here
        return response
    end
end

# Main request handler
function request_handler(req::HTTP.Request)
     QueryQueue.push!("ok !")
     println("hi ")
     for i in 1:10
        sleep(0.05)
        println("hi ", i)
    end
    if req.method == "GET"
        return HTTP.Response(200, "Helxlo, World!")
    else
        return HTTP.Response(405, "Method Not Allowed")
    end
end

# Wrap the handler with middleware
app = logging_middleware(request_handler)

# Start the server
function start_server(port::Int)
    QueryQueue.start_listener(item -> println("Processing: $item"))
    HTTP.serve(app, "0.0.0.0", port)
end

end # module
