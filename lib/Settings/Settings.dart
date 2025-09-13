import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:leaf_it/MainTheme.dart';
import 'package:provider/provider.dart';
import '../Theme/CurvedAppbar.dart';
import '../main.dart';

class SettingsTab extends StatefulWidget {
  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);
    return Scaffold(
      appBar: CurvedAppBar(title: AppLocalizations.of(context)!.settings),
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.language,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: 8),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    localeProvider.setLocale(Locale('en'));
                  },
                  child: Text("English",style: TextStyle(color: MainTheme.blueMain),),
                  style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                      backgroundColor: MainTheme.LightGreen),
                ),
                ElevatedButton(
                  onPressed: () {
                    localeProvider.setLocale(Locale('ar'));
                  },
                  child: Text("العربية",style: TextStyle(color: MainTheme.blueMain)),
                  style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                      backgroundColor: MainTheme.LightGreen),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
