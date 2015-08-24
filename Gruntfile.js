module.exports = function(grunt) {

  grunt.initConfig({
    karma: {
      unit: {
        configFile: 'my.conf.js',
        autoWatch: true
      }
    }
  });

  grunt.loadNpmTasks('grunt-karma');
};