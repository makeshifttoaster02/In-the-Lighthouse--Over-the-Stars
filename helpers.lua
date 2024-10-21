function RequireDirectory(path)
    local files = love.filesystem.getDirectoryItems(path)
    local directories = {}
    local err = false
    for k, file in pairs(files) do
        file = path .. "/" .. file
        if love.filesystem.getInfo(file) == nil then
            table.insert(directories, file)
        else
            if string.match(file, ".lua") then
                local ok, chunk = pcall(love.filesystem.load, file)
                if not ok then
                    print("Nope! loadDirectory load file.", tostring(chunk))
                    err = true
                else
                    local ok, result = pcall(chunk)
                    if not ok then
                        print("Nope! loadDirectory execute file", tostring(result))
                        err = true
                    else
                        print("Loaded", file)
                    end
                end
            end
        end
    end
    for k, directory in pairs(directories) do
        local tempErr = RequireDirectory(directory)
        if tempErr then
            err = true
        end
    end

    return err
end

function ConvertColorHEXToVec(rgba)
    local rb = tonumber(string.sub(rgba, 2, 3), 16)
	local gb = tonumber(string.sub(rgba, 4, 5), 16)
	local bb = tonumber(string.sub(rgba, 6, 7), 16)
	local ab = tonumber(string.sub(rgba, 8, 9), 16) or nil
    return love.math.colorFromBytes(rb, gb, bb, ab)
end

function SetColorHEX(rgba)
	love.graphics.setColor(ConvertColorHEXToVec(rgba))
end

function IsAlphanumeric(key)
    return key:match("^[%w]$") ~= nil
end

function IsLowercase(key)
    return key:match("^[a-z]$")
end