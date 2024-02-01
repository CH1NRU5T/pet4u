sealed class HomeEvent {}

class HomeLoadEvent extends HomeEvent {}

class AdoptPet extends HomeEvent {
  final String petID;
  AdoptPet({required this.petID});
}

class PetSearch extends HomeEvent {
  final String query;
  PetSearch({required this.query});
}
