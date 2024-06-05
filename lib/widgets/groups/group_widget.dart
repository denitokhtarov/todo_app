import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/themes/theme_checker.dart';
import 'package:todo_app/widgets/group_form/group_form_widget.dart';
import 'package:todo_app/widgets/groups/groups_widget_model.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class GroupWidget extends StatelessWidget {
  const GroupWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CupertinoPageScaffold(
        child: CustomScrollView(
          slivers: [
            CupertinoSliverNavigationBar(
              stretch: true,
              largeTitle: const Text('Группы'),
              border: const Border(),
              trailing: CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: const Text(
                    'Править',
                    style: TextStyle(
                      color: CupertinoColors.systemYellow,
                    ),
                  ),
                  onPressed: () {}),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    CupertinoSearchTextField(
                      onSubmitted: (String value) {},
                      placeholder: 'Поиск',
                    ),
                    const SizedBox(height: 20),
                    const GroupListWidget(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: const BottomSheetWidget(),
    );
  }
}

class BottomSheetWidget extends StatefulWidget {
  const BottomSheetWidget({
    super.key,
  });

  @override
  State<BottomSheetWidget> createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          color: isDarkTheme(context)
              ? Colors.black
              : CupertinoColors.secondarySystemBackground,
          borderRadius: BorderRadius.circular(0)),
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const GroupFormWidget(),
            IconButton(
                onPressed: () {},
                icon: const Icon(CupertinoIcons.square_pencil),
                color: CupertinoColors.systemYellow),
          ],
        ),
      ),
    );
  }
}

class GroupListWidget extends StatelessWidget {
  const GroupListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final groupsCount = Provider.of<GroupsWidgetModel>(context).groups.length;
    return Container(
      decoration: BoxDecoration(
        color: groupListWidgetBackgroundColor(context),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListView.separated(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: groupsCount,
        separatorBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(left: 60),
            child: Container(
              height: 0.1,
              color: CupertinoColors.systemGrey,
            ),
          );
        },
        itemBuilder: (BuildContext context, int index) {
          return GroupListRowWidget(
            index: index,
          );
        },
      ),
    );
  }
}

class GroupListRowWidget extends StatelessWidget {
  final int index;
  const GroupListRowWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final group = Provider.of<GroupsWidgetModel>(context).groups[index];
    return Slidable(
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            onPressed: (context) =>
                Provider.of<GroupsWidgetModel>(context, listen: false)
                    .delete(index),
            backgroundColor: Colors.red,
            icon: CupertinoIcons.delete,
          )
        ],
      ),
      child: CupertinoListTile(
        leading: const Icon(
          CupertinoIcons.folder,
          color: CupertinoColors.systemYellow,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(group.name),
            const Padding(
              padding: EdgeInsets.only(right: 5),
              child: Text(
                '0',
                style: TextStyle(color: CupertinoColors.systemGrey2),
              ),
            )
          ],
        ),
        trailing: const Icon(
          CupertinoIcons.chevron_right,
          size: 16,
          color: CupertinoColors.systemGrey,
        ),
      ),
    );
  }
}
