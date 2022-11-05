// @see https://goerli.etherscan.io/address/0x80A3d345Bd16A6A384952F8A7d94bBf7B495dB22
const deploy = async () => {
    const [deployer] = await ethers.getSigners();

    console.log("Deploying contract with account:", deployer.address);

    const BernieNFT = await ethers.getContractFactory("BerniePunksV1");
    const deployed = await BernieNFT.deploy();

    console.log("Bernie Punks is deployed at: ", deployed.address);
};

deploy()
    .then(() => process.exit(0))
    .catch(error => {
        console.log(error);
        process.exit(1);
    });
