# Globbing

This topic covers the inner machinations ~~of my mind~~ of globbing. Essentially, globs translate to specific Lua patterns which are then matched with strings. All globs are pre-escaped so that the Lua patterns work properly.

## Star glob

The single star glob `*` is equivalent to the Lua pattern `[^/]+`. This means "match everything that is not a forward slash". This lets us do things like `a/*/c`, that will match `a/b/c` but not `a/b/d/c`.

## Double star glob

The double star glob `**` is equivalent to the Lua oattern `.+`. This means "match everything", and as so, it should be treated with caution. With a glob `a/**/c`, we can match both `a/b/d/c` and `a/b/c`.

## Question glob

The question mark glob `?` is equivalent to the Lua pattern `[^/]`. This means "match a single character that is not a forward slash", so you can use it like `h?llo` to match `hello` and `hallo`, as well as `hxllo` and basically anything.