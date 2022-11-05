# Bernie Hardhat Project (Smart contract learning)

[![CI Tests](https://github.com/bernardosecades/smart-contracts/actions/workflows/test.yml/badge.svg)](https://github.com/bernardosecades/smart-contracts/actions/workflows/test.yml) [![CI Linter](https://github.com/bernardosecades/smart-contracts/actions/workflows/linter.yml/badge.svg)](https://github.com/bernardosecades/smart-contracts/actions/workflows/linter.yml)

To learn smart contracts, test for those contracts, and a script that deploys those contracts.

Try running some of the following tasks:

```shell
npx hardhat help
npx hardhat test
REPORT_GAS=true npx hardhat test
npx hardhat node
npx hardhat run scripts/deploy.js
```

Makefile

```shell
make help
```

# Deploy

local:

`npx hardhat run scripts/deploy_berni_nft.js`

goerli:

`npx hardhat run scripts/deploy_berni_nft.js --network goerli`


# ADN

13 atributos api avataar ver screenshot (26 numeros, cada par definen un atributo).

usaremos uint256, pero solo los ultimos 26 nuneros para saber el adn

https://getavataaars.com/