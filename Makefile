coffee := node_modules/.bin/coffee

coffee_source_files := $(wildcard src/**/*.coffee)
coffee_build_files  := $(coffee_source_files:src/%.coffee=build/%.js)

image_source_files := $(wildcard src/**/*.png)
image_build_files := $(image_source_files:src/%.png=build/%.png)

manifest_source_file := src/manifest.json
manifest_build_file := build/manifest.json

html_source_files := $(wildcard src/**/*.html)
html_build_files := $(html_source_files:src/%.html=build/%.html)

jquery_source_file := node_modules/jquery/dist/jquery.js
jquery_build_file := build/vendor/jquery.js

libraries_source_files := $(jquery_source_file)
libraries_build_files := $(jquery_build_file)

.PHONY: all setup clean coffee images manifest html libraries

all: coffee images manifest html libraries

setup:
	npm install

clean:
	rm -rf build/

coffee: $(coffee_build_files)

images: $(image_build_files)

manifest: $(manifest_build_file)

html: $(html_build_files)

libraries: $(libraries_build_files)

build/%.js: src/%.coffee
	$(coffee) -co $(dir $@) $<

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
