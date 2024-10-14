module QueryQueue

# Create an unbounded channel to represent the queue
const queue = Channel{Any}()

# Function to push an item onto the queue
function push!(item)
    put!(queue, item)
end

# Function to pop an item from the queue
function pop!()
    return take!(queue)
end

# Listener function to handle new messages as they arrive
function start_listener(callback::Function)
    @async begin
        while true
            item = take!(queue)  # Waits for a new item
            callback(item)        # Call the callback function with the new item
        end
    end
end

end # module
