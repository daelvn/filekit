# Functions

List of functions defined in filekit. All paths returned by the functions (that do not manipulate paths) are absolute. This means that `combine` does not return absolute paths, but `list` does.

| Function                                                             | Description                                                                  |
| -------------------------------------------------------------------- | ---------------------------------------------------------------------------- |
| **Paths**                                                            |                                                                              |
| [currentDir ()](#currentdir)                                         | Returns the current working directory.                                       |
| [changeDir (path:string)](#changedir)                                | Changes the current working directory.                                       |
| [combine (basePath:string, localPath:string)](#combine)              | Combines two path components together.                                       |
| [reduce (path:string)](#reduce)                                      | Reduces `.` and `..` in paths.                                               |
| **Actions**                                                          |                                                                              |
| [move (fromPath:string, toPath:string)](#move)                       | Moves a path to another. Equivalent to `os.rename`                           |
| [copy (fromPath:string, toPath:string)](#copy)                       | Copies a path to another.                                                    |
| [delete (path:string)](#delete)                                      | Deletes a path.                                                              |
| [link (fromPath:string, toPath:string)](#link)                       | Creates a hard link.                                                         |
| [symlink (fromPath:string, toPath:string)](#symlink)                 | Creates a soft link.                                                         |
| [open (path:string, mode:string)](#open)                             | Alias to `io.open`.                                                          |
| [safeOpen (path:string, mode:string)](#safeopen)                     | A wrapper around `io.open`.                                                  |
| [makeDir (path:string)](#makedir)                                    | Creates a new directory.                                                     |
| [lock (file:file, excl:boolean, start:number, length:number)](#lock) | Locks a file handle.                                                         |
| [unlock (file:file, start:number, length:number)](#unlock)           | Unlocks a file handle.                                                       |
| [lockDir (path:string, stale:number)](#lockdir)                      | Locks a directory.                                                           |
| [setMode (file:file, mode:string)](#setmode)                         | Sets the mode for a file handle.                                             |
| **Attributes**                                                       |                                                                              |
| [getPermissions (path:string)](#getpermissions)                      | Gets the permissions of a file as a table.                                   |
| [getOctalPermissions (path:string)](#getoctalpermissions)            | Gets the permissions of a file as an octal number.                           |
| [touch (path:string, atime:number, mtime:number)](#touch)            | Sets the access and modification times of a file.                            |
| **Globbing**                                                         |                                                                              |
| [fromGlob (glob:string)](#fromglob)                                  | Compiles a path with globs (`*`, `**`, `?`) to a Lua pattern.                |
| [matchGlob (glob:string, path:string)](#matchglob)                   | Matches a path with globs to a path.                                         |
| **Lists**                                                            |                                                                              |
| [list (path:string)](#list)                                          | Lists all nodes in a directory and returns it as a list.                     |
| [list1 (path:string)](#list1)                                        | [`list`](#list), but excludes `..`                                           |
| [ilist (path:string)](#ilist)                                        | [`list`](#list), as an iterator.                                             |
| [ilist1 (path:string)](#ilist1)                                      | [`list1`](#list1), as an iterator.                                           |
| [listAll (path:string)](#listall)                                    | Lists all nodes in a directory recursively.                                  |
| [glob (glob:string)](#glob)                                          | Returns a list of nodes in the current directory that match the globs        |
| [iglob (glob:string)](#iglob)                                        | [`glob`](#glob) as an iterator.                                              |
| **Checks**                                                           |                                                                              |
| [exists (path:string)](#exists)                                      | Checks if a path refers to an existing file or directory.                    |
| [isDir (path:string)](#isdir)                                        | Checks if a path refers to an existing directory.                            |
| [isFile (path:string)](#isfile)                                      | Checks if a path refers to an existing file.                                 |
| [isLink (path:string)](#islink)                                      | Checks if a path refers to an existing link.                                 |
| [isSocket (path:string)](#issocket)                                  | Checks if a path refers to an existing socket.                               |
| [isPipe (path:string)](#ispipe)                                      | Checks if a path refers to an existing pipe.                                 |
| [isCharDevice (path:string)](#ischardevice)                          | Checks if a path refers to an existing char device.                          |
| [isBlockDevice (path:string)](#isblockdevice)                        | Checks if a path refers to an existing block device.                         |
| [isOther (path:string)](#isother)                                    | Checks if a path refers to an existing node that is none of the other types. |
| [isReadOnly (path:string)](#isreadonly)                              | Checks if a path is read-only                                                |
| [isEmpty (path:string)](#isempty)                                    | Checks if a directory is empty                                               |


## Paths

Functions that manipulate paths.

### currentDir

Returns the current directory as a path.

### changeDir

Changes the current directory.

### combine

Combines two path components, returning a path consisting of the "local" path nested inside the "base" path.

```lua
fs.combine ("a",      "b")     --> a/b
fs.combine ("",       "a")     --> /a
fs.combine ("a/b/c/", "/d/e/") --> a/b/c/d/e/
```

### reduce

Reduces `..` and `.` in paths. Turns things like `a/b/../c/./d` into `a/c/d`.

```lua
fs.reduce ("a/b/../c/./d") --> a/c/d
```

## Actions

### move

Moves a path to another. This is an alias for `os.rename`, so you might be subject to whatever that means.

### copy

Copies a path to another. This function is recursive and works with directories too.

### delete

Deletes a path. This function is also recursive, so it works on non-empty directories.

### link

Creates a hard link.

### symlink

Creates a symlink.

### open

Alias for `io.open`.

### safeOpen

Returns a file handle, or if errored, a table with a field `error` that contains the error. Mostly used in MoonScript with the `with` statement.

```moon
with fs.safeOpen "file", "r"
  error .error if .error
  print \read "*a"
  \close!
```

### makeDir

Creates a new directory.

### lock

From [The LuaFileSystem documentation](https://keplerproject.github.io/luafilesystem/manual.html#reference):

> Locks a file or a part of it. This function works on *open* files; the file handle should be specified as the first argument. The string mode could be either `r` (for a read/shared lock) or `w` (for a write/exclusive lock). The optional arguments `start` and `length` can be used to specify a starting point and its length; both should be numbers. Returns `true` if the operation was successful; in case of error, it returns `nil` plus an error string.

### unlock

From [The LuaFileSystem documentation](https://keplerproject.github.io/luafilesystem/manual.html#reference):

> Unlocks a file or a part of it. This function works on *open* files; the file handle should be specified as the first argument. The optional arguments start and length can be used to specify a starting point and its length; both should be numbers. Returns `true` if the operation was successful; in case of error, it returns nil plus an error string.

### lockDir

From [The LuaFileSystem documentation](https://keplerproject.github.io/luafilesystem/manual.html#reference):

> Creates a lockfile (called `lockfile.lfs`) in path if it does not exist and returns the lock. If the lock already exists checks if it's stale, using the second parameter (default for the second parameter is `INT_MAX`, which in practice means the lock will never be stale. To free the the lock call `lock:free()`. In case of any errors it returns `nil` and the error message. In particular, if the lock exists and is not stale it returns the "File exists" message.

### setMode

From [The LuaFileSystem documentation](https://keplerproject.github.io/luafilesystem/manual.html#reference):

> Sets the writing mode for a file. The mode string can be either `"binary"` or `"text"`. Returns `true` followed the previous mode string for the file, or `nil` followed by an error string in case of errors. On non-Windows platforms, where the two modes are identical, setting the mode has no effect, and the mode is always returned as `binary`.

## Attributes

Functions which get attributes from paths.

### getPermissions

Gets the permissions of a file as a table. The table has a structure like this:

```moon
{
  owner = { read = true, write = true,  execute = false },
  group = { read = true, write = false, execute = false },
  world = { read = true, write = false, execute = false }
}
```

### getOctalPermissions

Gets the permissions of a file as an octal number.

### touch

Sets the access and modification times of a file.

```moon
touch ("path", atime, mtime)
```

## Globbing

Globs are components of a path such as `*`, `?` and `**` that are treated as wildcards. For a more in-depth explanation of how globbing works, please visit [this page](globbing.md)

### fromGlob

Turns a path with globs into a Lua pattern.

### matchGlob

**Alias:** `testGlob`

TODO: glob should be precompiled

Checks whether a glob matches a path.

```lua
fs.matchGlob("a/*", "a/test.txt") --> true
```

## Lists

Lists, lists, lists!

### list

Returns a list of all files and subdirectories (but not their contents) in the specified directory, as a numerically indexed table.

### list1

Equivalent to [`list`](#list), but it excludes `..`.

### ilist

An iterator of [`list`](#list).

```lua
for file in fs.ilist(fs.currentDir()) do
  print(file)
end
```

### ilist1

[`ilist`](#ilist), but excluding `..`.

### listAll

Lists all nodes in a directory recursively.

```lua
fs.listAll(fs.currentDir())
--> .../rockspecs
--> .../rockspecs/filekit-1.4-1.rockspec
--> .../Alfons.moon
--> ...
```

### glob

Returns a list of all paths in the current directory that match the glob passed to it.

### iglob

An iterator version of [`glob`](#glob).

### find

[`glob`](#glob), but recursive.

## Checks

### exists

Checks if a path exists or not.

### isDir

Returns `true` if the path is a directory.

### isFile

Returns `true` if the path is a file.

### isLink

Returns `true` if the path is a link.

### isSocket

Returns `true` if the path is a socket.

### isPipe

Returns `true` if the path is a pipe.

### isCharDevice

Returns `true` if the path is a char device.

### isBlockDevice

Returns `true` if the path is a block device.

### isOther

Returns `true` if the path is none of the above.

### isReadOnly

Returns `true` if the path is readonly.

### isEmpty

Returns `true` if a directory is empty.