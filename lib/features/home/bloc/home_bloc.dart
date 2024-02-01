import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet4u/features/home/bloc/home_event.dart';
import 'package:pet4u/features/home/bloc/home_state.dart';
import 'package:pet4u/models/pet_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  List<String>? adoptedPets;
  List<Pet> pets = [];

  HomeBloc() : super(HomeInit()) {
    on<PetSearch>((event, emit) {
      if (event.query.isEmpty) {
        return emit(HomeLoaded(pets: this.pets, adoptedPets: adoptedPets!));
      }
      List<Pet> pets = [];
      for (Pet pet in this.pets) {
        if (pet.name.toLowerCase().contains(event.query.toLowerCase())) {
          pets.add(pet);
        }
      }
      emit(PetSearchedState(pets: pets));
    });
    on<AdoptPet>((event, emit) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      adoptedPets = prefs.getStringList('adoptedPets') ?? [];
      adoptedPets!.add(event.petID);
      await prefs.setStringList('adoptedPets', adoptedPets!);

      emit(PetAdoptedState(petID: event.petID));
    });
    on<HomeLoadEvent>((event, emit) async {
      Completer<HomeState> completer = Completer();
      emit(HomeLoading());
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        adoptedPets = prefs.getStringList('adoptedPets') ?? [];
        List<Pet> pets = await fetchAllPets();
        this.pets = pets;
        completer.complete(
          HomeLoaded(
            pets: pets,
            adoptedPets: adoptedPets!,
          ),
        );
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
