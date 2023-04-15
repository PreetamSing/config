local status_ok, configs = pcall(require, "nightfox")
if not status_ok then
	return
end

configs.setup({
	options = {
		styles = {
			comments = "italic",
			keywords = "bold",
			types = "italic,bold",
		},
	},
})
