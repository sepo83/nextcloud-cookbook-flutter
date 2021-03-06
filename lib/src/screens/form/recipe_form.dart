import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nextcloud_cookbook_flutter/src/blocs/recipe/recipe.dart';
import 'package:nextcloud_cookbook_flutter/src/models/recipe.dart';
import 'package:validators/validators.dart';

class RecipeForm extends StatefulWidget {
  final Recipe recipe;

  const RecipeForm(this.recipe);

  @override
  _RecipeFormState createState() => _RecipeFormState();
}

class _RecipeFormState extends State<RecipeForm> {
  final _formKey = GlobalKey<FormState>();
  Recipe recipe;
  MutableRecipe _mutableRecipe;

  @override
  void initState() {
    recipe = widget.recipe;
    _mutableRecipe = recipe.toMutableRecipe();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            initialValue: recipe.name,
            decoration: InputDecoration(hintText: "Recipe Name"),
            onSaved: (value) {
              _mutableRecipe.name = value;
            },
          ),
          TextFormField(
            initialValue: recipe.recipeYield.toString(),
            keyboardType: TextInputType.number,
            decoration: InputDecoration(hintText: "Recipe Yield"),
            validator: (value) =>
                isNumeric(value) ? null : "Recipe Yield should be a number",
            onSaved: (value) => _mutableRecipe.recipeYield = int.parse(value),
          ),
          RaisedButton(
            onPressed: () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();

                BlocProvider.of<RecipeBloc>(context)
                    .add(RecipeUpdated(_mutableRecipe.toRecipe()));
              }
            },
            child: Text("Update"),
          )
        ],
      ),
    );
  }
}
