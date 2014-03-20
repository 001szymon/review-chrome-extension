coffee := node_modules/.bin/coffee

coffee_source_files := $(wildcard src/**/*.coffee)
coffee_build_files  := $(coffee_source_files:src/%.coffee=build/%.js)

image_source_files := $(wildcard src/**/*.png)
image_build_files := $(image_source_files:src/%.png=build/%.png)

build/%.js: src/%.coffee
	$(coffee) -co $(dir $@) $<

build/%.png: src/%.png
	mkdir -pv $(dir $@)
	cp $< $@

.PHONY: all

all: coffee images

coffee: $(coffee_build_files)

images: $(image_build_files)

setup:
	npm install

clean:
	rm -rf build/
