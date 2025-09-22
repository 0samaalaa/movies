import 'package:flutter_bloc/flutter_bloc.dart';

class LayoutState {
  final int selectedIndex;
  final String? initialGenre;

  const LayoutState({this.selectedIndex = 0, this.initialGenre});

  LayoutState copyWith({int? selectedIndex, String? initialGenre}) {
    return LayoutState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      initialGenre: initialGenre,
    );
  }
}

class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit() : super(const LayoutState());

  void changeTab(int index, {String? genre}) {
    emit(LayoutState(selectedIndex: index, initialGenre: genre ?? state.initialGenre));
  }

  void setGenre(String genre) {
    emit(state.copyWith(initialGenre: genre));
  }
}
