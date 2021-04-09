
# Mini audit du chapitre 5 (cours Alyra).

Le premier changement a été de changer la version de solidity utilisée pour utiliser la librairie [SafeMath.sol](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/math/SafeMath.sol) de openzeppelin

```
pragma solidity 0.8.0;
```

Ensuite, il fallait adapter le code pour pour qu'il soit compilé avec cette version. Par exemple, la fonction Crowdsale qui portait le même nom que le contract a été remplacé par le constructor. Dans ce constructeur, __tx.origin__ a été remplacé par __msg.sender__ pour une meilleure gestion des appels externes au contract.
