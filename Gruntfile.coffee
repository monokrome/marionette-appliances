module.exports = (grunt) ->
  banner = """/*
    <%= configuration.name %> <% configuration.version %>
    License: <%= configuration.license %>
  */\n\n"""

  fileName = "dist/<%= configuration.name %>-<% configuration.version %>.js"

  grunt.initConfig
    configuration: grunt.file.readJSON 'package.json'

    coffee:
      target:
        dest: "#{fileName}"

        src: [
          'src/*.coffee'
          'src/**/*.coffee'
        ]

    concat:
      options:
        banner: banner

      target:
        dest: "#{fileName}"
        src: "#{fileName}"


  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-concat'

  grunt.registerTask 'default', [
    'coffee'
    'concat'
  ]

