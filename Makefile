all: help

#### LINTER ##
## lint: Run linter. Usage: 'make lint' (npm install -g ethlint)
.PHONY: lint
lint: ; $(info Linting contracts...)
	solium -d contracts/

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