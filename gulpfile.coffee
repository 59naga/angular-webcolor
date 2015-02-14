gulp= require 'gulp'
gutil= require 'gulp-util'

gulp.task 'default',->
  gulp.start 'testWaiting'
  gulp.watch '*.coffee',-> gulp.start 'testWaiting'

gulp.task 'test',(callback)->
  spawn= require('child_process').spawn
  nw= null
  nw_bin= require('nw').findpath()
  nw.kill()　if nw?
  nw= spawn nw_bin,['test','-nwj'],stdio:'inherit'
  nw.on 'close',->
    console.log ''
    gutil.log 'closed nw-jasmine'
    callback()

gulp.task 'testWaiting',['test'],-> gutil.log 'Waiting for file changes before test...'