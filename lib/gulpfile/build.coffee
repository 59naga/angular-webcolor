gulp= require 'gulp'
gulp.task 'build',(done)->
  name= require('../../package.json').name
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
  .on 'end',->
    path= require 'path'
    uglifyjs= "node "+ path.resolve require.resolve('uglify-js'),'../../bin/uglifyjs'

    exec= require('child_process').exec
    script= "#{uglifyjs} #{name}.js -o #{name}.min.js"
    script+= " --source-map #{name}.min.js.map"
    exec script,(stderr)->
      throw stderr if stderr?
      done()
  return

gulp.task 'watch',->
  gulp.watch lib,-> gulp.start 'build'
  gulp.watch specs,-> gulp.start 'default'