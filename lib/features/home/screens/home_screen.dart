import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet4u/constants/custom_colors.dart';
import 'package:pet4u/features/home/bloc/home_bloc.dart';
import 'package:pet4u/features/home/bloc/home_event.dart';
import 'package:pet4u/features/home/bloc/home_state.dart';
import 'package:pet4u/features/pet_details/screens/pet_detail_screen.dart';
import 'package:pet4u/models/pet_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    context.read<HomeBloc>().add(HomeLoadEvent());
  }

  List<Pet>? pets;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocListener<HomeBloc, HomeState>(
            bloc: BlocProvider.of<HomeBloc>(context),
            listener: (context, state) {
              if (state is HomeError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                  ),
                );
              }

              if (state is HomeLoaded) {
                setState(() {
                  pets = state.pets;
                });
              }
            },
            child: pets == null
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Expanded(child: TextFormField()),
                          const SizedBox(width: 10),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.search),
                          ),
                        ],
                      ),
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
                          Text('${pets!.length} results'),
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
                                      return PetDetailScreen(pet: pets![index]);
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
                                  color: Colors.grey[200],
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
                                          borderRadius:
                                              BorderRadius.circular(20),
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
      ),
    );
  }
}
