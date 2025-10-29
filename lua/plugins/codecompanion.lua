return {
  "olimorris/codecompanion.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
	require("codecompanion").setup({
	  strategies = {
		chat = {
		  adapter = "ollama",  -- Force chat strategy to use Ollama
		},
		inline = {
		  adapter = "ollama",  -- Force inline strategy to use Ollama
		},
	  },
	  adapters = {
		ollama = function()
		  return require("codecompanion.adapters").extend("ollama", {
			schema = {
			  model = { default = "llama3" }, -- Your Ollama model here
			},
			env = {
			  url = "http://localhost:11434",
			},
		  })
		end,
	  },
	})
  end
}

