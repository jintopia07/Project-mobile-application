// @dart=2.9
import 'package:flutter/material.dart';
import 'package:nat/l10n/l10n.dart';
import 'package:nat/utils/locale_provider.dart';
import 'package:provider/provider.dart';

class LanguageWidget extends StatelessWidget {
  const LanguageWidget({Key key}) : super(key: key);

  @override
  build(BuildContext context) async {
    final locale = Localizations.localeOf(context);
    final flag = L10n.getFlag(locale.languageCode);

    // return Center(
    //   child: CircleAvatar(
    //     backgroundColor: Colors.white,
    //     radius: 72,
    //     child: Text(
    //       flag,
    //       style: TextStyle(fontSize: 80),
    //     ),
    //   ),
    // );
  }
}

class LanguagePickerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocaleProvider>(context);
    final locale = provider.locale ?? const Locale('en');

    return DropdownButtonHideUnderline(
      child: DropdownButton(
        value: locale,
        icon: Container(width: 12),
        items: L10n.all.map(
          (locale) {
            final flag = L10n.getFlag(locale.languageCode);

            return DropdownMenuItem(
              value: locale,
              onTap: () {
                final provider =
                    Provider.of<LocaleProvider>(context, listen: false);

                provider.setLocale(locale);
              },
              child: Center(
                child: Text(
                  flag,
                  style: TextStyle(fontSize: 25),
                ),
              ),
            );
          },
        ).toList(),
        onChanged: (_) {},
      ),
    );
  }
}
