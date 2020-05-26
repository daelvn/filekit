local _VERSION = "1.4a"
if _HOST and fs then
  return fs
end
local lfs = require("lfs")
local _check
_check = function(f)
  return function(...)
    local args = {
      ...
    }
    for i, arg in ipairs(args) do
      assert(("string" == type(arg)), "argument #" .. tostring(i) .. " is not a string")
    end
    return f(...)
  end
end
local currentDir
currentDir = function()
  return lfs.currentdir()
end
local changeDir = _check(function(path)
  lfs.chdir(path)
  currentDir = path
end)
local getDevice = _check(function(path)
  return lfs.attributes(path, "dev")
end)
local getInode = _check(function(path)
  return lfs.attributes(path, "ino")
end)
local getMode = _check(function(path)
  return lfs.attributes(path, "mode")
end)
local getLinks = _check(function(path)
  return lfs.attributes(path, "nlinks")
end)
local getUID = _check(function(path)
  return lfs.attributes(path, "uid")
end)
local getGID = _check(function(path)
  return lfs.attributes(path, "gid")
end)
local getDeviceType = _check(function(path)
  return lfs.attributes(path, "rdev")
end)
local getLastAccess = _check(function(path)
  return lfs.attributes(path, "access")
end)
local getLastModification = _check(function(path)
  return lfs.attributes(path, "modification")
end)
local getLastChange = _check(function(path)
  return lfs.attributes(path, "change")
end)
local getPermissions = _check(function(path)
  local permstring = lfs.attributes(path, "permissions")
  local permissions = {
    owner = {
      read = false,
      write = false,
      execute = false
    },
    group = {
      read = false,
      write = false,
      execute = false
    },
    world = {
      read = false,
      write = false,
      execute = false
    }
  }
  if permstring:match("r........") then
    permissions.owner.read = true
  end
  if permstring:match(".w.......") then
    permissions.owner.write = true
  end
  if permstring:match("..x......") then
    permissions.owner.execute = true
  end
  if permstring:match("...r.....") then
    permissions.group.read = true
  end
  if permstring:match("....w....") then
    permissions.group.write = true
  end
  if permstring:match(".....x...") then
    permissions.group.execute = true
  end
  if permstring:match("......r..") then
    permissions.world.read = true
  end
  if permstring:match(".......w.") then
    permissions.world.write = true
  end
  if permstring:match("........x") then
    permissions.world.execute = true
  end
  return permissions
end)
local getOctalPermissions = _check(function(path)
  local permnum = 000
  local permstring = lfs.attributes(path, "permissions")
  if permstring:match("r........") then
    permnum = permnum + 400
  end
  if permstring:match(".w.......") then
    permnum = permnum + 200
  end
  if permstring:match("..x......") then
    permnum = permnum + 100
  end
  if permstring:match("...r.....") then
    permnum = permnum + 040
  end
  if permstring:match("....w....") then
    permnum = permnum + 020
  end
  if permstring:match(".....x...") then
    permnum = permnum + 010
  end
  if permstring:match("......r..") then
    permnum = permnum + 004
  end
  if permstring:match(".......w.") then
    permnum = permnum + 002
  end
  if permstring:match("........x") then
    permnum = permnum + 001
  end
  return permnum
end)
local getBlocks = _check(function(path)
  return lfs.attributes(path, "blocks")
end)
local getBlockSize = _check(function(path)
  return lfs.attributes(path, "blksize")
end)
local getLinkDevice = _check(function(path)
  return lfs.symlinkattributes(path, "dev")
end)
local getLinkInode = _check(function(path)
  return lfs.symlinkattributes(path, "ino")
end)
local getLinkMode = _check(function(path)
  return lfs.symlinkattributes(path, "mode")
end)
local getLinkLinks = _check(function(path)
  return lfs.symlinkattributes(path, "nlinks")
end)
local getLinkUID = _check(function(path)
  return lfs.symlinkattributes(path, "uid")
end)
local getLinkGID = _check(function(path)
  return lfs.symlinkattributes(path, "gid")
end)
local getLinkDeviceType = _check(function(path)
  return lfs.symlinkattributes(path, "rdev")
end)
local getLinkLastAccess = _check(function(path)
  return lfs.symlinkattributes(path, "access")
end)
local getLinkLastModification = _check(function(path)
  return lfs.symlinkattributes(path, "modification")
end)
local getLinkLastChange = _check(function(path)
  return lfs.symlinkattributes(path, "change")
end)
local getLinkPermissions = _check(function(path)
  local permstring = lfs.symlinkattributes(path, "permissions")
  local permissions = {
    owner = {
      read = false,
      write = false,
      execute = false
    },
    group = {
      read = false,
      write = false,
      execute = false
    },
    world = {
      read = false,
      write = false,
      execute = false
    }
  }
  if permstring:match("r........") then
    permissions.owner.read = true
  end
  if permstring:match(".w.......") then
    permissions.owner.write = true
  end
  if permstring:match("..x......") then
    permissions.owner.execute = true
  end
  if permstring:match("...r.....") then
    permissions.group.read = true
  end
  if permstring:match("....w....") then
    permissions.group.write = true
  end
  if permstring:match(".....x...") then
    permissions.group.execute = true
  end
  if permstring:match("......r..") then
    permissions.world.read = true
  end
  if permstring:match(".......w.") then
    permissions.world.write = true
  end
  if permstring:match("........x") then
    permissions.world.execute = true
  end
end)
local getLinkOctalPermissions = _check(function(path)
  local permnum = 000
  local permstring = lfs.symlinkattributes(path, "permissions")
  if permstring:match("r........") then
    permnum = permnum + 400
  end
  if permstring:match(".w.......") then
    permnum = permnum + 200
  end
  if permstring:match("..x......") then
    permnum = permnum + 100
  end
  if permstring:match("...r.....") then
    permnum = permnum + 040
  end
  if permstring:match("....w....") then
    permnum = permnum + 020
  end
  if permstring:match(".....x...") then
    permnum = permnum + 010
  end
  if permstring:match("......r..") then
    permnum = permnum + 004
  end
  if permstring:match(".......w.") then
    permnum = permnum + 002
  end
  if permstring:match("........x") then
    permnum = permnum + 001
  end
  return permnum
end)
local getLinkBlocks = _check(function(path)
  return lfs.symlinkattributes(path, "blocks")
end)
local getLinkBlockSize = _check(function(path)
  return lfs.symlinkattributes(path, "blksize")
end)
local list = _check(function(path)
  return (function()
    local _accum_0 = { }
    local _len_0 = 1
    for v in lfs.dir(path) do
      _accum_0[_len_0] = v
      _len_0 = _len_0 + 1
    end
    return _accum_0
  end)()
end)
local ilist = _check(function(path)
  local files = list(path)
  local i = 0
  local n = #files
  return function()
    i = i + 1
    if i <= n then
      return files[i]
    end
  end
end)
local list1 = _check(function(path)
  local _accum_0 = { }
  local _len_0 = 1
  local _list_0 = list(path)
  for _index_0 = 1, #_list_0 do
    local file = _list_0[_index_0]
    if (file ~= "..") and (file ~= ".") then
      _accum_0[_len_0] = file
      _len_0 = _len_0 + 1
    end
  end
  return _accum_0
end)
local ilist1 = _check(function(path)
  local files = list1(path)
  local i = 0
  local n = #files
  return function()
    i = i + 1
    if i <= n then
      return files[i]
    end
  end
end)
local safeOpen
safeOpen = function(path, mode)
  local a, b = io.open(path, mode)
  return a and a or {
    error = b
  }
end
local exists = _check(function(path)
  do
    local _with_0 = safeOpen(path, "rb")
    if _with_0.close then
      _with_0:close()
      return true
    else
      return false, _with_0.error
    end
    return _with_0
  end
end)
local isDir = _check(function(path)
  if not (exists(path)) then
    local _ = false
  end
  return (lfs.attributes(path, "mode")) == "directory"
end)
local isFile = _check(function(path)
  if not (exists(path)) then
    local _ = false
  end
  return (lfs.attributes(path, "mode")) == "file"
end)
local isLink = _check(function(path)
  if not (exists(path)) then
    local _ = false
  end
  return (lfs.attributes(path, "mode")) == "link"
end)
local isSocket = _check(function(path)
  if not (exists(path)) then
    local _ = false
  end
  return (lfs.attributes(path, "mode")) == "socket"
end)
local isPipe = _check(function(path)
  if not (exists(path)) then
    local _ = false
  end
  return (lfs.attributes(path, "mode")) == "pipe"
end)
local isCharDevice = _check(function(path)
  if not (exists(path)) then
    local _ = false
  end
  return (lfs.attributes(path, "mode")) == "char device"
end)
local isBlockDevice = _check(function(path)
  if not (exists(path)) then
    local _ = false
  end
  return (lfs.attributes(path, "mode")) == "block device"
end)
local isOther = _check(function(path)
  if not (exists(path)) then
    local _ = false
  end
  return (lfs.attributes(path, "mode")) == "other"
end)
local isReadOnly = _check(function(path)
  if not (exists(path)) then
    error("isReadOnly $ " .. tostring(path) .. " does not exist")
  end
  return (lfs.attributes(path, "permissions")):match("w") and false or true
end)
local getName = _check(function(path)
  return path:match("/([^/]-)$")
end)
local getDrive = _check(function(path)
  return nil
end)
local getSize = _check(function(path)
  return lfs.attributes(path, "size")
end)
local getLinkSize = _check(function(path)
  return lfs.symlinkattributes(path, "size")
end)
local getFreeSpace = _check(function(path)
  return 0
end)
local makeDir = lfs.mkdir
local move = os.rename
local combine = _check(function(basePath, localPath)
  do
    local _with_0 = basePath .. localPath
    if (not basePath:match("/$")) and (not localPath:match("^/")) then
      _with_0 = basePath .. "/" .. localPath
    else
      _with_0 = _with_0:gsub("//", "/")
    end
    return _with_0
  end
end)
local filecopy = _check(function(fr, to)
  if not (exists(fr)) then
    error("copy $ " .. tostring(fr) .. " does not exist")
  end
  do
    local _with_0 = assert((io.open(fr, "rb")), "copy $ could not open " .. tostring(fr) .. " in 'rb' mode")
    local contents = _with_0:read("*a")
    do
      local _with_1 = assert((io.open(to, "wb")), "copy $ could not create " .. tostring(to) .. " in 'wb' mode")
      _with_1:write(contents)
      _with_1:close()
    end
    _with_0:close()
    return _with_0
  end
end)
local copy
copy = _check(function(fr, to)
  if not (exists(fr)) then
    error("copy $ " .. tostring(fr) .. " does not exist")
  end
  if isDir(fr) then
    if exists(to) then
      error("copy $ " .. tostring(to) .. " already exists")
    end
    makeDir(to)
    for node in ilist1(fr) do
      copy((combine(fr, node)), (combine(to, node)))
    end
  elseif isFile(fr) then
    return filecopy(fr, to)
  end
end)
local isEmpty
isEmpty = function(path)
  if not (exists(path)) then
    error("isEmpty $ " .. tostring(path) .. " does not exist")
  end
  if not (isDir(path)) then
    return false
  end
  return 0 == #(list1(path))
end
local delete
delete = function(path)
  if not (exists(path)) then
    return 
  end
  if isFile(path or isEmpty(path)) then
    return os.remove(path)
  else
    for node in ilist1(path) do
      delete(combine(path, node))
    end
    return os.remove(path)
  end
end
local remove = delete
local open = io.open
local listAll
listAll = function(path, all)
  if all == nil then
    all = { }
  end
  for node in ilist1(path) do
    local fullnode = combine(path, node)
    table.insert(all, fullnode)
    if isDir(fullnode) then
      listAll(fullnode, all)
    end
  end
  return all
end
local find
find = function(wildcard, base, results)
  if base == nil then
    base = ""
  end
  if results == nil then
    results = { }
  end
  wildcard = wildcard:gsub("%*", "(.-)")
  local listing = list1(currentDir())
  for _index_0 = 1, #listing do
    local item = listing[_index_0]
    if (base .. item):match(wildcard) then
      table.insert(results, base .. item)
    end
    if isDir(item) then
      local subresults = find(wildcard, base .. item, results)
      for _index_1 = 1, #subresults do
        local subitem = subresults[_index_1]
        table.insert(results, subitem)
      end
    end
  end
  return results
end
local getDir = _check(function(path)
  return path:match("^.+/")
end)
local link
link = function(fr, to)
  return lfs.link(fr, to, false)
end
local symlink
symlink = function(fr, to)
  return lfs.link(fr, to, true)
end
local touch
touch = function(path, atime, mtime)
  if atime == nil then
    atime = os.time()
  end
  if mtime == nil then
    mtime = (atime or os.time())
  end
  return lfs.touch(path, atime, mtime)
end
local lockDir
lockDir = function(path, stale)
  return lfs.lock_dir(path, stale)
end
local lock
lock = function(file, exclusive, start, length)
  if exclusive == nil then
    exclusive = false
  end
  return lfs.lock(file, exclusive, start, length)
end
local unlock
unlock = function(file, start, length)
  return lfs.unlock(file, start, length)
end
local setMode
setMode = function(file, mode)
  return lfs.setmode(file, mode)
end
local reduce
reduce = function(path)
  local isroot, isdir = (path:match("^/")), (path:match("/$"))
  local parts
  do
    local _accum_0 = { }
    local _len_0 = 1
    for part in path:gmatch("[^/]+") do
      _accum_0[_len_0] = part
      _len_0 = _len_0 + 1
    end
    parts = _accum_0
  end
  if #parts == 1 then
    return path
  end
  local final = { }
  for _index_0 = 1, #parts do
    local _continue_0 = false
    repeat
      local part = parts[_index_0]
      if part == "." then
        _continue_0 = true
        break
      elseif part == ".." then
        if final[#final] then
          final[#final] = nil
        end
      else
        final[#final + 1] = part
      end
      _continue_0 = true
    until true
    if not _continue_0 then
      break
    end
  end
  local f = table.concat(final, "/")
  if isroot then
    f = "/" .. f
  end
  if isdir then
    f = f .. "/"
  end
  return f
end
local fromGlob
fromGlob = function(glob)
  local sanitize
  sanitize = function(pattern)
    if pattern then
      return pattern:gsub("[%(%)%.%%%+%-%*%?%[%]%^%$]", "%%%0")
    end
  end
  local saglob = sanitize(glob)
  do
    local _with_0 = saglob
    local mid = _with_0:gsub("%%%*%%%*", ".*")
    mid = mid:gsub("%%%*", "[^/]*")
    mid = mid:gsub("%%%?", ".")
    return tostring(mid) .. "$"
  end
end
local matchGlob
matchGlob = function(glob, path)
  return nil ~= path:match(glob)
end
local glob
glob = function(path, all)
  if all == nil then
    all = { }
  end
  if not (path:match("%*")) then
    return path
  end
  local currentpath = currentDir()
  local fullpath = reduce(combine(currentpath, path))
  local correctpath = ""
  for i = 1, #fullpath do
    if (fullpath:sub(i, i)) == (currentpath:sub(i, i)) then
      correctpath = correctpath .. currentpath:sub(i, i)
    end
  end
  local toglob = fromGlob(fullpath)
  local _list_0 = listAll(correctpath)
  for _index_0 = 1, #_list_0 do
    local node = _list_0[_index_0]
    if node:match(toglob) then
      table.insert(all, node)
    end
  end
  return all
end
local iglob
iglob = function(path)
  local globbed = glob(path)
  local i = 0
  local n = #globbed
  return function()
    i = i + 1
    if i <= n then
      return globbed[i]
    end
  end
end
return {
  currentDir = currentDir,
  changeDir = changeDir,
  getDir = getDir,
  getBlockSize = getBlockSize,
  getBlocks = getBlocks,
  getOctalPermissions = getOctalPermissions,
  getDevice = getDevice,
  getDeviceType = getDeviceType,
  getDrive = getDrive,
  getFreeSpace = getFreeSpace,
  getUID = getUID,
  getGID = getGID,
  getInode = getInode,
  getLastAccess = getLastAccess,
  getLastChange = getLastChange,
  getLastModification = getLastModification,
  getLinks = getLinks,
  getMode = getMode,
  getName = getName,
  getPermissions = getPermissions,
  getSize = getSize,
  exists = exists,
  list = list,
  isReadOnly = isReadOnly,
  ilist = ilist,
  list1 = list1,
  ilist1 = ilist1,
  listAll = listAll,
  fromGlob = fromGlob,
  matchGlob = matchGlob,
  glob = glob,
  iglob = iglob,
  reduce = reduce,
  isDir = isDir,
  isFile = isFile,
  isEmpty = isEmpty,
  isBlockDevice = isBlockDevice,
  isCharDevice = isCharDevice,
  isSocket = isSocket,
  isPipe = isPipe,
  isLink = isLink,
  isOther = isOther,
  makeDir = makeDir,
  move = move,
  copy = copy,
  remove = remove,
  delete = delete,
  combine = combine,
  open = open,
  find = find,
  link = link,
  symlink = symlink,
  touch = touch,
  lockDir = lockDir,
  lock = lock,
  unlock = unlock,
  setMode = setMode,
  getLinkBlockSize = getLinkBlockSize,
  getLinkBlocks = getLinkBlocks,
  getLinkOctalPermissions = getLinkOctalPermissions,
  getLinkDevice = getLinkDevice,
  getLinkDeviceType = getLinkDeviceType,
  getLinkUID = getLinkUID,
  getLinkGID = getLinkGID,
  getLinkInode = getLinkInode,
  getLinkLastAccess = getLinkLastAccess,
  getLinkLastChange = getLinkLastChange,
  getLinkLastModification = getLinkLastModification,
  getLinkLinks = getLinkLinks,
  getLinkMode = getLinkMode,
  getLinkPermissions = getLinkPermissions,
  getLinkSize = getLinkSize,
  safeOpen = safeOpen,
  _VERSION = _VERSION
}
