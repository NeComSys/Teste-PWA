import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:moneta/src/core/components/custom_app_bar/custom_app_bar.dart';
import 'package:moneta/src/core/controllers/version_controller.dart';
import 'package:moneta/src/shared/auth/models/auth_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String title;
  late String subTitle;

  AuthResponseModel userSharedPreferences = AuthResponseModel();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late PageController _pageController;
  int _actualPage = 0;

  late final VersionController controllerVersion;

  final List<Map<String, dynamic>> _menuItems = [];
  late final List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();

    title = 'Despesas Administrativas';
    subTitle = 'Reembolso de Despesas';

    _pageController = PageController(initialPage: _actualPage);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool showAppBar = true; // Variável para controlar a exibição da AppBar

    // Verifica se a página atual corresponde ao código "MON-05"
    if (_menuItems.isNotEmpty && _actualPage < _menuItems.length) {
      String currentPageCode = _menuItems[_actualPage]['code'];
      if (currentPageCode == 'MON-05') {
        showAppBar =
            false; // Oculta a AppBar se a página atual corresponder ao código "MON-05"
      }
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 238, 238, 238),
      key: _scaffoldKey,
      appBar: showAppBar
          ? CustomAppBar(
              title: title,
              subTitle: subTitle,
              scaffoldKey: _scaffoldKey,
              isIconSearch: false,
              isCloseSearchable: true,
              isSearchable: false,
            )
          : null,
      endDrawer: Drawer(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.zero,
            bottomLeft: Radius.zero,
          ),
        ),
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(userSharedPreferences.fullName ?? ''),
              accountEmail: Text(userSharedPreferences.email ?? ''),
              decoration: const BoxDecoration(
                color: Color(0xFF618a4f),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                hoverColor: const Color.fromARGB(121, 76, 175, 79),
                dense: true,
                visualDensity: const VisualDensity(vertical: -4),
                leading: const Icon(Icons.security),
                title: const Text('Políticas de Reembolso'),
                onTap: () async {
                  var textPolicy = 'asdfasdfadfadf';
                  if (textPolicy != null) {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        insetPadding: const EdgeInsets.all(10.0),
                        contentPadding: EdgeInsets.zero,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        content: Builder(
                          builder: (context) {
                            var height = MediaQuery.of(context).size.height;
                            var width = MediaQuery.of(context).size.width;

                            return Container(
                              height: height,
                              width: width,
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Termos das Políticas de Reembolso',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  Flexible(
                                    child: SingleChildScrollView(
                                      child: HtmlWidget(
                                        textPolicy!,
                                        textStyle:
                                            const TextStyle(fontSize: 12),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Fechar'),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                hoverColor: const Color.fromARGB(121, 76, 175, 79),
                dense: true,
                visualDensity: const VisualDensity(vertical: -4),
                leading: const Icon(Icons.logout),
                title: const Text('Sair'),
                onTap: () async {
                  final shared = await SharedPreferences.getInstance();
                  shared.remove('AuthModel');
                  Navigator.of(context).restorablePushReplacementNamed('/auth');
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Spacer(), // Adiciona um espaço vazio
                      const Divider(
                          color:
                              Colors.black45), // Adiciona uma linha divisória
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${AppLocalizations.of(context)!.system_version} ${controllerVersion.version} - ${controllerVersion.dateUpdated}',
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (value) {
          onPageChanged(value, _menuItems);
        },
        children: _pages,
      ),
      bottomNavigationBar: _menuItems.length >= 2
          ? BottomNavigationBar(
              backgroundColor: const Color(0xFF618a4f),
              unselectedItemColor: Colors.white70,
              selectedItemColor: Colors.white,
              items: _menuItems
                  .map((item) => BottomNavigationBarItem(
                        icon: Icon(item['icon']),
                        label: item['label'],
                      ))
                  .toList(),
              currentIndex: _actualPage,
              onTap: navigateToPage,
            )
          : const SizedBox.shrink(),
    );
  }

  Map<String, Object>? bottomNavigationBarMenus(itens) {
    switch (itens.code) {
      case 'MON-02':
        return {
          'label': 'Administrativo',
          'icon': Icons.add_chart,
          'code': itens.code,
        };
      case 'MON-03':
        return {
          'label': 'Obra',
          'icon': Icons.add_home_work,
          'code': itens.code,
        };
      case 'MON-05':
        return {
          'label': 'Glosa',
          'icon': Icons.block,
          'code': itens.code,
        };
      default:
        return null;
    }
  }

  Widget? initializePages(items) {
    switch (items.code) {
      case 'MON-02':
        return const SizedBox(); // const AdministrativeExpenseReportPage();
      case 'MON-03':
        return const SizedBox(); // WorkExpenseReportPage();
      case 'MON-05':
        return const SizedBox(); // DisallowExpenseListPage();
      default:
        return null;
    }
  }

  void navigateToPage(int page) {
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.linear,
    );
  }

  void onPageChanged(int page, List<Map<String, dynamic>> menu) {
    String tempTitle = '';
    switch (menu[page]['code']) {
      case 'MON-02':
        tempTitle = 'Despesas Administrativas';
        subTitle = 'Reembolso de Despesas';
        break;
      case 'MON-03':
        tempTitle = 'Despesas de Obra';
        subTitle = 'Reembolso de Despesas';
        break;
      case 'MON-05':
        tempTitle = 'Glosa';
        subTitle = 'Reembolso de Despesas';
        break;
    }
    setState(() {
      _actualPage = page;
      title = tempTitle;
    });
  }
}
