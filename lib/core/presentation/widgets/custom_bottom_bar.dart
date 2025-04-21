part of '../pages/base_page_with_bottom_bar.dart';

final class CustomBottomBar extends StatelessWidget {
  const CustomBottomBar({
    required this.onTap,
    this.currentIndex = 0,
    super.key,
  });
  final int currentIndex;
  final void Function(int?) onTap;

  static const _iconPadding = EdgeInsets.only(bottom: 4);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 102,
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey)),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.black87,
          currentIndex: currentIndex,
          onTap: onTap,
          items: const [
            BottomNavigationBarItem(
              icon: Padding(
                padding: _iconPadding,
                child: Icon(Icons.home_outlined),
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: _iconPadding,
                child: Icon(Icons.settings_outlined),
              ),
              label: 'Settings',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: _iconPadding,
                child: Icon(Icons.list_outlined),
              ),
              label: 'Todo',
            ),
          ],
        ),
      ),
    );
  }
}
