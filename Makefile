project:=bigint-money
export PATH:=./node_modules/.bin/:$(PATH)

.PHONY: build
build: browser/${PROJECT}.min.js

.PHONY: clean
clean:
	rm -r browser/
	rm -r dist/

.PHONY: test
test: lint
	nyc mocha

.PHONY: test-debug
test-debug:
	mocha --inspect-brk

.PHONY: lint
lint:
	tslint -c tslint.json --project tsconfig.json 'src/**/*.ts' 'test/**/*.ts'

.PHONY: fix
fix:
	tslint -c tslint.json --project tsconfig.json 'src/**/*.ts' 'test/**/*.ts' --fix

.PHONY: tsbuild
tsbuild:
	tsc

.PHONY: watch
watch:
	tsc --watch

.PHONY: browserbuild
browserbuild: tsbuild
	# mkdir -p browser
	# webpack \
	#	--optimize-minimize \
	#	-p \
	#	--display-modules \
	#	--sort-modules-by size

browser/${PROJECT}.min.js: browserbuild
