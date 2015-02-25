gulp= require 'gulp'
gutil= require 'gulp-util'

gulp.task 'default',->
  gulp.start 'testWaiting'
  gulp.watch ['lib/*.coffee','test/index.*'],->
    gulp.start 'testWaiting'

gulp.task 'test',(callback)->
  spawn= require('child_process').spawn
  nw= null
  nw= spawn 'npm',['test'],stdio:'inherit'
  nw.on 'close',->
    console.log ''
    gutil.log 'closed nw-jasmine'
    callback()

gulp.task 'testWaiting',['test'],->
  gutil.log 'Waiting for file changes before test...'

gulp.task 'build',(done)->
  name= require('./package.json').name
  source= require 'vinyl-source-stream'
  browserify= require 'browserify'

  browserify
    entries: './lib'
    extensions: '.coffee'
    transform: ['coffeeify']
    standalone: 'window'# window.window = immutable
  .bundle()
  .pipe source "#{name}.js"
  .pipe gulp.dest '.'
  # .on 'end',->
  #   path= require 'path'
  #   uglifyjs= "node "+ path.resolve require.resolve('uglify-js'),'../../bin/uglifyjs'

  #   exec= require('child_process').exec
  #   script= "#{uglifyjs} #{name}.js -o #{name}.min.js"
  #   script+= " --source-map #{name}.min.js.map"
  #   script+= " -v"
  #   exec script,(stderr)->
  #     throw stderr if stderr?
  #     done()
  # return