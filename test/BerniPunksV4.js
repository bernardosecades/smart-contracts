// web3 and etherjs come from plugins of hardhat
const { expect } = require("chai");

// Suite Cases
describe('Bernie Punks Contract', () => {
    const setup = async ({ maxSupply = 10000 }) => {
        const [owner] = await ethers.getSigners();
        const BerniePunks = await ethers.getContractFactory("BerniePunksV4");
        const deployed = await BerniePunks.deploy(maxSupply);

        return {
            owner,
            deployed
        };
    };

    describe('Deployment', () => {
        it('Set max supply to passed param', async () => {
            const maxSupply = 4000;

            const { deployed } = await setup({ maxSupply });

            const returnedMaxSupply = await deployed.maxSupply()
            expect(maxSupply).to.equal(returnedMaxSupply);
        }) ;
    });

    describe('Minting', () => {
        it('Mints a new token and assigns it to owner', async () => {
            const { owner, deployed } = await setup({});

            await deployed.mint(); // in this case the owner of contract is the same that address execute mint function XD

            const ownerOfMinted = await deployed.ownerOf(0); // only have create one token (one call to mint)

            expect(ownerOfMinted).to.equal(owner.address);
        });

        it('Has minting limit', async () => {
            const maxSupply = 2;
            const { deployed } = await setup({ maxSupply });

            // Mint all
            await deployed.mint();
            await deployed.mint();

            // Assert the last minting
            await expect(deployed.mint()).to.be.revertedWith("Max supply exceeded, no Bernie Punks left :(") // revertedWith is extension of hardhat over chi to test smart contract
        });
    });

    describe("tokenURI", () => {
        it('token', async () => {
            const { deployed } = await setup({});

            await deployed.mint(); // create token
    
            const tokenURI = await deployed.tokenURI(0);
            const stringifiedTokenURI = await tokenURI.toString();
    
            const [prefix, base64JSON] = stringifiedTokenURI.split(
                "data:application/json;base64,"
            );
    
            const stringifiedMetadata = await Buffer.from(base64JSON, "base64").toString('ascii');
            // { name: "", .... }
    
            const metadata = JSON.parse(stringifiedMetadata);
    
            expect(metadata).to.have.all.keys("name", "description", "image");
        })
    });
});