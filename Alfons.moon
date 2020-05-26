tasks:
  compile:       => moonc "filekit.moon"
  docs:          => sh "ldoc ."
  release: (ver) => sh "rockbuild -m -t #{ver} u"
  make:    (ver) => sh "rockbuild -m --delete #{ver}"