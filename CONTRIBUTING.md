# Contributing

The one rule that will bite you if you skip it: **nothing under `extras/` is
written by hand.** All 25 files are rendered from `lua/sora/palette.lua`, and the
test compares each committed file against a fresh render. Any difference fails.
Edit the generator, not the output.

## Run the tests first

```sh
nvim --headless --noplugin -u NONE -c "set rtp+=." -c "luafile test/smoke.lua"
nvim --headless --noplugin -u NONE -c "set rtp+=." -c "luafile test/extras.lua"
```

Both exit non-zero on failure. `smoke (stable)` and `smoke (nightly)` run both
and are required to merge, so a red test is not a review comment, it is a blocked
branch.

`test/smoke.lua` loads the scheme through `nvim_set_hl`, which throws on a nil or
malformed colour, so a group referencing a missing palette key blows up there.
`test/extras.lua` does two things: every `#rrggbb` under `extras/` must be a
current palette value, and every generated file must equal a fresh render.

## Regenerate after touching a colour

```sh
nvim --headless --noplugin -u NONE -c "set rtp+=." -c "luafile scripts/extras.lua" -c q
```

Commit what it writes. A pull request that changes the palette without the
regenerated files fails the drift check.

## Commit messages

[Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/),
`type(scope): subject`, in English. release-please reads them to build
`CHANGELOG.md` and pick the next version, so the type is not decoration.

`feat` and `fix` produce a changelog entry. `docs`, `test`, `refactor`, `ci` and
`chore` do not, which is fine and often correct.

Scopes in use:

| scope | what it covers |
| --- | --- |
| `palette` | the colours in `lua/sora/palette.lua` |
| `groups` | highlight groups under `lua/sora/groups/` |
| `extras` | a generator under `lua/sora/extras/`, and its output |
| `lualine` | the lualine theme |
| `site` | the landing page under `docs/` |
| `ci` | workflows, checks, release tooling |

A single-tool change can take that tool as its scope instead, as `fix(yazi)` and
`feat(helix)` already do. Prefer several small commits to one large one.
`Release-As:` in a footer forces a version when a release needs one.

## Adding highlight groups

The role map is the whole design. A group that ignores it will look wrong beside
every other group:

| colour | role |
| --- | --- |
| `cyan` | functions, and the UI accent |
| `purple` | keywords, storage, control flow |
| `sage` | strings |
| `gold` | constants and numbers |
| `peach` | types and constructors |
| `rose` | booleans, builtins, exceptions |
| `teal` | tags, regex, escapes |
| `steel` | operators and properties |
| `variable` | variable names, which are not a role of their own |

Diagnostics are a separate family. `error` `warning` `info` `hint` `ok` carry
more chroma than any syntax colour, so a diagnostic never wears the same red as
a builtin. Never reach for a syntax colour to signal a state.

**Do not paint plugin windows.** Telescope, which-key, Noice and the rest link
their windows to `NormalFloat` and their edges to `FloatBorder`. Colouring those
two is enough to colour all of them, including plugins released after you read
this. A verbatim copy of either group pins a background that `transparent = true`
then cannot strip, which is what used to leave Telescope, Trouble and Noice
opaque over the terminal.

The test refuses any verbatim copy, so this is a failed build rather than a
review comment. Two families are exempt and say why in the allow list: the
completion menu, because a see-through popup over code is not readable, and
blink.cmp, which points its windows at neither group. A window that genuinely
owns its ground names itself in `transparent_groups` instead.

## Adding a surface

Write a generator in the right module under `lua/sora/extras/`, register it in
`lua/sora/extras/init.lua`, regenerate, and add a test that pins the tool's
schema.

That last part is the one worth insisting on. Tools in this space fail the same
way: they ignore what they do not recognise instead of refusing it, so half a
theme applies and nothing says which half. The drift check cannot catch that,
because regenerating makes the file agree with itself.

So find the list the tool's own code reads, not its documentation page. A
shipped preset theme, a constant in its parser or a published type all beat a
docs table, which is where the two tend to disagree.

## Colours

`lua/sora/palette.lua` is the only place a colour is defined, and every value in
it is a literal. There are no derived shades and no blends computed at load time,
which is what lets the extras test assert that a hex found under `extras/` is a
palette value and nothing else. A colour that appears in a generated file and not
in the palette is a bug in the generator, not an exception to add to the test.

A pull request that changes a hue needs to say what it is trying to fix.
"It looks better" is a valid opinion and belongs in a
[discussion](https://github.com/Aejkatappaja/sora/discussions), where it may well
win.

## Licence

MIT. By contributing you agree your work ships under it.
