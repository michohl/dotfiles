-- All of our helper functions
env = require("helpers/env")

-- Load the content of a file into our ENV
local readEnvFile = function(filePath)
  local f = io.open(filePath, "r")
  if f == nil then
    return
  end

  for line in f:lines() do
    if not env.isCommentedLine(line) and not env.isEmptyLine(line) then
      local key, value = env.parseKV(line)

      -- Remove any double quotes or single quotes around the value
      -- value, _ = string.gsub(value, '"(%s+)"', "%1")
      -- value, _ = string.gsub(value, "'(%s+)'", "%1")
      if value:sub(1,1) == '"' and value:sub(-1,-1) == '"' then
        value = value:sub(2, -2)
      elseif value:sub(1,1) == "'" and value:sub(-1,-1) == "'" then
        value = value:sub(2, -2)
      end

      -- Set the environment variable in Vim only. This won't persist when we exit Vim
      vim.fn.setenv(key, value)
    end
  end
end

-- Get list of envFiles from our launch.json and parse each of them
local loadEnvFiles = function()

  -- Parse our launch.json into a struct we can use
  local data = env.readLaunchJSON()
  if data == nil then
    return
  end

  -- Keep track  if any of our configurations in launch.json actually contain a  envFile specification
  local foundEnvFile = false

  -- Get all the envFiles in our launch.json and load them into local ENV
  for _, config in next, data.configurations do
    if config.envFile ~= nil then
      foundEnvFile = true
      readEnvFile(env.formatFileName(config.envFile))
    end
  end

  -- If we found an envFile to try and load while parsing the config then let the user know we loaded it
  if foundEnvFile then
    require("notify")("Found and loaded envFile(s)")
  end

end

-- call our main function
loadEnvFiles()
