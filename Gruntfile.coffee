module.exports = (grunt) ->
  
  namespace = [
    'src/namespace/submodulea.coffee'
    'src/namespace/submoduleb.coffee'
    'src/namespace/exports.coffee'
  ]

  # Project configuration.
  grunt.initConfig
    pkg: grunt.file.readJSON("package.json")

    coffee:
      compile:
        files:
          'tmp/module.js': namespace
        options:
          join: true

    concat:
      dist:
        files: [
          dest: 'lib/module.js'
          src: 'tmp/**/*.js'
        ]
      options:
        separator: ';'
        banner: '''
        /*
         * Module <%= pkg.version %>
         *
         * Copyright © 2013 Author
         * This module may be freely distributed under the MIT license.
         */

         
        '''

    clean:
      build: ['tmp', 'lib']

    watch:
      all:
        files: 'src/**/*.coffee'
        tasks: ['default']

  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.loadNpmTasks('grunt-contrib-concat')
  grunt.loadNpmTasks('grunt-contrib-clean')
  grunt.loadNpmTasks('grunt-contrib-watch')

  # Build
  # -------
  grunt.registerTask 'build', [
    'coffee:compile'
    'concat'
  ]

  # Default
  # -------
  grunt.registerTask 'default', [
    'clean'
    'build'
  ]