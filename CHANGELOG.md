## master
[full changelog](http://github.com/sue445/capistrano-itamae/compare/v1.0.1...master)

## v1.0.1
[full changelog](http://github.com/sue445/capistrano-itamae/compare/v1.0.0...v1.0.1)

* Resolved. bundler deprecation warning
  * https://github.com/sue445/capistrano-itamae/pull/26

## v1.0.0
[full changelog](http://github.com/sue445/capistrano-itamae/compare/v0.2.0...v1.0.0)

### Breaking changes :bomb:
* `options` arg of `itamae_ssh` is changed to keyword arg.
  * Before (v0.x): `itamae_ssh "recipe.rb", "xxxxx"`
  * After (v1.0.0+): `itamae_ssh "recipe.rb", options: "xxxxx"`
  * https://github.com/sue445/capistrano-itamae/pull/21

### Features
* Add `environment` arg to `itamae_ssh`
  * https://github.com/sue445/capistrano-itamae/pull/22

## v0.2.0
[full changelog](http://github.com/sue445/capistrano-itamae/compare/v0.1.1...v0.2.0)

* Add `--dry-run` support
  * https://github.com/sue445/capistrano-itamae/pull/16

## v0.1.1
[full changelog](http://github.com/sue445/capistrano-itamae/compare/v0.1.0...v0.1.1)

* Add default value to itamae_ssh 1st arg 
  * https://github.com/sue445/capistrano-itamae/pull/13

## v0.1.0
* first release
