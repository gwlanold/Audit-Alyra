
# Mini audit du chapitre 5 (cours Alyra).

Le premier changement a été de changer la version de solidity utilisée pour utiliser la librairie [SafeMath.sol](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/math/SafeMath.sol) de openzeppelin et d'ajouter une licence.

```
//SPDX-License-Identifier: MIT
pragma solidity 0.8.0;
```

Ensuite, il fallait adapter le code pour pour qu'il soit compilé avec cette version. Par exemple, la fonction __Crowdsale__ qui portait le même nom que le contract a été remplacé par le constructor. Dans ce constructeur, __tx.origin__ a été remplacé par __msg.sender__ pour gérer les attaques liées aux appels externes au contract. Pour empêcher l'envoie de données autre que les eth, nous exigeons que le champ data de msg soit vide.

```
 require(msg.data.length == 0);
```

Dans la fonction __withdrawPayments__, nous avons d'abord modifié les variables d'états avant les appels externes.

Nous avons ensuite ajouté la fonction __receive__ qui doit exister dans le contract quand on fait appel au __fallback__ dans les nouvelles versions de solidity. Cette version ne fait autre chose que d'émettre un événement.

```
receive() external payable {
  emit Ownable(owner);
}
```
