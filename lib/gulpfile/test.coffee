gulp= require 'gulp'
gulp.task 'test',['self_update','bower_update','webdriver_update'],->
  protractor= require('gulp-protractor').protractor
  connect= require 'gulp-connect'
  connect.server serverOptions

  gulp.src specs
    .pipe protractor
      configFile: 'lib/gulpfile/test.coffee',
      args: ['--baseUrl', "http://#{serverOptions.host}:#{serverOptions.port}/test/"]
    .on 'error',(message)->
      throw message
    .on 'end',->
      connect.serverClose()

gulp.task 'self_update',->
  gulp.src require('../../bower.json').main
    .pipe gulp.dest 'test/bower_components/'+require('../../bower.json').name+'/'

gulp.task 'bower_update',->
  bower= require 'gulp-bower'
  bower directory:'test/bower_components'

gulp.task 'webdriver_update',require('gulp-protractor').webdriver_update

lib=
  'lib/**'
specs=
  'test/**/*.coffee'
serverOptions=
  root: 'test'
  host: '127.0.0.1'
  port: 59798

protractorConfig=
  capabilities: 
    browserName: 'chrome'
  # via http://c-note.chatwork.com/post/101826748775/an-introduction-to-simple-e2e-testing-with-travisci-sauc
  sauceUser: process.env.SAUCE_USERNAME
  sauceKey: process.env.SAUCE_ACCESS_KEY
  jasmineNodeOpts: 
    showColors: true
    isVerbose: true
    defaultTimeoutInterval: 30000
exports.config= protractorConfig