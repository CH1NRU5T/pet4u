import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet4u/features/home/bloc/home_event.dart';
import 'package:pet4u/features/home/bloc/home_state.dart';
import 'package:pet4u/models/pet_model.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInit()) {
    on<HomeLoadEvent>((event, emit) async {
      Completer<HomeState> completer = Completer();
      emit(HomeLoading());
      try {
        List<Pet> pets = await fetchAllPets();
        Set<Species> species = getSpecies(pets);
        completer.complete(HomeLoaded(pets: pets, species: species));
      } catch (e) {
        completer.complete(HomeError(message: e.toString()));
      }
      emit(await completer.future);
    });
  }
  Future<List<Pet>> fetchAllPets() async {
    QuerySnapshot qs =
        await FirebaseFirestore.instance.collection('pets').get();

    return qs.docs
        .map((e) => Pet.fromMap(e.data() as Map<String, dynamic>)..id = e.id)
        .toList();
  }

  Set<Species> getSpecies(List<Pet> pets) {
    Set<Species> species = {};
    for (var pet in pets) {
      species.add(pet.species);
    }
    return species;
  }

  // final HomeRepository homeRepository;

  // HomeBloc({@required this.homeRepository}) : super(HomeInitial());

  // @override
  // Stream<HomeState> mapEventToState(
  //   HomeEvent event,
  // ) async* {
  //   if (event is HomeLoadEvent) {
  //     yield HomeLoading();
  //     try {
  //       final home = await homeRepository.getHome();
  //       yield HomeLoaded(home: home);
  //     } catch (e) {
  //       yield HomeError(message: e.toString());
  //     }
  //   }
  // }
}
