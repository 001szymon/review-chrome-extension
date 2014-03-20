coffee := node_modules/.bin/coffee

coffee_source_files := $(wildcard src/**/*.coffee)
coffee_build_files  := $(coffee_source_files:src/%.coffee=build/%.js)

build/%.js: src/%.coffee
	$(coffee) -co $(dir $@) $<

.PHONY: all

all: coffee

coffee: $(coffee_build_files)

setup:
	npm install

clean:
	rm -rf build/
