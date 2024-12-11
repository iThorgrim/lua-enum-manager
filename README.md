# :package: EnumManager
A Lua-based utility library for creating and managing enumerations (`enums`). This library simplifies handling enums in Lua by providing flexible features like static enums and global scoping.

## :sparkles: Features
- :rocket: **Dynamic Enum Creation**: Create enums with flexible options for local or global scoping.
- :lock: **Static Enums**: Prevent changes to any static enum after it's created.
- :earth_africa: **Global Integration**: Easily export enum values globally for convenient usage across your application.
- :tools: **Getters and Helpers**: Retrieve enums, search keys by values, and manage all your enumerations in one place.

## :dart: Purpose
The goal of `EnumManager` is to provide a structured and extensible way to manage enums in Lua that mimics how enums are used in strongly-typed languages like C++ or Java. With this library, you can focus more on logic rather than boilerplate while managing enumerations.

## :books: Installation
Simply place the `EnumManager` file in your Lua project. Then, require it like any other Lua module:
```lua
local Enum = require("EnumManager")
```
No external dependencies are needed as `EnumManager` is built on pure Lua.

## :tools: Usage
Below is an overview of how to use the library. For more details, see the available methods and their respective descriptions.

### 1. **Create a Basic Enum**
You can define an enum with a set of key-value pairs:
```lua
local Enum = require("EnumManager")

Enum("Colors", {
    Red = 1,
    Green = 2,
    Blue = 3
})
```
The above creates an enum called `Colors` with explicit numeric values.

### 2. **Static Enum**
A static enum prevents any modification or addition of new keys:
```lua
local Enum = require("EnumManager")

Enum("Status", {
    Active = 1,
    Inactive = 2
}, { ["static"] = true })

status.Active = 3 -- Error: Cannot modify a static enum
```

### 3. **Global Integration**
Enums can be added to the global scope (default behavior) for broader accessibility:
```lua
local Enum = require("EnumManager")

Enum("Fruits", {
    Apple = 1,
    Banana = 2,
    Cherry = 3
})

print(Apple) -- Output: 1
```

If global exposure isn't desired, simply use the `local` option:
```lua
local Enum = require("EnumManager")

local shapes = Enum("Shapes", {
    Circle = 1,
    Square = 2
}, { ["local"] = true })

print(Circle) -- Output: nil
print(shapes.Circle) -- Output: 1
```

## :test_tube: Example Use Case
```lua
local Enum = require("EnumManager")
-- Creating a Colors Enum

local colors = Enum("Colors", {
        Red = 1,
        Green = 2,
        Blue = 3,
        Yellow = 4
    }, 
    {
        ["local"] = false
    }
)

print(colors) -- Output: { Red = 1, Green = 2, Blue = 5, Yellow = 6 }

-- Access globally scoped Enums
print(Green) -- Output: 2

-- Immutable Enum Example
local status = Enum("Status", { Active = 1, Inactive = 0 }, { ["static"] = true })

status.Active = 2 -- Throws an error
```

## :shield: Roadmap
Upcoming features and potential additions:

- :construction: Better integration with namespaces.
- :mag: Support for enumeration search/filter methods.
- :star2: Enhanced debug logging for enum operations.
- :1234: Auto-Increment Support.
