-- Lua filter to organize bibliography by entry type

local refs_by_type = {
  article = {},
  inproceedings = {},
  software = {},
  other = {}
}

function Div(el)
  if el.identifier == "refs" then
    -- Store reference divs by their parent section
    return el
  end
  return el
end

-- This filter needs to run after citeproc
return {
  {Div = Div}
}
