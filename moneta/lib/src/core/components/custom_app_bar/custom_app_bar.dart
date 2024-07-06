import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final String? subTitle;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final bool? isIconSearch;
  final bool isCloseSearchable;
  final bool isSearchable;
  final bool? isNotification;
  final double appBarHeigth;
  final bool isPageBack;

  final void Function(String)? onChanged;

  final Widget? textFormField;

  const CustomAppBar({
    super.key,
    required this.title,
    this.subTitle,
    required this.scaffoldKey,
    this.isIconSearch = false,
    this.appBarHeigth = 75,
    this.isPageBack = false,
    this.isCloseSearchable = false,
    this.isSearchable = false,
    this.isNotification = true,
    this.onChanged,
    this.textFormField,
  });

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(appBarHeigth);
}

class _CustomAppBarState extends State<CustomAppBar>
    with TickerProviderStateMixin {
  late bool isSearchable;
  late bool isCloseSearchable;

  int _notificationCount = 0;

  late AnimationController _controller;
  bool _hasUnreadNotifications =
      false; // Variável para controlar se há notificações não lidas

  @override
  void initState() {
    super.initState();
    isSearchable = false;
    isCloseSearchable = widget.isCloseSearchable;

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..repeat(reverse: true);

    // Inicializa o contador de notificações aqui
    _updateNotificationCount();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Inicializa o contador de notificações aqui
    _updateNotificationCount();

    // Registra um listener para atualizações no contador de notificações
    // Provider.of<NotificationController>(context, listen: false)
    //     .addListener(_updateNotificationCount);
  }

  @override
  void dispose() {
    // Remove o listener ao descartar o widget
    // Provider.of<NotificationController>(context, listen: false)
    //     .removeListener(_updateNotificationCount);

    _controller.dispose(); // Dispose do controlador de animação

    super.dispose();
  }

  void _updateNotificationCount() {
    setState(() {
      // _notificationCount =
      //     Provider.of<NotificationController>(context, listen: false)
      //         .notificationCountList
      //         .where((notification) => !notification.wasRead!)
      //         .length;

      // Atualiza a variável de controle
      _hasUnreadNotifications = _notificationCount > 0;

      // Inicia ou para a animação baseado na variável de controle
      if (_hasUnreadNotifications) {
        _controller.repeat(reverse: true);
      } else {
        _controller.reset();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    isCloseSearchable = isSearchable == widget.isCloseSearchable ? false : true;
    isSearchable = false;
    return _appBar();
  }

  Widget _appBar() {
    return Container(
      margin: const EdgeInsets.only(top: 5),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: _boxDecoration(),
      child: SafeArea(
        child: Column(
          children: [
            _topBar(),
          ],
        ),
      ),
    );
  }

  BoxDecoration _boxDecoration() {
    return const BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Color.fromARGB(255, 97, 97, 97),
          blurRadius: 4,
          offset: Offset(0, 2),
        ),
      ],
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
      color: Color(0xFF618a4f),
    );
  }

  Widget _topBar() {
    return Row(
      children: [
        widget.isPageBack == true
            ? SizedBox(
                height: 24,
                width: 24,
                child: InkWell(
                  child: const Icon(Icons.arrow_back_ios, size: 18),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
              )
            : const SizedBox(),
        isCloseSearchable == true
            ? Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: ListTile(
                    visualDensity:
                        const VisualDensity(horizontal: 0, vertical: -4),
                    title: Text(
                      widget.title,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: widget.subTitle.toString() != "null"
                        ? Text(
                            widget.subTitle.toString(),
                            style: const TextStyle(
                                color: Color.fromARGB(255, 195, 220, 200),
                                fontSize: 10,
                                fontWeight: FontWeight.w600),
                          )
                        : const SizedBox(),
                  ),
                ),
              )
            : const SizedBox(),
        isCloseSearchable == false
            ? Expanded(
                child: Container(
                  padding: const EdgeInsets.only(top: 10),
                  child: widget.textFormField,
                ),
              )
            : const SizedBox(),
        Row(children: [
          widget.isIconSearch == true && isCloseSearchable == true
              ? SizedBox(
                  height: 24,
                  width: 24,
                  child: IconButton(
                      padding: const EdgeInsets.all(0.0),
                      iconSize: 18,
                      icon: const Icon(
                        Icons.search,
                        size: 18,
                        color: Colors.white,
                      ),
                      tooltip: 'Buscar',
                      onPressed: () {
                        setState(() {
                          isSearchable = true;
                          isCloseSearchable = !isCloseSearchable;
                        });
                      }),
                )
              : const SizedBox(),
          isCloseSearchable == true
              ? SizedBox(
                  height: 24,
                  width: 24,
                  child: widget.isNotification!
                      ? IconButton(
                          padding: const EdgeInsets.all(0.0),
                          iconSize: 18,
                          icon: badges.Badge(
                            position:
                                badges.BadgePosition.topEnd(top: -15, end: -6),
                            showBadge: _notificationCount > 0 ? true : false,
                            badgeContent: Text(
                              _notificationCount.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ), // Cor do texto do badge
                            ),
                            child: RotationTransition(
                              turns: _hasUnreadNotifications
                                  ? Tween(begin: -0.1, end: 0.1)
                                      .animate(_controller)
                                  : const AlwaysStoppedAnimation(
                                      0), // Sem animação quando não há notificações não lidas
                              child: const Icon(
                                Icons.notifications,
                                size: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          tooltip: 'Notificações',
                          onPressed: () {},
                        )
                      : const SizedBox(),
                )
              : const SizedBox(),
          isCloseSearchable == true
              ? SizedBox(
                  height: 24,
                  width: 24,
                  child: IconButton(
                    padding: const EdgeInsets.all(0.0),
                    iconSize: 18,
                    icon: const Icon(
                      Icons.settings,
                      size: 18,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      widget.scaffoldKey.currentState!.openEndDrawer();
                    },
                  ),
                )
              : const SizedBox(),
          const SizedBox(),
        ]),
      ],
    );
  }

  bool getIsSeachable() {
    var isSeachable = false;

    if (widget.isSearchable && !widget.isCloseSearchable ||
        widget.isSearchable && widget.isCloseSearchable) {
      isSeachable = true;
    }

    return isSeachable;
  }
}
