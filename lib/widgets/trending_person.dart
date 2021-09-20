import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_moviedb/bloc/personbloc/person_bloc.dart';
import 'package:flutter_moviedb/widgets/loading.dart';

class TrendingPerson extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PersonBloc()..add(PersonEventStart()),
      child: _buildPersonBody(context),
    );
  }

  //build body
  Widget _buildPersonBody(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<PersonBloc, PersonState>(
          builder: (context, state) {
            if (state is PersonLoading) {
              return isLoading();
            } else if (state is PersonLoaded) {
              return Container(
                height: 110,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.personList.length,
                  separatorBuilder: (context, index) {
                    return VerticalDivider(
                      color: Colors.transparent,
                      width: 5,
                    );
                  },
                  itemBuilder: (context, index) {
                    final person = state.personList[index];
                    return Container(
                      child: Column(
                        children: [
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            elevation: 5,
                            child:
                                /* ClipRRect(
                                child: Container(
                              height: 70,
                              width: 50,
                              child: Image.network(
                                  'https://image.tmdb.org/t/p/w200${person.profilePath}'),
                            ) */
                                CachedNetworkImage(
                              imageUrl:
                                  'https://image.tmdb.org/t/p/w200${person.profilePath}',
                              imageBuilder: (context, imageProvider) {
                                return Container(
                                  height: 70,
                                  width: 70,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(100),
                                    ),
                                    image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover),
                                  ),
                                );
                              },
                              placeholder: (context, url) {
                                return Container(
                                  height: 80,
                                  width: 80,
                                  child: isLoading(),
                                );
                              },
                            ),
                          ),
                          Container(
                            child: Center(
                              child: Text(
                                person.name.toUpperCase(),
                                style: TextStyle(
                                  color: Colors.black45,
                                  fontSize: 8,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            child: Center(
                              child: Text(
                                person.knowForDepartment.toUpperCase(),
                                style: TextStyle(
                                  color: Colors.black45,
                                  fontSize: 8,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            } else {
              return isLoading();
            }
          },
        )
      ],
    );
  }
}
