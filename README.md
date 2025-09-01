# fold.nvim

Easily focus on code blocks using manual folds.

## Install

#### [Lazy](https://github.com/folke/lazy.nvim)

```lua
{
    "vertexE/fold.nvim",
    dependencies = {
        "mini.nvim", -- optional, only if you want to use fold.diff, which requires mini.diff
    },
    keys = {
        {
            "<leader>fi",
            function()
                if require("fold").focused() then
                    require("fold").text({})
                    return
                end

                vim.ui.input({
                    prompt = "Focus on buffer text",
                }, function(input)
                    require("fold").text({ input })
                end)
            end,
            mode = { "n" },
            desc = "focus on text in buffer",
        },
        {
            "<leader>E",
            function()
                require("fold").diagnostics()
            end,
            mode = { "n" },
            desc = "focus on diagnostics",
        },
        {
            "<leader>M",
            function()
                require("fold").marks()
            end,
            mode = { "n" },
            desc = "focus on marks",
        },
        {
            "<leader>zz",
            function()
                require("fold").zen()
            end,
            mode = { "n", "x" },
            desc = "focus on visual selection",
        },
        {
            "<leader>D",
            function()
                require("fold").diff()
            end,
            mode = { "n" },
            desc = "focus on changes",
        },
    },
}

```

## Usage


## What's Next?

- [ ] support manually added focus locations
- [ ] add a "status" func to display the active focus
- [ ] iron out any bugs

### Demo

