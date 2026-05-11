# MANIFEST — persistent-ai-collaboration

Live site: https://energyscholar.github.io/persistent-ai-collaboration/

## Build

`./build-zip.sh` produces two archives:
- `persistent-ai-collaboration.zip` (64KB) — index.html + tutorial-magnetosphere.html + LICENSE
- `persistent-ai-collaboration-full.zip` (2.8MB) — everything including tutorials/

Run after any content change. Commit zips alongside source.

## Files

| File | Purpose |
|------|---------|
| `index.html` | "Your AI Has Amnesia" white paper |
| `tutorial-magnetosphere.html` | Magnetosphere tutorial (animated SVGs, nav dots) |
| `tutorial-inference.html` | LLM inference tutorial |
| `tutorials/` | Extended catalog (14 files) |
| `build-zip.sh` | Zip builder |
| `CLAUDE.md` | One-line build reminder |

## Architecture notes

- 8 parent accordions (one per section), existing sub-accordions nest inside
- Deep links: `openHashTarget()` walks full ancestor chain via while-loop
- New accordions need `id` + anchor link in `<summary>` with `onclick="event.stopPropagation()"`
- TOC has "Expand all / Collapse all" toggle
- Tooltips via `data-tip` attribute, max-width 400px
- Print stylesheet opens all accordions
