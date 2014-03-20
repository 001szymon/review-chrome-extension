coffee := node_modules/.bin/coffee

coffee_source_files := $(wildcard src/**/*.coffee)
coffee_build_files  := $(coffee_source_files:src/%.coffee=build/%.js)

image_source_files := $(wildcard src/**/*.png)
image_build_files := $(image_source_files:src/%.png=build/%.png)

manifest_source_file := src/manifest.json
manifest_build_file := build/manifest.json

.PHONY: all setup clean coffee images manifest

all: coffee images manifest

setup:
	npm install

clean:
	rm -rf build/

coffee: $(coffee_build_files)

images: $(image_build_files)

manifest: $(manifest_build_file)

build/%.js: src/%.coffee
	$(coffee) -co $(dir $@) $<

build/%.png: src/%.png
	mkdir -pv $(dir $@)
	cp $< $@

$(manifest_build_file): $(manifest_source_file)
	mkdir -pv build
	cp $< $@
