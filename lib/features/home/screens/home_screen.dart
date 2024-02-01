import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet4u/constants/custom_colors.dart';
import 'package:pet4u/features/history/screens/history_screen.dart';
import 'package:pet4u/features/home/bloc/home_bloc.dart';
import 'package:pet4u/features/home/bloc/home_event.dart';
import 'package:pet4u/features/home/bloc/home_state.dart';
import 'package:pet4u/features/pet_details/screens/pet_detail_screen.dart';
import 'package:pet4u/features/theme/bloc/theme_bloc.dart';
import 'package:pet4u/features/theme/bloc/theme_event.dart';
import 'package:pet4u/models/pet_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool searching = false;
  late TextEditingController _searchController;
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(HomeLoadEvent());
    _searchController = TextEditingController();
    _searchController.addListener(() {
      setState(() {
        search = _searchController.text;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void searchChanged(bool clear) {
    if (clear) {
      context.read<HomeBloc>().add(PetSearch(query: ''));
    } else {
      context.read<HomeBloc>().add(PetSearch(query: _searchController.text));
    }
  }

  List<Pet>? pets;
  List<String>? adoptedPets;
  String search = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('Welcome', style: Theme.of(context).textTheme.headlineLarge),
        actions: [
          PopupMenuButton(
            iconColor: (context.read<ThemeBloc>().isDark ?? false)
                ? Colors.white
                : Colors.black,
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  value: 'logout',
                  child: Row(
                    children: [
                      Text(
                          '${(context.read<ThemeBloc>().isDark ?? false) ? 'Light' : 'Dark'} mode'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'history',
                  child: Row(
                    children: [
                      Text('View History'),
                    ],
                  ),
                ),
              ];
            },
            onSelected: (val) {
              if (val == 'history') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const HistoryScreen();
                    },
                  ),
                );
              } else {
                context.read<ThemeBloc>().add(ThemeChangeEvent());
              }
            },
          ),
        ],
      ),
      // backgroundColor: const Color(0xfff7f7f7),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocListener<HomeBloc, HomeState>(
          bloc: BlocProvider.of<HomeBloc>(context),
          listener: (context, state) {
            if (state is PetAdoptedState) {
              setState(() {
                adoptedPets!.add(state.petID);
              });
            }
            if (state is HomeError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }

            if (state is HomeLoaded) {
              setState(() {
                searching = false;
                pets = state.pets;
                adoptedPets = state.adoptedPets;
              });
            }
            if (state is PetSearchedState) {
              setState(() {
                searching = true;

                pets = state.pets;
              });
            }
          },
          child: pets == null
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 1,
                            offset: Offset(0, 1),
                          ),
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 1,
                            offset: Offset(1, 0),
                          ),
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 1,
                            offset: Offset(-1, 0),
                          ),
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 1,
                            offset: Offset(0, -1),
                          ),
                        ],
                      ),
                      child: TextFormField(
                        onChanged: (_) {
                          searchChanged(_searchController.text.isEmpty);
                        },
                        controller: _searchController,
                        decoration: InputDecoration(
                          fillColor: context.read<ThemeBloc>().isDark!
                              ? Colors.grey[800]
                              : Colors.grey[200],
                          focusColor: Colors.white,
                          filled: true,
                          hintText: 'Search',
                          prefixIconColor: Colors.grey[400],
                          hintStyle: TextStyle(
                            color: context.read<ThemeBloc>().isDark!
                                ? Colors.white
                                : Colors.black,
                          ),
                          prefixIcon: const Icon(Icons.search),
                          suffixIcon: searching
                              ? IconButton(
                                  onPressed: () {
                                    searchChanged(true);
                                    _searchController.clear();
                                  },
                                  icon: const Icon(Icons.close,
                                      color: Colors.grey),
                                )
                              : null,
                          // suffixIcon:
                          //     searching ? const Icon(Icons.close) : null,
                          border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Row(
                    //   children: [
                    //     Expanded(child: TextFormField()),
                    //     const SizedBox(width: 10),
                    //     IconButton(
                    //       onPressed: () {},
                    //       icon: const Icon(Icons.search),
                    //     ),
                    //   ],
                    // ),
                    // const SizedBox(height: 10),
                    // const Text('Categories'),
                    // const SizedBox(height: 10),
                    // SizedBox(
                    //   height: 40,
                    //   child: ListView.separated(
                    //     separatorBuilder: (context, index) {
                    //       return const SizedBox(width: 10);
                    //     },
                    //     scrollDirection: Axis.horizontal,
                    //     shrinkWrap: true,
                    //     physics: const ClampingScrollPhysics(),
                    //     itemCount: species!.length,
                    //     itemBuilder: (context, index) {
                    //       return ChoiceChip(
                    //         showCheckmark: false,
                    //         onSelected: (isSelected) {
                    //           print(isSelected);
                    //         },
                    //         selected: false,
                    //         label: Text(species!.elementAt(index)),
                    //       );
                    //     },
                    //   ),
                    // ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${pets!.length} results',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        // TextButton(
                        //   onPressed: () {},
                        //   child: const Text('See all'),
                        // )
                      ],
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: GridView.builder(
                        itemCount: pets!.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.7,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                        ),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return PetDetailScreen(
                                      pet: pets![index],
                                    );
                                  },
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.only(
                                left: 11,
                                top: 12,
                                right: 11,
                              ),
                              decoration: BoxDecoration(
                                color: adoptedPets!.contains(pets![index].id)
                                    ? Colors.grey
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: CustomColors.getColorForSpecie(
                                          pets![index].species,
                                        ),

                                        // image: DecorationImage(
                                        //   image: CachedNetworkImageProvider(
                                        //     pets![index].urlToImage,
                                        //   ),
                                        //   fit: BoxFit.cover,
                                        // ),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Hero(
                                        tag: pets![index].id,
                                        child: CachedNetworkImage(
                                          imageUrl: pets![index].urlToImage,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  ListTile(
                                    title: Text(pets![index].name),
                                    subtitle: Text(pets![index].breed),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
