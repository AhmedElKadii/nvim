return {
	"uga-rosa/ccc.nvim",
	config = function()
		local ColorInput = require("ccc.input")
		local convert = require("ccc.utils.convert")

		local HslInput = setmetatable({
			name = "HSL",
			max = { 360, 1, 1 },
			min = { 0, 0, 0 },
			delta = { 1, 0.01, 0.01 },
			bar_name = { "H", "S", "L" },
		}, { __index = ColorInput })

		function HslInput.format(n, i)
			if i == 2 or i == 3 then
				-- S or L in HSL (percentage)
				n = n * 100
			end
			return ("%6d"):format(n)
		end

		function HslInput.from_rgb(RGB)
			return convert.rgb2hsl(RGB)
		end

		function HslInput.to_rgb(value)
			return convert.hsl2rgb(value)
		end

		function HslInput:callback(index, new_value)
			self.value[index] = new_value
			local HSL = { self.value[1], self.value[2], self.value[3] }
			local RGB = convert.hsl2rgb(HSL)
			self.value = HSL -- Keep values in HSL format
		end

		vim.api.nvim_set_hl(0, "CccPoint", { fg = "#000000", bg = "#FFFFFF" })  -- Black icon on white background

		-- Apply the HSL input mode to ccc.nvim
		require("ccc").setup({
			inputs = { HslInput }, -- Only use HSL input
			point_char = "█",  -- Small square for better visibility
			point_color = "#E8DCC5",
		})
	end
}
