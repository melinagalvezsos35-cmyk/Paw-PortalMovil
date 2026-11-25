import 'package:flutter/material.dart';

class MascotasScreen extends StatefulWidget {
  const MascotasScreen({super.key});

  @override
  State<MascotasScreen> createState() => _MascotasScreenState();
}

class _MascotasScreenState extends State<MascotasScreen> {
final _mascotas = [
    {
      'nombre': 'Cookie',
      'raza': 'Mestizo / Mediano',
      'edad': '3 años',
      'peso': '14.5 kg',
      'vacunas': 'Al día',
    },
    {
      'nombre': 'Max',
      'raza': 'Golden Retriever',
      'edad': '5 años',
      'peso': '28.0 kg',
      'vacunas': 'Próxima en 15 días',
    },
  ];

  void _mostrarModalNuevaMascota() {
    final nombreCtrl = TextEditingController();
    final razaCtrl = TextEditingController();
    final edadCtrl = TextEditingController();
    final pesoCtrl = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          left: 20,
          right: 20,
          top: 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Registrar Mascota',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: nombreCtrl,
              decoration: const InputDecoration(
                labelText: 'Nombre',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: razaCtrl,
              decoration: const InputDecoration(
                labelText: 'Raza',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: edadCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Edad (ej. 2 años)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: pesoCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Peso (ej. 10 kg)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal.shade700,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                if (nombreCtrl.text.isEmpty) return;
                setState(() {
                  _mascotas.add({
                    'nombre': nombreCtrl.text,
                    'raza': razaCtrl.text.isEmpty ? 'Mestizo' : razaCtrl.text,
                    'edad': edadCtrl.text.isEmpty ? '1 año' : edadCtrl.text,
                    'peso': pesoCtrl.text.isEmpty ? '10 kg' : pesoCtrl.text,
                    'vacunas': 'Al día',
                  });
                });
                Navigator.pop(context);
              },
              child: const Text('Guardar Mascota'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text('Mis Mascotas', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.teal.shade700,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            tooltip: 'Registrar mascota',
            onPressed: _mostrarModalNuevaMascota,
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _mascotas.length,
        itemBuilder: (context, index) {
          final mascota = _mascotas[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.teal.shade100,
                        child: Icon(Icons.pets, size: 32, color: Colors.teal.shade800),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              mascota['nombre']!,
                              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              mascota['raza']!,
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
                    ],
                  ),
                  const Divider(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _DatoMascota(titulo: 'Edad', valor: mascota['edad']!),
                      _DatoMascota(titulo: 'Peso', valor: mascota['peso']!),
                      _DatoMascota(titulo: 'Vacunas', valor: mascota['vacunas']!),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _DatoMascota extends StatelessWidget {
  final String titulo;
  final String valor;

  const _DatoMascota({required this.titulo, required this.valor});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(titulo, style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
        const SizedBox(height: 4),
        Text(valor, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      ],
    );
  }
}