coffee := node_modules/.bin/coffee

apps_coffee_source_files := $(wildcard src/apps/**/*.coffee)
apps_coffee_build_files  := $(apps_coffee_source_files:src/apps/%.coffee=build/apps/%.js)

bundle_coffee_source_files := $(wildcard src/javascripts/*.coffee)
bundle_coffee_build_files  := $(bundle_coffee_source_files:src/javascripts/%.coffee=tmp/javascripts/%.js)

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

.PHONY: all setup clean coffee images manifest html libraries bundle

all: coffee images manifest html libraries bundle

setup:
	npm install

clean:
	rm -rf build/

coffee: $(apps_coffee_build_files) $(bundle_coffee_build_files)

images: $(image_build_files)

manifest: $(manifest_build_file)

html: $(html_build_files)

libraries: $(libraries_build_files)

bundle: $(bundle_build_file)

build/apps/%.js: src/apps/%.coffee
	$(coffee) -co $(dir $@) $<

tmp/javascripts/%.js: src/javascripts/%.coffee
	$(coffee) -co $(dir $@) $<

$(bundle_build_file): $(bundle_coffee_build_files)
	mkdir -pv build/javascripts
	cat $^ > $@

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
	mkdir -pv build/vendor/
	cp $< $@
