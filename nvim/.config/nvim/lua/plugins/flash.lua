return {
    "folke/flash.nvim",
    opts = {},
    keys = {
        {
            "s",
            mode = { "n", "x", "o" },
            function()
                require("flash").jump()
            end,
            desc = "Flash jump",
        },
    },
}
