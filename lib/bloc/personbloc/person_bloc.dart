import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_moviedb/models/person.dart';
import 'package:flutter_moviedb/resource/api_provider.dart';

part 'person_event.dart';
part 'person_state.dart';

class PersonBloc extends Bloc<PersonEvent, PersonState> {
  final ApiProvider _apiProvider = ApiProvider();
  PersonBloc() : super(PersonInitial());

  @override
  Stream<PersonState> mapEventToState(PersonEvent event) async* {
    if (event is PersonEventStart) {
      yield* _mapEventStateToState();
    }
  }

  Stream<PersonState> _mapEventStateToState() async* {
    yield PersonLoading();
    try {
      List<Person> personList = await _apiProvider.getPerson();
      yield PersonLoaded(personList);
    } catch (e) {
      yield PersonError('person bloc error $e');
      print('error di personbloc $e');
    }
  }
}
