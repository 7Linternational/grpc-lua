--- Wraps C module `Replier`.
-- @classmod grpc_lua.impl.Replier

local Replier = {}

local c = require("grpc_lua.c")  -- from grpc_lua.so
local pb = require("luapbintf")

-------------------------------------------------------------------------------
--- Public functions.
-- @section public

--- New Replier.
-- @c_replier C Replier object
-- @treturn table Replier object
function Replier:new(c_replier, response_type)
    assert("userdata" == type(c_replier))
    assert("string" == type(response_type))

    local replier = {
        -- private:
        _c_replier = c_replier,
        _response_type = response_type,
    }
    setmetatable(replier, self)
    self.__index = self
    return replier
end  -- new()

--- Reply response.
-- @tab response response
function Replier:reply(response)
    assert("table" == type(response))
    local resp_str = pb.encode(self._response_type, response))
    self._c_replier:reply(resp_str)
end  -- reply()

return Replier