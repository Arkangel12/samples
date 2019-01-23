import 'package:flutter/material.dart';
import 'package:model_shopper/models/cart.dart';
import 'package:model_shopper/provider/provider.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Provide<int>(
          builder: (context, child, value) => Text('Catalog $value',
              style: Theme.of(context).textTheme.display4)),
      floating: true,
      actions: [
        IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () => Navigator.pushNamed(context, '/cart')),
      ],
    );
  }
}

class MyCatalog extends StatelessWidget {
  MyCatalog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          new MyAppBar(),
          SliverToBoxAdapter(child: SizedBox(height: 12)),
          SliverList(
              delegate:
                  SliverChildBuilderDelegate((_, index) => MyListItem(index))),
        ],
      ),
    );
  }
}

class MyListItem extends StatelessWidget {
  final int index;

  final Item item;

  MyListItem(
    this.index, {
    Key key,
  })  : item = Item(index),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: LimitedBox(
        maxHeight: 48,
        child: Row(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                color: Colors.primaries[index % Colors.primaries.length],
              ),
            ),
            SizedBox(width: 24),
            Expanded(
              child: Text(item.name, style: Theme.of(context).textTheme.title),
            ),
            SizedBox(width: 24),
            _AddButton(item: item),
          ],
        ),
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  final Item item;

  const _AddButton({
    Key key,
    @required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provide<CartModel>(
      builder: (context, _, cart) => FlatButton(
            onPressed: cart.items.contains(item) ? null : () => cart.add(item),
            splashColor: Colors.yellow,
            child: Text(cart.items.contains(item) ? 'ADDED' : 'ADD'),
          ),
    );
  }
}
