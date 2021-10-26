import 'package:flutter/material.dart';

class RulesScreen extends StatelessWidget {
  const RulesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Padding(
        padding: EdgeInsets.all(30),
        child: Text(
            "Le jeu comporte un tableau avec le dessin de 3 carrés concentriques reliés par le milieu des bords. Les coins et les intersections forment 24 cases pour déposer des jetons.Deux joueurs disposent chacun de 9 jetons de couleurs assorties. Ils sont joués, tour à tour, sur une case libre.Quand 3 cases en ligne sont fermées avec une même couleur ( pas les diagonales ) , cela forme un charret. À ce moment, celui qui forme le charret capture un jeton adverse. Ce jeton est alors retiré du jeu; il doit cependant provenir ailleurs que dans un charret adverse à moins que ce ne soit la seule possibilité.Tous les jetons ayant été déposés, ils sont déplacés, tour à tour, en les glissant le long d'une ligne à une case contigue libre. Cependant, si un joueur n'a que 3 jetons, il peut se déplacer en sautant à n'importe case libre.Si un déplacement forme ou reforme un charret, une autre capture est effectuée.Perd le joueur qui n'a que 2 jetons, ou qui est coincé parce qu'il n'a aucune case libre pour se déplacer. Une partie nulle peut être mutuellement consentie.On alterne le premier joueur à chaque partie."),
      ),
    );
  }
}
