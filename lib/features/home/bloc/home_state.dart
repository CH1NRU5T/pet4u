import 'package:pet4u/models/pet_model.dart';

sealed class HomeState {}

class HomeInit extends HomeState {}

class HomeLoading extends HomeState {}

class HomeError extends HomeState {
  final String message;

  HomeError({required this.message});
}

class HomeLoaded extends HomeState {
  final List<Pet> pets;
  final List<String> adoptedPets;
  HomeLoaded({required this.pets, required this.adoptedPets});
}

class PetAdoptedState extends HomeState {
  final String petID;

  PetAdoptedState({required this.petID});
}
