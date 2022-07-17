local status_ok, preview_svg = pcall(require, "nvim-preview-svg")

if not status_ok then
  return
end

preview_svg.setup({
  browser = "Brave Browser",
  args = true,
})
