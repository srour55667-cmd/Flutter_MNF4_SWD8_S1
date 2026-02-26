import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'changecount_state.dart';

class ChangecountCubit extends Cubit<ChangecountState> {
  ChangecountCubit() : super(ChangecountInitial());
   int counter = 0;

  void incrementCounter() {

      counter++;
      emit(ChangecountIncremented());
    
  }
}
