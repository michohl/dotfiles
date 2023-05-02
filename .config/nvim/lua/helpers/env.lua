local env = {}

-- trim whitespace from string
function env.trim(s)
  return (string.gsub(s, "^%s*(.-)%s*$", "%1"))
end

-- Check if the processing line is a commented line
function env.isCommentedLine(line)
  return string.sub(env.trim(line), 1, 1) == "#"
end

-- Check if line is empty
function env.isEmptyLine(s)
  return env.trim(s) == ""
end

-- Split line into a key and value pair
function env.parseKV(s)
  -- Remove the export from the line if it exists and trim leading whitespace
  local l = string.gsub(env.trim(s), "export ", "")

  -- Return the key and value on each side of the "=" symbol in the envFile
  return string.match(l, "(%S+)=(%S+)")
end

-- Take a file path and trim it down to what is able to be loaded
function env.formatFileName(s)
  return string.gsub(env.trim(s), "${workspaceFolder}/", "")
end

-- Find our launch.json file and return it's contents if it exists. Otherwise return nil
function env.readLaunchJSON()
  local json = require("helpers/json")

  -- TODO: Improve this to _find_ the launch.json file instead of relying on it being in the right spot
  local filePath = ".vscode/launch.json"

  -- Load launch.json so we can parse out it's envFile location (if it has one)
  local f = io.open(filePath, "r")

  -- If the file isn't able to be opened then don't do any more work
  if f == nil then
    return nil
  end

  -- Read the contents of the file into a struct we can parse
  local data = json.parse(f:read "*a")

  -- Close the launch.json file only if we opened it
  if f ~= nil then
    io.close(f)
  end

  return data
end

return env
