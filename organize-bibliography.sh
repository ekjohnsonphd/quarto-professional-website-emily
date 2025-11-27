#!/bin/bash
# Automatically organize references.bib and generate publications.qmd
# This script runs before each Quarto render

echo "Organizing bibliography by type..."

# Extract citation keys by type
ARTICLES=$(grep "^@article{" references.bib | sed 's/@article{/  @/' | sed 's/,$/;/' | tr '\n' ' ' | sed 's/; $//')
CONFERENCES=$(grep "^@inproceedings{" references.bib | sed 's/@inproceedings{/  @/' | sed 's/,$/;/' | tr '\n' ' ' | sed 's/; $//')
SOFTWARE=$(grep "^@software{" references.bib | sed 's/@software{/  @/' | sed 's/,$//')

# Count entries
ARTICLE_COUNT=$(grep -c "^@article{" references.bib)
CONF_COUNT=$(grep -c "^@inproceedings{" references.bib)
SOFT_COUNT=$(grep -c "^@software{" references.bib)

# Generate the publications.qmd file with inline citations
cat > publications.qmd << EOF
---
title: "Publications"
description: "Published research and scholarly works"
bibliography: references.bib
csl: apa.csl
---

\`\`\`{=html}
<style>
.references { margin-left: 0; padding-left: 0; }
.references .csl-entry { margin-bottom: 1em; }
</style>
\`\`\`

## Journal Articles

::: {#refs-articles}
:::

---
nocite: |
$ARTICLES
references:
- type: article-journal
  id: refs-articles
---

## Conference Proceedings

::: {#refs-conference}
:::

---
nocite: |
$CONFERENCES
references:
- type: paper-conference
  id: refs-conference
---

## Software & Code

::: {#refs-software}
:::

---
nocite: |
$SOFTWARE
references:
- type: software
  id: refs-software
---
EOF

echo "Bibliography organization complete!"
echo "  - Articles: $ARTICLE_COUNT"
echo "  - Conference: $CONF_COUNT"
echo "  - Software: $SOFT_COUNT"
