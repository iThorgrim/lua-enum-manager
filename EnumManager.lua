-- EnumManager.lua
local EnumManager = {}

do
    local _class_0

    --- Represents a class for managing enumerations.
    local _base_0 = {
        --- Creates a new enum.
        -- @param name string: The name of the enum.
        -- @param values table: Key-value pairs for the enum.
        -- @param options table: Optional settings (`local`, `static`).
        -- @return table: The created enum.
        create_enum = function(self, name, values, options)
            values = values or {}
            options = options or {}

            local is_local = options["local"] or false
            local is_static = options["static"] or false
            local enum = {}
            local current_value = 0

            -- Ensure all keys are properly processed, even if values are nil
            for key, value in pairs(values) do
              current_value = value or current_value + 1 -- Assign explicitly provided or incremented value
              enum[key] = current_value
            end

            -- Make the enum static, if needed
            if is_static then
                local static_enum = {}
                setmetatable(static_enum, {
                    __index = enum, -- Allow reading values from the original table
                    __newindex = function(t, k, v)
                        error("Cannot modify a static enum") -- Block modification
                    end,
                    __pairs = function()
                        return pairs(enum) -- Allow iteration
                    end,
                })
                enum = static_enum -- Replace with the immutable version
            end

            -- Add to the global scope if not local
            if not is_local then
              for k, v in pairs(enum) do
                  _G[k] = v
              end
            end

            -- Store the enum in the manager's registry
            self.enums[name] = enum
            return enum
        end,

        --- Retrieves an enum by its name.
        get_enum = function(self, name)
            return self.enums[name] or nil
        end,

        --- Searches for a key in an enum by its value.
        get_key_by_value = function(self, enum, value)
            for k, v in pairs(enum) do
                if v == value then
                    return k
                end
            end
            return nil
        end
    }
    _base_0.__index = _base_0

    --- Makes Enum callable to create enums directly.
    _class_0 = setmetatable({
        __init = function(self)
            self.enums = {}
        end,
        __base = _base_0,
        __name = "Enum"
    }, {
        __index = _base_0,
        __call = function(cls, name, values, options)
            local instance = setmetatable({}, _base_0)
            cls.__init(instance)
            return instance:create_enum(name, values, options)
        end
    })

    _base_0.__class = _class_0
    EnumManager.Enum = _class_0
end

return setmetatable(EnumManager, {
    __call = function(_, ...)
        return EnumManager.Enum(...)
    end
})