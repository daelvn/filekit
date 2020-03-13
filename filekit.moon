--- Wrapper around [LuaFileSystem](http://keplerproject.github.io/luafilesystem) along with other functions.
-- The objective of this is really just simplifying the methods used by lfs and collect other methods.
-- It also incorporates compatibility with the [ComputerCraft FS API](http://computercraft.info/wiki/Fs_(API))
-- @module filekit
-- @author daelvn
-- @copyright 11.07.2019

-- If we're on ComputerCraft, just return the FS API.
return fs if _HOST and fs

-- Require LuaFileSystem
lfs = require "lfs"

-- Helper function to check that all arguments passed are strings
_check = (f) -> (...) ->
  args = {...}
  for i, arg in ipairs args do assert ("string" == type arg), "argument ##{i} is not a string"
  f ...

--- Represents the current working directory
currentDir = -> lfs.currentdir!

--- Changes the current working directory
-- @tparam string path Changes the CWD to this path.
-- @treturn nil
changeDir = _check (path) ->
  lfs.chdir    path
  currentDir = path

--- Gets the device of the inode.
-- @tparam string path Path.
-- @treturn number Device number.
getDevice = _check (path) -> lfs.attributes path, "dev"

--- Gets the inode of a file or folder.
-- @tparam string path Path.
-- @treturn number Inode number.
getInode = _check (path) -> lfs.attributes path, "ino"

--- Gets the mode of a node.
-- @tparam string path Path.
-- @treturn string Mode.
getMode = _check (path) -> lfs.attributes path, "mode"

--- Gets the number of hard links to the file.
-- @tparam string path Path.
-- @treturn number Number of hard links.
getLinks = _check (path) -> lfs.attributes path, "nlinks"

--- Gets the user ID of the owner. Always 0 on Windows.
-- @tparam string path Path.
-- @treturn number User ID.
getUID = _check (path) -> lfs.attributes path, "uid"

--- Gets the group ID of the owner. Always 0 on Windows.
-- @tparam string path Path.
-- @treturn number Group ID.
getGID = _check (path) -> lfs.attributes path, "gid"

--- On Unix systems, gets the device type, for special file inodes. On Windows systems it equals `getDevice path`.
-- @tparam string path Path.
-- @treturn number Device type.
getDeviceType = _check (path) -> lfs.attributes path, "rdev"

--- Gets the timestamp of last access.
-- @tparam string path Path.
-- @treturn number Last access time.
getLastAccess = _check (path) -> lfs.attributes path, "access"

--- Gets the timestamp of the last modification.
-- @tparam string path Path.
-- @treturn number Last modification time.
getLastModification = _check (path) -> lfs.attributes path, "modification"

--- Gets the timestamp of the last status change.
-- @tparam string path Path.
-- @treturn number Last status change time.
getLastChange = _check (path) -> lfs.attributes path, "change"

--- Gets the permissions as a table.
-- @tparam string path Path.
-- @treturn table Permissions table.
-- @usage
--   print inspect getPermissions "main.moon"
--   -- {
--   --   owner = { read = true, write = true,  execute = false },
--   --   group = { read = true, write = false, execute = false },
--   --   world = { read = true, write = false, execute = false }
--   -- }
getPermissions = _check (path) ->
  permstring  = lfs.attributes path, "permissions"
  permissions =
    owner: { read: false, write: false, execute: false }
    group: { read: false, write: false, execute: false }
    world: { read: false, write: false, execute: false }
  permissions.owner.read    = true if permstring\match "r........"
  permissions.owner.write   = true if permstring\match ".w......."
  permissions.owner.execute = true if permstring\match "..x......"
  permissions.group.read    = true if permstring\match "...r....."
  permissions.group.write   = true if permstring\match "....w...."
  permissions.group.execute = true if permstring\match ".....x..."
  permissions.world.read    = true if permstring\match "......r.."
  permissions.world.write   = true if permstring\match ".......w."
  permissions.world.execute = true if permstring\match "........x"
  permissions

--- Gets the permissions as an octal number.
-- @tparam string path Path.
-- @treturn number Permission number.
getOctalPermissions = _check (path) ->
  permnum    = 000
  permstring = lfs.attributes path, "permissions"
  permnum += 400 if permstring\match "r........"
  permnum += 200 if permstring\match ".w......."
  permnum += 100 if permstring\match "..x......"
  permnum += 040 if permstring\match "...r....."
  permnum += 020 if permstring\match "....w...."
  permnum += 010 if permstring\match ".....x..."
  permnum += 004 if permstring\match "......r.."
  permnum += 002 if permstring\match ".......w."
  permnum += 001 if permstring\match "........x"
  permnum

--- Get the blocks allocated for file (unix only)
-- @tparam string path Path.
-- @treturn number Number of blocks allocated.
getBlocks = _check (path) -> lfs.attributes path, "blocks"

--- Get the optimal filesystem blocksize (unix only)
-- @tparam string path Path.
-- @treturn number Optimal size in bytes.
getBlockSize = _check (path) -> lfs.attributes path, "blksize"

--- Gets the device of the inode (for links).
-- @tparam string path Path to the link.
-- @treturn number Device number.
getLinkDevice = _check (path) -> lfs.symlinkattributes path, "dev"

--- Gets the inode of a link.
-- @tparam string path Path to the link.
-- @treturn number Inode number.
getLinkInode = _check (path) -> lfs.symlinkattributes path, "ino"

--- Gets the mode of a link.
-- @tparam string path Path to the link.
-- @treturn string Mode.
getLinkMode = _check (path) -> lfs.symlinkattributes path, "mode"

--- Gets the number of hard links to the link.
-- @tparam string path Path to the link.
-- @treturn number Number of hard links.
getLinkLinks = _check (path) -> lfs.symlinkattributes path, "nlinks"

--- Gets the user ID of the owner. Always 0 on Windows.
-- @tparam string path Path to the link.
-- @treturn number User ID.
getLinkUID = _check (path) -> lfs.symlinkattributes path, "uid"

--- Gets the group ID of the owner. Always 0 on Windows.
-- @tparam string path Path to the link.
-- @treturn number Group ID.
getLinkGID = _check (path) -> lfs.symlinkattributes path, "gid"

--- On Unix systems, getLinks the device type, for special link inodes. On Windows systems it equals `getLinkDevice path`.
-- @tparam string path Path to the link.
-- @treturn number Device type.
getLinkDeviceType = _check (path) -> lfs.symlinkattributes path, "rdev"

--- Gets the timestamp of last access.
-- @tparam string path Path to the link.
-- @treturn number Last access time.
getLinkLastAccess = _check (path) -> lfs.symlinkattributes path, "access"

--- Gets the timestamp of the last modification.
-- @tparam string path Path to the link.
-- @treturn number Last modification time.
getLinkLastModification = _check (path) -> lfs.symlinkattributes path, "modification"

--- Gets the timestamp of the last status change.
-- @tparam string path Path to the link.
-- @treturn number Last status change time.
getLinkLastChange = _check (path) -> lfs.symlinkattributes path, "change"

--- Gets the permissions as a table.
-- @tparam string path Path to the link.
-- @treturn table Permissions table.
-- @usage
--   print inspect getLinkPermissions "main.lnk.moon"
--   -- {
--   --   owner = { read = true, write = true,  execute = false },
--   --   group = { read = true, write = false, execute = false },
--   --   world = { read = true, write = false, execute = false }
--   -- }
getLinkPermissions = _check (path) ->
  permstring  = lfs.symlinkattributes path, "permissions"
  permissions =
    owner: { read: false, write: false, execute: false }
    group: { read: false, write: false, execute: false }
    world: { read: false, write: false, execute: false }
  permissions.owner.read    = true if permstring\match "r........"
  permissions.owner.write   = true if permstring\match ".w......."
  permissions.owner.execute = true if permstring\match "..x......"
  permissions.group.read    = true if permstring\match "...r....."
  permissions.group.write   = true if permstring\match "....w...."
  permissions.group.execute = true if permstring\match ".....x..."
  permissions.world.read    = true if permstring\match "......r.."
  permissions.world.write   = true if permstring\match ".......w."
  permissions.world.execute = true if permstring\match "........x"

--- Gets the permissions as an octal number.
-- @tparam string path Path to the link.
-- @treturn number Permission number.
getLinkOctalPermissions = _check (path) ->
  permnum    = 000
  permstring = lfs.symlinkattributes path, "permissions"
  permnum += 400 if permstring\match "r........"
  permnum += 200 if permstring\match ".w......."
  permnum += 100 if permstring\match "..x......"
  permnum += 040 if permstring\match "...r....."
  permnum += 020 if permstring\match "....w...."
  permnum += 010 if permstring\match ".....x..."
  permnum += 004 if permstring\match "......r.."
  permnum += 002 if permstring\match ".......w."
  permnum += 001 if permstring\match "........x"
  permnum

--- Get the blocks allocated for link (unix only)
-- @tparam string path Path to the link.
-- @treturn number Number of blocks allocated.
getLinkBlocks = _check (path) -> lfs.symlinkattributes path, "blocks"

--- Get the optimal linksystem blocksize (unix only)
-- @tparam string path Path to the link.
-- @treturn number Optimal size in bytes.
getLinkBlockSize = _check (path) -> lfs.symlinkattributes path, "blksize"

--- Returns a list of all the files (including subdirectories but not their contents) contained in a directory, as a numerically indexed table.
-- @tparam string path Path of the folder.
-- @treturn table Table of all the subnodes.
list = _check (path) -> return for v in lfs.dir path do v

--- List iterator (as lfs.dir)
-- @tparam string path Path of the folder.
-- @treturn function Iterator
ilist = _check (path) ->
  files = list path
  i     = 0
  n     = #files
  return ->
    i += 1
    if i <= n then return files[i]

--- Returns a list of all the files (including subdirectories), excluding .. and .
-- @tparam string path Path of the folder.
-- @treturn table Table of all the subnodes.
list1 = _check (path) -> [file for file in *list path when (file != "..") and (file != ".")]

--- List iterator (as lfs.dir) using list1
-- @tparam string path Path of the folder.
-- @treturn function Iterator
ilist1 = _check (path) ->
  files = list1 path
  i     = 0
  n     = #files
  return ->
    i += 1
    if i <= n then return files[i]

--- Returns a file handle, or if errored, a table with a field `error` that contains the error.
-- @tparam string path Path to the file.
-- @tparam string mode Mode to open the file in.
-- @treturn File|table Either a file or a table containing `error`.
safeOpen = (path, mode) ->
  a, b = io.open path, mode
  return a and a or {error: b}

--- Checks if a path refers to an existing file or directory.
-- @tparam string path Path to check.
-- @treturn boolean Whether it exists or not.
exists = _check (path) -> with safeOpen path, "rb"
  if .close
    \close!
    return true
  else return false, .error

--- Checks if a path refers to an existing directory.
-- @tparam string path Path to check.
-- @treturn boolean Whether it is a directory or not.
isDir = _check (path) ->
  false unless exists path
  (lfs.attributes path, "mode") == "directory"

--- Checks if a path refers to an existing file.
-- @tparam string path Path to check.
-- @treturn boolean Whether it is a file or not.
isFile = _check (path) ->
  false unless exists path
  (lfs.attributes path, "mode") == "file"

--- Checks if a path refers to an existing link.
-- @tparam string path Path to check.
-- @treturn boolean Whether it is a link or not.
isLink = _check (path) ->
  false unless exists path
  (lfs.attributes path, "mode") == "link"

--- Checks if a path refers to an existing socket.
-- @tparam string path Path to check.
-- @treturn boolean Whether it is a socket or not.
isSocket = _check (path) ->
  false unless exists path
  (lfs.attributes path, "mode") == "socket"

--- Checks if a path refers to an existing pipe.
-- @tparam string path Path to check.
-- @treturn boolean Whether it is a pipe or not.
isPipe = _check (path) ->
  false unless exists path
  (lfs.attributes path, "mode") == "pipe"

--- Checks if a path refers to an existing char device.
-- @tparam string path Path to check.
-- @treturn boolean Whether it is a char device or not.
isCharDevice = _check (path) ->
  false unless exists path
  (lfs.attributes path, "mode") == "char device"

--- Checks if a path refers to an existing block device.
-- @tparam string path Path to check.
-- @treturn boolean Whether it is a block device or not.
isBlockDevice = _check (path) ->
  false unless exists path
  (lfs.attributes path, "mode") == "block device"

--- Checks if a path refers to an existing node that is none of the other types.
-- @tparam string path Path to check.
-- @treturn boolean Whether it is `other` or not.
isOther = _check (path) ->
  false unless exists path
  (lfs.attributes path, "mode") == "other"

--- Checks if a path is read-only (i.e. cannot be modified).
-- On non CC systems, it checks whether there's an "w" in the permissions string only, so don't rely too much on this.
-- @tparam string path Path to check.
-- @treturn boolean Whether it is readonly or not.
isReadOnly = _check (path) ->
  error "isReadOnly $ #{path} does not exist" unless exists path
  return (lfs.attributes path, "permissions")\match"w" and false or true

--- Gets the final component of a pathname.
-- @tparam string path Path to extract the filename from.
-- @treturn string The final part of the path.
getName = _check (path) -> path\match "/([^/]-)$"

--- Gets the storage medium holding a path, or nil if the path does not exist.
-- This function is a stub and will always return nil. There's no simple way of knowing this.
-- @tparam string path Path to extract the mountpoint from.
-- @treturn string|nil Mountpoint.
getDrive = _check (path) -> nil

--- Gets the size of a file in bytes.
-- @tparam string path Path of the file.
-- @treturn number Size in bytes.
getSize = _check (path) -> lfs.attributes path, "size"

--- Gets the size of a link in bytes.
-- @tparam string path Path of the link.
-- @treturn number Size in bytes.
getLinkSize = _check (path) -> lfs.symlinkattributes path, "size"

--- Gets the remaining space on the drive containing the given directory.
-- This function is a stub and will always return 0. There's no simple way of knowing this.
-- @tparam string path Path to check.
-- @treturn number Space left in bytes.
getFreeSpace = _check (path) -> 0

--- Makes a directory.
-- @tparam string path Path of the new directory.
-- @treturn nil
makeDir = lfs.mkdir

--- Moves a file or directory to a new location.
-- @tparam string path Path of the old location.
-- @tparam string path Path of the new location.
-- @treturn nil
move = os.rename

--- Copies a file or directory to a new location.
-- @tparam string path Path of the old location.
-- @tparam string path Path of the new location.
-- @treturn nil
copy = _check (fr, to) ->
  error "copy $ #{fr} does not exist" unless exists fr
  with assert (io.open fr, "rb"), "copy $ could not open #{fr} in 'rb' mode"
    contents = \read "*a"
    with assert (io.open to, "wb"), "copy $ could not create #{to} in 'wb' mode"
      \write contents
      \close!
    \close!

--- Deletes a file or directory.
-- Alias: `remove`
-- @tparam string path Path to delete.
-- @treturn nil
delete = os.remove
remove = delete

--- Combines two path components, returning a path consisting of the local path nested inside the base path.
-- @tparam string basePath Path which contains the local path.
-- @tparam string localPath Contained path.
-- @treturn string Combined path.
combine = _check (basePath, localPath) -> return with basePath .. localPath
  if (not basePath\match "/$") and (not localPath\match "^/")
    _with_0 = basePath .. "/" .. localPath
  else
    _with_0 = \gsub "//", "/"

--- Opens a file so it can be read or written.
-- @tparam string path Path to open.
-- @tparam string mode Mode to open the path with.
-- @treturn File File handle.
open = io.open

--- Lists all nodes in a directory recursively
-- @tparam string path Path to recurse
-- @treturn table List of nodes
listAll = (path, all={}) ->
  for node in ilist1 path
    fullnode = combine path, node
    table.insert all, fullnode
    if isDir fullnode
      listAll fullnode, all
  all

--- Searches the computer's files using wildcards.
-- On non CC systems, it only looks recursively in the current directory.
-- @tparam string wildcard Wildcard to match.
-- @treturn table Table of results.
find = (wildcard, base="", results={}) ->
  wildcard = wildcard\gsub "%*", "(.-)"
  listing  = list1 currentDir!
  for item in *listing
    table.insert results, base..item if (base..item)\match wildcard
    if isDir item
      subresults = find wildcard, base..item, results
      for subitem in *subresults do table.insert results, subitem
  results

--- Returns the parent directory of path.
-- @tparam string path Path.
-- @treturn string Parent path.
getDir = _check (path) -> path\match "^.+/"

--- Creates a hard link.
-- @tparam string fr Base link.
-- @tparam string to Target link.
-- @treturn nil
link = (fr, to) -> lfs.link fr, to, false

--- Creates a symbolic link.
-- @tparam string fr Base link.
-- @tparam string to Target link.
-- @treturn nil
symlink = (fr, to) -> lfs.link fr, to, true

--- Set access and modification times of a file.
-- The times should be in seconds and generated with `os.time`.
-- @tparam string path Path to the file.
-- @tparam number atime Access time (defaults to current time).
-- @tparam number mtime Modification time (defaults to `atime` or current time`).
-- @treturn true|nil Whether it was successful or not.
-- @treturn string|nil If not successful, an error message.
touch = (path, atime=os.time!, mtime=(atime or os.time!)) -> lfs.touch path, atime, mtime

--- Locks a directory.
-- @tparam string path Path to the directory.
-- @tparam number stale Seconds until the lock is stale. Defaults to `INT_MAX`.
-- @treturn Lock|nil LuaFileSystem lock.
-- @treturn string|nil If not successful, an error message.
lockDir = (path, stale) -> lfs.lock_dir path, stale

--- Locks a file handle.
-- @tparam File file File handle.
-- @tparam boolean exclusive Whether to lock exclusively or not. Defaults to false.
-- @tparam number start Starting point of the lock. Defaults to 0.
-- @tparam number length Length of the lock. Defaults to whole file.
-- @treturn true|nil Whether it was successful or not.
-- @treturn string|nil If not successful, the error message.
lock = (file, exclusive=false, start, length) -> lfs.lock file, exclusive, start, length

--- Unocks a file handle.
-- @tparam File file File handle.
-- @tparam number start Starting point of the lock. Defaults to 0.
-- @tparam number length Length of the lock. Defaults to whole file.
-- @treturn true|nil Whether it was successful or not.
-- @treturn string|nil If not successful, the error message.
unlock = (file, start, length) -> lfs.unlock file, start, length

--- Sets the writing mode for a file handle.
-- @tparam File file File handle.
-- @tparam string mode "binary" or "text".
-- @treturn string|nil Previous mode for the file.
-- @treturn string|nil If not successful, an error message.
setMode = (file, mode) -> lfs.setmode file, mode

-- Reduces .. and . in paths
-- @tparam string path Path with .. or .
-- @treturn string Simplified path
reduce = (path) ->
  isroot, isdir = (path\match "^/"), (path\match "/$")
  parts         = [part for part in path\gmatch "[^/]+"]
  if #parts == 1
    return path
  final = {}
  for part in *parts
    if part == "."
      continue
    elseif part == ".."
      if final[#final]
        final[#final] = nil
    else
      final[#final+1] = part
  f = table.concat final, "/"
  f = "/" .. f if isroot
  f = f .. "/" if isdir
  return f

-- Turns a glob into a Lua pattern
-- @tparam string glob Path with globs
-- @treturn string Lua pattern
fromGlob = (glob) ->
  sanitize = (pattern) -> pattern\gsub "[%(%)%.%%%+%-%*%?%[%]%^%$]", "%%%0" if pattern
  saglob   = sanitize glob
  with saglob
    mid = \gsub "%%%*%%%*", ".*"
    mid = mid\gsub "%%%*",     "[^/]*"
    mid = mid\gsub "%%%?",     "."
    return "#{mid}$"

--- Matches a compiled glob with a string
-- @tparam string glob Compiled glob
-- @tparam string path Path to compare to
-- @treturn boolean Whether it matches or not
matchGlob = (glob, path) -> nil != path\match glob

--- Returns a list of paths matched by the globs
-- @tparam string path Path with globs
-- @treturn table Table of globbed files
glob = (path, all={}) ->
  -- Return if there is nothing to glob
  return path unless path\match "%*"
  -- Get full paths
  currentpath = currentDir!
  fullpath    = reduce combine currentpath, path
  -- Create a correct listing
  correctpath = ""
  for i=1, #fullpath
    if (fullpath\sub i, i) == (currentpath\sub i, i)
      correctpath ..= currentpath\sub i, i
  -- Create glob
  toglob      = fromGlob fullpath
  -- Iterate files
  for node in *listAll correctpath
    --print node, toglob
    table.insert all, node if node\match toglob
  -- Return
  return all

--- Glob as an iterator
-- @tparam string path Path with globs
-- @treturn function Iterator
iglob = (path) ->
  globbed = glob path
  i       = 0
  n       = #globbed
  return ->
    i += 1
    if i <= n then return globbed[i]

{
  :currentDir, :changeDir, :getDir, :getBlockSize, :getBlocks, :getOctalPermissions, :getDevice, :getDeviceType, :getDrive, :getFreeSpace, :getUID, :getGID
  :getInode, :getLastAccess, :getLastChange, :getLastModification, :getLinks, :getMode, :getName, :getPermissions, :getSize, :exists, :list, :isReadOnly
  :ilist, :list1, :ilist1, :listAll, :fromGlob, :matchGlob, :glob, :iglob, :reduce
  :isDir, :isFile, :isBlockDevice, :isCharDevice, :isSocket, :isPipe, :isLink, :isOther, :makeDir, :move, :copy, :remove, :delete, :combine, :open, :find
  :link, :symlink, :touch, :lockDir, :lock, :unlock, :setMode
  :getLinkBlockSize, :getLinkBlocks, :getLinkOctalPermissions, :getLinkDevice, :getLinkDeviceType, :getLinkUID, :getLinkGID, :getLinkInode, :getLinkLastAccess
  :getLinkLastChange, :getLinkLastModification, :getLinkLinks, :getLinkMode, :getLinkPermissions, :getLinkSize
  :safeOpen
}
