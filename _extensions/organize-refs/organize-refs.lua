-- Lua filter to organize references by entry type

local refs_by_type = {
  article = {},
  inproceedings = {},
  software = {},
  other = {}
}

function organize_references(doc)
  -- This is a placeholder - Quarto's bibliography processing happens
  -- after Lua filters run, so we can't easily reorganize refs this way
  return doc
end

return {{Pandoc = organize_references}}
