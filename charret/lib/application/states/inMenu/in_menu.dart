import 'package:charret/application/state_machine/m_state.dart';
import 'package:charret/application/states/inMenu/in_menu_impl.dart';
import 'package:charret/application/states/menu_state.dart';

abstract class InMenu extends MenuState {
  factory InMenu() {
    return InMenuImpl();
  }
}
