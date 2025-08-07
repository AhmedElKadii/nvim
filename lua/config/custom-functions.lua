-- general
-- Custom function to determine project type and call the corresponding command
function determine_file_type(args)
    print("Determining file type...")
    -- Check for Unity project indicator
    if vim.fn.filereadable('ProjectSettings/ProjectSettings.asset') == 1 then print("Unity project detected")
        vim.cmd(string.format("NewUnityScript %s", args))
    -- Check for Godot project indicator
    elseif vim.fn.filereadable('project.godot') == 1 then
        print("Godot project detected")
        vim.cmd(string.format("NewGodotScript %s", args))
    else
        print("Unsupported project type for script creation.")
    end
end

vim.api.nvim_create_user_command(
    'DetermineFileType',
    function(opts)
        determine_file_type(opts.args)
    end,
    { nargs = '*' }
)

-- unity
-- Custom function to check if we are in a Unity project
local unityproject = io.open(vim.fn.getcwd()..'/ProjectSettings/ProjectSettings.asset', 'r')
if unityproject then
    io.close(unityproject)
    vim.fn.serverstart '/tmp/nvimsocket'
end
-- Custom function to create a new Unity C# script with default boilerplate code
function CreateUnityCSharpScript(filename, classType)
    classType = classType or "MonoBehaviour"
    if not filename:match(".cs$") then
        filename = filename .. ".cs"
    end

	local usageRefs = "\n\n"
	if classType == "MonoBehaviour" then
		usageRefs = "using UnityEngine;\n\n"
	elseif classType == "ScriptableObject" or classType == "Editor" then
		usageRefs = "using UnityEditor;\n\n"
	else usageRefs = ""
	end

    local path = 'Assets/Scripts/' .. filename
    local file = io.open(path, 'w')

    if file then
        file:write(
          usageRefs ..
          "public class " .. filename:gsub('.cs', '') .. " : " .. classType .. "\n" ..
          "{\n" ..
          "    void Start()\n" ..
          "    {\n" ..
          "        \n" ..
          "    }\n\n" ..
          "    void Update()\n" ..
          "    {\n" ..
          "        \n" ..
          "    }\n" ..
          "}\n"
        )
        file:close()
        print('Created new script: ' .. path)
        vim.cmd('e ' .. path)
    else
        print('Failed to create file: ' .. path)
    end
end

vim.api.nvim_create_user_command(
    'NewUnityScript',
    function(opts)
        local args = vim.split(opts.args, ' ', true)
        local filename = args[1] or ""
        local classType = args[2]

        CreateUnityCSharpScript(filename, classType)
    end,
    { nargs = '*' }
)

-- godot
-- Custom function to check if we are in a Godot project
local gdproject = io.open(vim.fn.getcwd()..'/project.godot', 'r')
if gdproject then
    io.close(gdproject)
    vim.fn.serverstart '/tmp/nvimsocket'
end
-- Custom function to create a new Godot GDScript with default boilerplate code
function CreateGodotGDScript(filename, type, path)
    type = type or "Node2D"

	path = path or vim.fn.expand('%:p:h')

    if not filename:match(".gd$") then
        filename = filename .. ".gd"
    end

    local fullPath = path .. "/" .. filename
    local file = io.open(fullPath, 'w')

    if file then
        file:write("extends " .. type .. "\n\n"
        .. "func _ready():\n"
        .. "    pass\n\n"
        .. "func _process(delta):\n"
        .. "    pass\n"
        )
        file:close()
        print('Created new script: ' .. fullPath)
        vim.cmd('e ' .. fullPath)
    else
        print('Failed to create file: ' .. fullPath)
    end
end

vim.api.nvim_create_user_command(
    'NewGodotScript',
    function(opts)
        local args = vim.split(opts.args, ' ', true)
        local path = args[1] or ""
        local filename = args[2] or ""
        local type = args[3]

        CreateGodotGDScript(path, filename, type)
    end,
    { nargs = '*' }
)

-- LaTeX
-- Function to create a new LaTeX project when opening a .tex file
function AutoCreateLaTeXProject()
    local currentFile = vim.fn.expand('%:p')  -- Get the full path of the opened file
    print("Opened file: " .. currentFile)  -- Debug: print the file being opened

    -- Check if the file ends with '.tex' (no need to check if it exists since BufNewFile is for new files)
    if currentFile:match("%.tex$") then
        local filename = vim.fn.fnamemodify(currentFile, ":t")  -- Extract the file name
        print("Creating new LaTeX project for file: " .. filename)  -- Debug: confirm project creation
        CreateLaTeXProject(filename)
    else
        print("File is not a .tex file.")
    end
end

-- Function to format the filename for the title
function formatTitle(filename)
    -- Remove the extension
    local nameWithoutExt = filename:gsub("%.tex$", "")
    -- Add spaces before uppercase letters
    local formattedName = nameWithoutExt:gsub("(%u)", " %1"):gsub("^ ", "")
    return formattedName
end

-- LaTeX project creation function
function CreateLaTeXProject(filename)
    -- Define LaTeX directory and template path
    local latexDir = "~/Documents/LaTeX"
    local templateDir = latexDir .. "/.template"

    -- Expand the templateDir to handle the home directory correctly
    templateDir = vim.fn.expand(templateDir)

    -- Ensure the filename ends with '.tex'
    if not filename:match("%.tex$") then
        filename = filename .. ".tex"
    end

    -- Get the current working directory
    local currentDir = vim.fn.getcwd()
    
    -- Extract the current folder and parent folder names
    local currentFolder = vim.fn.fnamemodify(currentDir, ":t")
    local parentFolder = vim.fn.fnamemodify(currentDir, ":h:t")

    -- Create a new folder inside the current working directory for the LaTeX project
    local newFolder = currentDir .. "/" .. filename:gsub(".tex$", "")
    vim.fn.mkdir(newFolder)
    print("Created folder: " .. newFolder)  -- Debug: check if folder creation works

    -- List of required template files to copy
    local templateFiles = {
        "letterfonts.tex",
        "macros.tex",
        "preamble.tex"
    }

    -- Copy each specified template file to the new folder
    for _, file in ipairs(templateFiles) do
        local sourceFile = templateDir .. "/" .. file
        local destinationFile = newFolder .. "/" .. file
        local copyResult = vim.fn.system({'cp', sourceFile, destinationFile})
        print("Copy result for " .. file .. ": " .. copyResult)  -- Debug: show copy result
    end

    -- Define the new .tex file path
    local texFilePath = newFolder .. "/" .. filename

    -- Format the title using the filename without extension
    local title = formatTitle(filename)

    -- Open the new .tex file for writing
    local file = io.open(texFilePath, 'w')

    if file then
        -- Write the structure with folder names in the title
        file:write([[
\documentclass{report}

\input{preamble}
\input{macros}
\input{letterfonts}

\title{\Huge{]] .. parentFolder .. "}" .. title .. [[}
\author{\huge{Ahmed El Kadii}\\1221196}
\date{}

\begin{document}

\maketitle

\end{document}
]])
        file:close()
        print("Created new LaTeX project: " .. texFilePath)
        -- Open the newly created .tex file in the editor
        vim.cmd('e ' .. texFilePath)
    else
        print("Failed to create file: " .. texFilePath)
    end
end

-- Autocommand to trigger LaTeX project creation when a new .tex file is opened
vim.api.nvim_create_autocmd(
{"BufNewFile"},
{
	pattern = "*.tex",
	callback = function()
		AutoCreateLaTeXProject()
	end
}
)

-- Google
function GoogleSearch()
  -- Prompt user for search query
  local search_term = vim.fn.input('Google Search: ')

  -- Append language parameter (&hl=en) to force English search results
  local query = search_term:gsub(" ", "+") .. '&hl=en'

  -- Open the search in a vertical split on the right side and run the :W3m command
  vim.cmd('rightbelow vsplit')
  vim.cmd('W3m https://www.google.com/search?q=' .. query)
end

-- Map the function to a key (example: <leader>gs)
vim.api.nvim_set_keymap('n', '<leader>gs', ':lua GoogleSearch()<CR>', { noremap = true, silent = true })

-- Copilot
local copilot_enabled = true
function ToggleCopilot()
	if copilot_enabled then
        vim.cmd("Copilot disable")
        print("GitHub Copilot disabled globally.")
    else
        vim.cmd("Copilot enable")
        print("GitHub Copilot enabled globally.")
    end
    -- Toggle the state
    copilot_enabled = not copilot_enabled
end

-- Compilation
-- Function to determine the action based on file extension
function Compile()
  local file_ext = vim.fn.expand('%:e')  -- Get the current file extension

  if file_ext == 'c' then
    -- If it's a .c file, compile it using gcc
    vim.cmd(':w')
    vim.cmd(':![ -d build ] || mkdir build; cd build; cmake .. && make')  -- Compile the C file
  elseif file_ext == 'tex' then
	vim.cmd(':w')
	vim.cmd(':VimtexCompile')  -- Compile the LaTeX file
  elseif file_ext == 'ino' then
	-- If it's an Arduino sketch, compile it using arduino-cli
	vim.cmd(':w')
	vim.cmd(':!arduino-cli compile')  -- Compile and upload the Arduino sketch
	vim.cmd('startinsert')
  else
    print("File type not supported for <F3> action")
  end
end

-- Function to compile and run C files in terminal
function CompileAndRun()
  local file_ext = vim.fn.expand('%:e')  -- Get the current file extension

  if file_ext == 'c' then
    -- Save the file
    vim.cmd(':w')

    vim.cmd(':![ -d build ] || mkdir build; cd build; cmake .. && make && ./main')  -- Compile the C file

  elseif file_ext == 'm' then
    -- Run MATLAB script in terminal
    vim.cmd(':wa')  -- Save all open buffers
    vim.cmd(':terminal /Applications/MATLAB_R2024b.app/bin/matlab -nodesktop -nosplash -r "run(\'%:p\')"')  -- Run MATLAB script

    -- Switch to terminal insert mode
    vim.cmd('startinsert')
  elseif file_ext == 'ino' then
	-- If it's an Arduino sketch, compile and upload it using arduino-cli
	vim.cmd(':w')
	vim.cmd(':!arduino-cli compile --upload')  -- Compile and upload the Arduino sketch
	vim.cmd('startinsert')
  elseif file_ext == 'py' then
	-- Run Python script in terminal
	vim.cmd(':wa')  -- Save all open buffers
	vim.cmd(':terminal python3 %')  -- Run Python script

	-- Switch to terminal insert mode
	vim.cmd('startinsert')
   else
    print("File type not supported for F5 action")
  end
end

-- autogen CMakeLists.txt
vim.api.nvim_create_autocmd("BufRead", {
    pattern = "*.c",
    callback = function()
        local cmake_file = "CMakeLists.txt"

        -- Check if CMakeLists.txt already exists
        local cmake_exists = vim.fn.filereadable(cmake_file) == 1

        if not cmake_exists then
            local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t") -- Get folder name as project name
            local cmake_content = string.format([[
cmake_minimum_required(VERSION 3.10)
project(%s C)

set(CMAKE_C_STANDARD 99)

file(GLOB SOURCES "*.c")

add_executable(main ${SOURCES})
            ]], project_name)

            -- Write the generated content to CMakeLists.txt
            local file = io.open(cmake_file, "w")
            if file then
                file:write(cmake_content)
                file:close()
                print("Generated CMakeLists.txt for project: " .. project_name)
            else
                print("Error: Could not create CMakeLists.txt")
            end
        end
    end
})

-- function to autostart live server when an index.html file is found
vim.api.nvim_create_autocmd("VimEnter", {
    pattern = "*.html",
    callback = function()
        local current_file = vim.fn.expand("%:p")
        local project_root = vim.fn.fnamemodify(current_file, ":h") -- Get the directory of the file
        local live_server_running = #vim.fn.systemlist("pgrep -f 'live-server'") > 0

        if not live_server_running then
            -- Start live-server from the project root
            vim.fn.jobstart("nohup live-server " .. vim.fn.shellescape(project_root) .. " > /dev/null 2>&1 &", {
                detach = true,
                on_exit = function()
                    -- Wait a bit, then refocus Ghostty
                    vim.defer_fn(function()
                        vim.fn.system("osascript -e 'tell application \"Ghostty\" to activate'")
                    end, 50)  -- Adjust delay if needed
                end,
            })
        else
            -- Restart live-server
            vim.fn.system("pkill -f 'live-server'")
            vim.fn.jobstart("nohup live-server " .. vim.fn.shellescape(project_root) .. " > /dev/null 2>&1 &", {
                detach = true,
                on_exit = function()
                    -- Wait a bit, then refocus Ghostty
                    vim.defer_fn(function()
                        vim.fn.system("osascript -e 'tell application \"Ghostty\" to activate'")
                    end, 50)  -- Adjust delay if needed
                end,
            })
        end
    end,
})

-- Set initial state
vim.opt.number = true
vim.opt.relativenumber = false

-- godot watcher autostart
-- Function to check if we're in a Godot project
local function is_godot_project()
    local handle = io.popen("test -d .godot && echo 'yes'")
    local result = handle:read("*a")
    handle:close()
    return result:match("yes") ~= nil
end

-- Start the watcher in the background
local function start_watcher()
    if is_godot_project() then
        -- Kill any existing watcher to avoid duplicates
        vim.fn.jobstart("pkill -f godot-cs-watch", { detach = true })
        -- Start the watcher in the background
        vim.fn.jobstart("godot-cs-watch", { detach = true })
    end
end

-- Stop the watcher when Neovim exits
local function stop_watcher()
    vim.fn.jobstart("pkill -f godot-cs-watch", { detach = true })
end

-- Auto-run when opening Neovim inside a Godot project
vim.api.nvim_create_autocmd("VimEnter", { callback = start_watcher })

-- Auto-stop when leaving Neovim
vim.api.nvim_create_autocmd("VimLeavePre", { callback = stop_watcher })

-- Open Hyperlinks
local function open_link_under_cursor()
  local line = vim.api.nvim_get_current_line()
  local col = vim.fn.col('.') - 1
  local link = nil

  for start_idx_str, _, match, end_idx_str in line:gmatch('()(%[.-%]%((.-)%)())') do
    local start_idx = tonumber(start_idx_str)
    local end_idx = tonumber(end_idx_str)
    if col >= start_idx and col <= end_idx then
      link = match
      break
    end
  end

  if link then
    -- Convert relative path to absolute path if it looks like a file
    if not link:match("^https?://") and not link:match("^file://") and not link:match("^/") and not link:match("^~") then
      local buf_dir = vim.fn.expand('%:p:h')  -- current buffer's directory
      link = vim.fn.fnamemodify(buf_dir .. "/" .. link, ":p")
    end

    -- Detect OS
    local opener
    local os_name = vim.loop.os_uname().sysname
    if os_name == "Darwin" then
      opener = "open"
    elseif os_name == "Linux" then
      opener = "xdg-open"
    else
      print("Unsupported OS: " .. os_name)
      return
    end

    local ok = vim.fn.jobstart({ opener, link }, { detach = true })
    if ok <= 0 then
      print("Failed to open: " .. link)
    end
  else
    print("No [text](link) under cursor.")
  end
end

vim.api.nvim_create_user_command("OpenLink", open_link_under_cursor, {})
