import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nextcloud_cookbook_flutter/src/blocs/recipes_short/recipes_short.dart';
import 'package:nextcloud_cookbook_flutter/src/models/recipe_short.dart';
import 'package:nextcloud_cookbook_flutter/src/screens/recipe_screen.dart';
import 'package:nextcloud_cookbook_flutter/src/widget/authentication_cached_network_image.dart';

class RecipesListScreen extends StatefulWidget {
  final String category;

  const RecipesListScreen({Key key, @required this.category}) : super(key: key);

  @override
  State<StatefulWidget> createState() => RecipesListScreenState();
}

class RecipesListScreenState extends State<RecipesListScreen> {
  String category;

  @override
  void initState() {
    category = widget.category;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<RecipesShortBloc>(context)
        .add(RecipesShortLoaded(category: category));

    return BlocBuilder<RecipesShortBloc, RecipesShortState>(
      builder: (context, recipesShortState) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Category: $category'),
            actions: <Widget>[
              // action button
              IconButton(
                icon: Icon(
                  Icons.refresh,
                  semanticLabel: 'Refresh',
                ),
                onPressed: () {
                  BlocProvider.of<RecipesShortBloc>(context)
                      .add(RecipesShortLoaded(category: category));
                },
              ),
            ],
          ),
          body: (() {
            if (recipesShortState is RecipesShortLoadSuccess) {
              return _buildRecipesShortScreen(recipesShortState.recipesShort);
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }()),
        );
      },
    );
  }

  Widget _buildRecipesShortScreen(List<RecipeShort> data) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.separated(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return _buildRecipeShortScreen(data[index]);
        },
        separatorBuilder: (context, index) => Divider(
          color: Colors.black,
        ),
      ),
    );
  }

  ListTile _buildRecipeShortScreen(RecipeShort recipeShort) {
    return ListTile(
      title: Text(recipeShort.name),
      trailing: Container(
        child:
            AuthenticationCachedNetworkImage(imagePath: recipeShort.imageUrl),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RecipeScreen(recipeShort: recipeShort),
            ));
      },
    );
  }
}