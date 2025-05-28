import 'package:adam_group/API/Api_Controllers/statement_api_controller.dart';
import 'package:adam_group/Consts/app_color.dart';
import 'package:adam_group/Extensions/sized_box_extension.dart';
import 'package:adam_group/Helpers/converter_helper.dart';
import 'package:adam_group/Helpers/out_app_helper.dart';
import 'package:adam_group/Helpers/snackbar.dart';
import 'package:adam_group/Models/accoun_statment_model.dart';
import 'package:adam_group/Providers/auth_provider.dart';
import 'package:adam_group/Widgets/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class StatementScreen extends StatefulWidget {
  const StatementScreen({super.key});

  @override
  State<StatementScreen> createState() => _StatementScreenState();
}

class _StatementScreenState extends State<StatementScreen>
    with SnackBarHelper, OutAppHelper, ConverterHelper {
  List<StatementModel> statements = [];

  @override
  void initState() {
    super.initState();
    _init;
  }

  bool _loading = true;

  Future<void> get _init async {
    print('111');
    await _getStatement;

    setState(() {
      _loading = false;
    });
  }

  Future<void> get _getStatement async {
    try {
      AuthProvider auth = Provider.of<AuthProvider>(context, listen: false);
      var list = await StatementsApiController()
          .getStatement(context, auth.userModel?.id.toString() ?? '');
      statements = list;
      print(statements);
    } catch (e) {
      print(e.toString());
    }
  }

  Widget _image(screenHeight) {
    String path = 'assets/images/files/';

    String link = statements.first.publicUrl ?? '';
    String ext = getFileExtension(link);
    if (ext.contains('xlsx')) {
      path += 'exel.png';
      return Image.asset(path);
    } else if (ext.contains('pdf')) {
      path += 'pdf.png';
      return Image.asset(path);
    } else if (ext.contains('docx')) {
      path += 'word.png';
      return Image.asset(path);
    }

    return Image.network(
      link,
      height: screenHeight * 0.4,
      fit: BoxFit.cover,
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;

    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                AppLocalizations.of(context)!.statement,
                style: TextStyle(
                  color: AppColor.primaryColor,
                  fontSize: screenWidth * 0.06,
                  fontFamily: "cairoFonts",
                ),
                textAlign: TextAlign.center,
              ),
            ),
            (screenHeight * 0.03).height,
            Center(
              child: Container(
                height: 450,
                width:330,
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.06,
                  vertical: screenHeight * 0.08,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColor.borderColor),
                  borderRadius: BorderRadius.circular(screenWidth * 0.05),
                ),
                child: !_loading
                    ? statements.isNotEmpty ? ClipRRect(
                        borderRadius: BorderRadius.circular(screenWidth * 0.06),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColor.borderColor),
                            borderRadius:
                                BorderRadius.circular(screenWidth * 0.05),
                          ),
                          child: _image(screenHeight),
                        ),
                      ) : Center(child: Image.asset('assets/images/noData.png'),)
                    : const Center(
                        child: CircularProgressIndicator(color: AppColor.primaryColor,),
                      ),
              ),
            ),
            (screenHeight * 0.05).height,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GradientButton(
                  text: AppLocalizations.of(context)!.download,
                  onPressed: () async => await _download(),
                ),
                GradientButton(
                  text: AppLocalizations.of(context)!.share,
                  onPressed: () async => await _share(),
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }

  Future<void> _download() async {
    try {
      String link = statements.first.publicUrl ?? '';

      /// Download
      await downloadAndSaveImage(link);
      showSnackBar(context,
          message: AppLocalizations.of(context)!.downloadSuccessfully,
          error: false);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _share() async {
    try {
      String link = statements.first.publicUrl ?? '';

      /// Share
      var file = await convertLinkToFile(link);
      print(file.path);
      await shareThisFile(file);
    } catch (e) {
      print(e.toString());
    }
  }
}
