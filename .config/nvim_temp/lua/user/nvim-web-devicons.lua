local status_ok, configs = pcall(require, "nvim-web-devicons")
if not status_ok then
  return
end

configs.setup {
  default = true;
}

