import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:meals/components/custom_app_bar.dart';
import 'package:meals/components/main_drawer.dart';
import 'package:meals/models/settings.dart';

class SettingsScreen extends StatefulWidget {

  final Settings settings;
  final Function (Settings) _onSettingsChanged;

  const SettingsScreen(this.settings, this._onSettingsChanged);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  Settings settings = Settings();

  @override
  void initState() {
    super.initState();
    settings = widget.settings;
  }

  Widget _createSwitchTile(
    String title,
    String subtitle,
    bool value,
    Function(bool) onChanged,
  ) {
    return SwitchListTile.adaptive(
      value: value,
      onChanged: (newValue) {
        onChanged(newValue);
        widget._onSettingsChanged(settings);
      },
      title: Text(title),
      subtitle: Text(subtitle),
      activeColor: Theme.of(context).primaryColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, 'Configurações'),
      drawer: MainDrawer(),
      body: Column(children: [
        _createSwitchTile(
          'Sem Glúten',
          'Só exibe refeições sem glutén!',
          settings.isGlutenFree,
          (value) => setState(() {
            settings.isGlutenFree = value;
          }),
        ),
        _createSwitchTile(
          'Sem Lactose',
          'Só exibe refeições sem lactose!',
          settings.isLactoseFree,
          (value) => setState(() {
            settings.isLactoseFree = value;
          }),
        ),
        _createSwitchTile(
          'Vegana',
          'Só exibe refeições veganas!',
          settings.isVegan,
          (value) => setState(() {
            settings.isVegan = value;
          }),
        ),
        _createSwitchTile(
          'Vegetariana',
          'Só exibe refeições vegetarianas!',
          settings.isVegetarian,
          (value) => setState(() {
            settings.isVegetarian = value;
          }),
        ),
      ]),
    );
  }
}
