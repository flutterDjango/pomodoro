import 'package:flutter_bloc/flutter_bloc.dart';

class PomodoroDurationCubit extends Cubit<String> {
  PomodoroDurationCubit() : super('');

  void durationInput(String value) {
    emit(value);
  }
}
