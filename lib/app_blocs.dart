import 'package:alearning_app/app_events.dart';
import 'package:alearning_app/app_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocs extends Bloc<AppEvents, AppStates> {
  AppBlocs() : super(InitState()) {
    //Increment Method
    on<Increment>((event, emit) {
      emit(AppStates(counter: state.counter + 1));
      print(state.counter);
    });

    //Decrement Method
    on<Decrement>((event, emit) {
      emit(AppStates(counter: state.counter - 1));
      print(state.counter);
    });
  }
}
