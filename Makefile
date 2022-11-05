all: help

#### LINTER ##
## lint: Run linter. Usage: 'make lint' (npm install -g ethlint)
.PHONY: lint
lint: ; $(info Linting contracts...)
	solium -d contracts/

#### CLEAN ##
## clean: Clear the cache and delete the artifacts. Usage: 'make clean'
.PHONY: clean
clean: ; $(info Clear cache and delete the artifacts ...)
	npx hardhat clean		

#### COMPILE ##
## compile: Compile contracts. Usage: 'make compile'
.PHONY: compile
compile: ; $(info Compiling contracts...)
	npx hardhat compile	

#### TEST ##
## test: Run tests. Usage: 'make test'
.PHONY: test
test: ; $(info Linting contracts...)
	npx hardhat test

#### HELP ##
## help: Show this screen
help: Makefile
	@sed -n 's/^##//p' $<	