import 'dart:math' as math;
import 'package:covid19_monitor/bloc/feature/country_list_bloc.dart';
import 'package:covid19_monitor/bloc/feature/per_country_bloc.dart';
import 'package:covid19_monitor/model/country_list_model.dart';
import 'package:covid19_monitor/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CountrySearch extends SearchDelegate {
  final CountryList countryList;

  CountrySearch(this.countryList)
      : super(
          searchFieldLabel: 'Search country',
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.none,
        );

  @override
  ThemeData appBarTheme(BuildContext context) {
    assert(context != null);
    final ThemeData theme = Theme.of(context);
    assert(theme != null);
    return theme.copyWith(
      inputDecorationTheme: theme.inputDecorationTheme.copyWith(
        hintStyle: theme.textTheme.subtitle1.copyWith(color: labelColor),
      ),
      textTheme: theme.textTheme,
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () => query = '',
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestion = query.isEmpty
        ? countryList.countries
        : List<Country>.from(countryList.countries.where(
            (e) => e.name.toLowerCase().contains(query.toLowerCase()),
          ));

    return ListView.builder(
      itemCount: suggestion.length,
      itemBuilder: (context, index) => ListTile(
        title: RichText(
          text: TextSpan(
            children: highlightOccurrences(
              suggestion[index].name,
              query,
              Theme.of(context).textTheme.subtitle1,
            ),
            style: Theme.of(context)
                .textTheme
                .subtitle1
                .copyWith(color: labelColor),
          ),
        ),
        trailing: Transform.rotate(
          angle: 270 * math.pi / 180,
          child: IconButton(
            icon: Icon(Icons.call_made),
            onPressed: () => query = suggestion[index].name,
          ),
        ),
        onTap: () {
          close(context, null);
          BlocProvider.of<PerCountryBloc>(context)
              .add(ChangePerCountry(suggestion[index].name));
        },
      ),
    );
  }

  List<TextSpan> highlightOccurrences(
    String source,
    String query,
    TextStyle style,
  ) {
    if (query == null ||
        query.isEmpty ||
        !source.toLowerCase().contains(query.toLowerCase()))
      TextSpan(text: source);

    final matches = query.toLowerCase().allMatches(source.toLowerCase());

    int lastMatchEnd = 0;

    final List<TextSpan> children = [];

    for (var i = 0; i < matches.length; i++) {
      final match = matches.elementAt(i);

      if (match.start != lastMatchEnd) {
        children.add(TextSpan(
          text: source.substring(lastMatchEnd, match.start),
        ));
      }

      children.add(TextSpan(
        text: source.substring(match.start, match.end),
        style: style,
      ));

      if (i == matches.length - 1 && match.end != source.length) {
        children.add(TextSpan(
          text: source.substring(match.end, source.length),
        ));
      }

      lastMatchEnd = match.end;
    }
    return children;
  }
}
