tasks:
  compile: => moonc "filekit.moon"
  release: => sh "rockbuild -m -t #{@v} u"
  make:    => sh "rockbuild -m --delete #{@v}"
  docs:    =>
    sh "docsify serve docs" if uses "serve"