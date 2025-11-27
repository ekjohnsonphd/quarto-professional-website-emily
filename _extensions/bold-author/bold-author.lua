-- Lua filter to bold specific author name in bibliography

function RawBlock(el)
  if el.format == "html" and el.text:match('class="csl%-bib%-body"') then
    -- Bold variations of Emily K. Johnson / Johnson, E. K. / Johnson, Emily K.
    el.text = el.text:gsub("Johnson, E%. K%.", "<strong>Johnson, E. K.</strong>")
    el.text = el.text:gsub("Johnson, Emily K%.", "<strong>Johnson, Emily K.</strong>")
    el.text = el.text:gsub("Johnson, Emily", "<strong>Johnson, Emily</strong>")
    return el
  end
  return el
end

function Div(el)
  if el.identifier == "refs" or el.classes:includes("references") then
    -- Process the content to bold author names
    return pandoc.walk_block(el, {
      Str = function(str)
        -- This handles inline text in the bibliography
        return str
      end,
      RawInline = function(raw)
        if raw.format == "html" then
          raw.text = raw.text:gsub("Johnson, E%. K%.", "<strong>Johnson, E. K.</strong>")
          raw.text = raw.text:gsub("Johnson, Emily K%.", "<strong>Johnson, Emily K.</strong>")
          raw.text = raw.text:gsub("Johnson, Emily", "<strong>Johnson, Emily</strong>")
        end
        return raw
      end
    })
  end
  return el
end

return {
  {RawBlock = RawBlock},
  {Div = Div}
}
