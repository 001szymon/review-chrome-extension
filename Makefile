coffee := node_modules/.bin/coffee
sass := ruby_gems/wrappers/sass --cache-location tmp/sass-cache
testem := ./node_modules/testem/testem.js
bower := ./node_modules/bower/bin/bower

apps_coffee_source_files := $(wildcard src/apps/**/*.coffee)
apps_coffee_build_files  := $(apps_coffee_source_files:src/apps/%.coffee=build/apps/%.js)

bundle_coffee_source_files := $(wildcard src/javascripts/*.coffee)
bundle_coffee_build_files  := $(bundle_coffee_source_files:src/javascripts/%.coffee=tmp/javascripts/%.js)

tests_source_files := $(wildcard src/tests/*.coffee)
tests_build_files  := $(tests_source_files:src/tests/%.coffee=tmp/tests/%.js)

sass_source_files := src/stylesheets/main.scss
sass_build_files := $(sass_source_files:src/%.scss=build/%.css)

image_source_files := $(wildcard src/**/*.png)
image_build_files := $(image_source_files:src/%.png=build/%.png)

manifest_source_file := src/manifest.json
manifest_build_file := build/manifest.json

html_source_files := $(wildcard src/apps/**/*.html)
html_build_files := $(html_source_files:src/%.html=build/%.html)

jquery_source_file := node_modules/jquery/dist/jquery.js
jquery_build_file := build/vendor/jquery.js

libraries_source_files := $(jquery_source_file)
libraries_build_files := $(jquery_build_file)

bundle_build_file := build/javascripts/bundle.js

tests_build_file := build/tests/tests.js
tests_runner_file := build/tests/runner.html
jstest_source_file := node_modules/jstest/jstest.js
jstest_build_file := build/tests/jstest.js

.PHONY: all setup clean coffee sass images manifest html libraries bundle test test-files

all: coffee sass images manifest html libraries bundle

setup:
	npm install
	gem install --no-rdoc --no-ri sass -i ruby_gems
	$(bower) install bootstrap

clean:
	rm -rf tmp/
	rm -rf build/

test-files: bundle $(tests_build_file) $(tests_runner_file) $(jstest_build_file)

test: test-files
	$(testem) ci

coffee: $(apps_coffee_build_files) $(bundle_coffee_build_files)

sass: $(sass_build_files)

images: $(image_build_files)

manifest: $(manifest_build_file)

html: $(html_build_files)

libraries: $(libraries_build_files)

bundle: $(bundle_build_file)

build/apps/%.js: src/apps/%.coffee
	$(coffee) -co $(dir $@) $<

tmp/javascripts/%.js: src/javascripts/%.coffee
	$(coffee) -co $(dir $@) $<

tmp/tests/%.js: src/tests/%.coffee
	$(coffee) -co $(dir $@) $<

$(bundle_build_file): $(bundle_coffee_build_files)
	mkdir -pv build/javascripts
	cat $^ > $@

$(tests_build_file): $(tests_build_files)
	mkdir -pv build/tests
	cat $^ > $@

build/%.css: src/%.scss
	mkdir -pv $(dir $@)
	$(sass) $< $@

build/%.png: src/%.png
	mkdir -pv $(dir $@)
	cp $< $@

$(manifest_build_file): $(manifest_source_file)
	mkdir -pv build
	cp $< $@

build/%.html: src/%.html
	mkdir -pv $(dir $@)
	cp $< $@

$(jquery_build_file): $(jquery_source_file)
	mkdir -pv build/vendor
	cp $< $@

$(jstest_build_file): $(jstest_source_file)
	mkdir -pv build/tests
	cp $< $@
