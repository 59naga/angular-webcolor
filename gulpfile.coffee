gulp= require 'gulp'
gutil= require 'gulp-util'

gulp.task 'default',->
  gulp.start 'testWaiting'
  gulp.watch ['*.coffee','test/index.*'],-> gulp.start 'testWaiting'

gulp.task 'test',(callback)->
  spawn= require('child_process').spawn
  nw= null
  nw= spawn 'npm',['test'],stdio:'inherit'
  nw.on 'close',->
    console.log ''
    gutil.log 'closed nw-jasmine'
    callback()

gulp.task 'testWaiting',['test'],-> gutil.log 'Waiting for file changes before test...'