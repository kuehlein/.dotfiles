-- Initialize the channel
local jobId = vim.g.jobId or 0;

-- The path to the binary that was created out of 'cargo build' or 'cargo build --release. This will generally be 'target/release/name'
local bin = "../../dev/rover-runner-nvim/target/debug/rover-runner-nvim";

-- Constants for RPC messages
local ACTIVATE = "activate";
local DEACTIVATE = "deactivate";

local GENERATE_TEMPLATE = "generate-template";
local SET_ENVIRONMENT_VARIALBES = "set-environment-variables";


-- Initialize RPC
local function initRpc()
    if jobId == 0 then
        return vim.fn.jobstart(bin, { rpc = true });
    end

    return jobId;
end

local function activate()
    -- vim.rpcnotify(jobId, Info, "-- --vim", p) -- what should i do here to make it interesting for testing?
    vim.rpcnotify(jobId, ACTIVATE); -- what should i do here to make it interesting for testing?
end

local function deactivate()
-- local function deactivate(...)
--     local args = {...};
--     local p = args[1] or 0;
--     local q = args[2] or 1;

    vim.rpcnotify(jobId, DEACTIVATE); -- , p);
end

local function configureCommands()
    vim.api.nvim_create_user_command("RRStart", function() activate() end, { nargs = 0 });

    vim.api.nvim_create_user_command("RREnd", function() activate() end, { nargs = 0 });

    -- vim.api.nvim_create_user_command("Info", function(opts)
    --     info(unpack(opts.fargs));
    -- end, { nargs = "+" });

    -- vim.api.nvim_create_user_command("Multiply", function(opts)
    --     multiply(unpack(opts.fargs));
    -- end, { nargs = "+" });
end

-- Entry point. Initialize RPC. If it succeeds, then attach commands to the `rpcnotify` invocations
local function connect()
    local id = initRpc();

    if id == 0 then
        vim.api.nvim_err_writeln("Rover Runner: cannot start rpc process.");
    elseif id == -1 then
        vim.api.nvim_err_writeln("Rover Runner: rpc process is not executable.");
    else
        -- Mutate our jobId variable to hold the channel ID
        jobId = id;

        configureCommands();
        activate_rover_runner();
    end
end


jobId = initRpc();
connect();

