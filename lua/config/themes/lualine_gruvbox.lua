local colors = {
  black        = '#282828',
  white        = '#ebdbb2',
  blue         = '#83a598',
  orange       = '#de935f',
  gray         = '#928374',
  lightgray    = '#504945',
  inactivegray = '#665c54',
  midfont      = '#b4a596',
}

return {
  normal = {
    a = { bg = colors.blue, fg = colors.black },
    b = { bg = colors.gray, fg = colors.black },
    c = { bg = colors.lightgray, fg = colors.midfont },
  },
  insert = {
    a = { bg = colors.blue, fg = colors.black },
    b = { bg = colors.gray, fg = colors.black },
    c = { bg = colors.lightgray, fg = colors.midfont },
  },
  visual = {
    a = { bg = colors.orange, fg = colors.black },
    b = { bg = colors.gray, fg = colors.black },
    c = { bg = colors.lightgray, fg = colors.midfont },
  },
  replace = {
    a = { bg = colors.blue, fg = colors.black },
    b = { bg = colors.gray, fg = colors.black },
    c = { bg = colors.lightgray, fg = colors.midfont },
  },
  command = {
    a = { bg = colors.blue, fg = colors.black },
    b = { bg = colors.gray, fg = colors.black },
    c = { bg = colors.lightgray, fg = colors.midfont },
  },
  inactive = {
    a = { bg = colors.inactivegray, fg = colors.black },
    b = { bg = colors.inactivegray, fg = colors.black },
    c = { bg = colors.inactivegray, fg = colors.black },
  },
}
