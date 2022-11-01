// SPDX-License-Identifier: UNLICENSED
pragma solidity >= 0.7.0 <0.9.0;

contract Transaction {

    // Al deploy del contrato hay que enviarle fondos en ether
    constructor() payable {

    }

    function transactionBySend(address to, uint val) public returns(bool) {
        return payable(to).send(val); // Convert to payable (we say compiler that account will receive "pagos"), el fondo saldrá del contrato, tope fijo de gas
    }

    function transactionByTransfer(address to, uint val) public {
        payable(to).transfer(val); // if fail, stop the process (similar to exception), tope fijo de gas
    }

    function transactionByCall(address to, uint val) public returns(bool) {
        (bool output, bytes memory response) = to.call{value:val}(""); // Este es mejor que el resto xq podemos poner limite de gas
        // (bool output, bytes memory response) = to.call{value:val, gas: 1000}(""); // Este es mejor que el resto xq podemos poner limite de gas
        return output;
    }


}
