import 'package:flutter/material.dart';

class DraggableListPage extends StatefulWidget {
  const DraggableListPage({Key? key}) : super(key: key);

  @override
  State<DraggableListPage> createState() => _DraggableListPageState();
}

class _DraggableListPageState extends State<DraggableListPage> {
  final List myTiles = ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'];

  void updateTiles(int oldIndex, int newIndex) {
    setState(() {
      if(oldIndex < newIndex) {
        newIndex--;
      }
      final tile = myTiles.removeAt(oldIndex);
      myTiles.insert(newIndex, tile);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Draggable list"),
      ),
      body: ReorderableListView(
          children: [for(final tile in myTiles) Column(
            key: ValueKey(tile),
            children: [
              ListTile(
                leading: CircleAvatar(child: Text(tile),),
                title: const Text("Headline"),
                subtitle: const Text('Supporting text'),
                key: ValueKey(tile),
                trailing: const Icon(Icons.drag_handle),
              ),
              const Divider(height: 0,)
            ],
          ),
          ],
          onReorder: (oldIndex, newIndex) => updateTiles(oldIndex, newIndex)),
    );
  }
}
