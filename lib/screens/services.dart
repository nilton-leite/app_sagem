import 'package:app_sagem/components/services_card.dart';
import 'package:flutter/material.dart';

// class Services extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return CustomScrollView(
//       slivers: <Widget>[
//         const SliverAppBar(
//           pinned: true,
//           expandedHeight: 250.0,
//           flexibleSpace: FlexibleSpaceBar(
//             title: Text('Serviços'),
//           ),
//         ),
//         SliverGrid(
//           gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
//             maxCrossAxisExtent: 200.0,
//             mainAxisSpacing: 0.0,
//             crossAxisSpacing: 8.0,
//             childAspectRatio: 1.0,
//           ),
//           delegate: SliverChildBuilderDelegate(
//             (BuildContext context, int index) {
//               return ServicesCard(option: options[index]);
//             },
//             childCount: options.length,
//           ),
//         ),
//       ],
//     );
//   }
// }

class Services extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Serviços',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: List.generate(options.length, (index) {
          return Center(
            child: ServicesCard(option: options[index]),
          );
        }),
      ),
    );
  }
}

const List<Option> options = const <Option>[
  const Option(titulo: 'Carro', icon: Icons.directions_car),
  const Option(titulo: 'Bike', icon: Icons.directions_bike),
  const Option(titulo: 'Barco', icon: Icons.directions_boat),
  const Option(titulo: 'Ônibux', icon: Icons.directions_bus),
  const Option(titulo: 'Trem', icon: Icons.directions_railway),
  const Option(titulo: 'Andar', icon: Icons.directions_walk),
  const Option(titulo: 'Carro', icon: Icons.directions_car),
  const Option(titulo: 'Bike', icon: Icons.drafts),
  const Option(titulo: 'Barco', icon: Icons.dvr),
  const Option(titulo: 'Copy', icon: Icons.copyright),
  const Option(titulo: 'Train', icon: Icons.cloud_off),
  const Option(titulo: 'Car', icon: Icons.directions_car),
  const Option(titulo: 'Bike', icon: Icons.directions_bike),
  const Option(titulo: 'Barco', icon: Icons.directions_boat),
  const Option(titulo: 'Ônibus', icon: Icons.directions_bus),
  const Option(titulo: 'Trem', icon: Icons.directions_railway),
  const Option(titulo: 'Andar', icon: Icons.directions_walk),
  const Option(titulo: 'Carro', icon: Icons.directions_car),
  const Option(titulo: 'Bike', icon: Icons.drafts),
  const Option(titulo: 'Barco', icon: Icons.dvr),
  const Option(titulo: 'Barco', icon: Icons.dvr),
  const Option(titulo: 'Barco', icon: Icons.dvr),
  const Option(titulo: 'Barco', icon: Icons.dvr),
  const Option(titulo: 'Barco', icon: Icons.dvr),
  const Option(titulo: 'Barco', icon: Icons.dvr),
  const Option(titulo: 'Barco', icon: Icons.dvr),
  const Option(titulo: 'Barco', icon: Icons.dvr),
  const Option(titulo: 'Barco', icon: Icons.dvr),
  const Option(titulo: 'Barco', icon: Icons.dvr),
  const Option(titulo: 'Barco', icon: Icons.dvr),
  const Option(titulo: 'Barco', icon: Icons.dvr),
  const Option(titulo: 'Barco', icon: Icons.dvr),
  const Option(titulo: 'Barco', icon: Icons.dvr),
  const Option(titulo: 'Barco', icon: Icons.dvr),
  const Option(titulo: 'Barco', icon: Icons.dvr),
  const Option(titulo: 'Barco', icon: Icons.dvr),
  const Option(titulo: 'Barco', icon: Icons.dvr),
  const Option(titulo: 'Barco', icon: Icons.dvr),
  const Option(titulo: 'Barco', icon: Icons.dvr),
  const Option(titulo: 'Barco', icon: Icons.dvr),
  const Option(titulo: 'Barco', icon: Icons.dvr),
  const Option(titulo: 'Barco', icon: Icons.dvr),
  const Option(titulo: 'Barco', icon: Icons.dvr),
  const Option(titulo: 'Barco', icon: Icons.dvr),
  const Option(titulo: 'Barco', icon: Icons.dvr),
  const Option(titulo: 'Barco', icon: Icons.dvr),
  const Option(titulo: 'Barco', icon: Icons.dvr),
  const Option(titulo: 'Barco', icon: Icons.dvr),
];
