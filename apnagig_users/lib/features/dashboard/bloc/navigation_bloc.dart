import 'package:flutter_bloc/flutter_bloc.dart';

// Events
abstract class NavigationEvent {}

class TabChangedEvent extends NavigationEvent {
  final int index;
  TabChangedEvent(this.index);
}

// States
class NavigationState {
  final int selectedIndex;
  const NavigationState(this.selectedIndex);
}

// Bloc
class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(const NavigationState(0)) {
    on<TabChangedEvent>((event, emit) {
      emit(NavigationState(event.index));
    });
  }
}
