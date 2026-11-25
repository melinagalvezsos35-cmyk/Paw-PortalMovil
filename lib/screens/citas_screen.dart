import 'package:flutter/material.dart';

class CitasScreen extends StatefulWidget {
  const CitasScreen({super.key});

  @override
  State<CitasScreen> createState() => _CitasScreenState();
}

class _CitasScreenState extends State<CitasScreen> {
  String _filtroSeleccionado = 'Próximas';

  // Lista editable en memoria (sin final para poder agregar nuevas citas)
final _citas = [
    {
      'mascota': 'Cookie',
      'servicio': 'Consulta General',
      'veterinaria': 'Veterinaria Huellitas',
      'fecha': '15 Nov 2026',
      'hora': '10:30 AM',
      'estado': 'Confirmada',
    },
    {
      'mascota': 'Max',
      'servicio': 'Vacunación Anual',
      'veterinaria': 'Clínica PetCare Cancún',
      'fecha': '20 Nov 2026',
      'hora': '04:00 PM',
      'estado': 'Solicitada',
    },
    {
      'mascota': 'Cookie',
      'servicio': 'Estética y Baño',
      'veterinaria': 'Veterinaria Huellitas',
      'fecha': '02 Oct 2026',
      'hora': '11:00 AM',
      'estado': 'Atendida',
    },
  ];

  void _mostrarModalNuevaCita() {
    String mascotaSeleccionada = 'Cookie';
    final servicioController = TextEditingController();
    final fechaController = TextEditingController();
    final horaController = TextEditingController();

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
              'Agendar Nueva Cita',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: mascotaSeleccionada,
              decoration: const InputDecoration(
                labelText: 'Mascota',
                border: OutlineInputBorder(),
              ),
              items: ['Cookie', 'Max']
                  .map((m) => DropdownMenuItem(value: m, child: Text(m)))
                  .toList(),
              onChanged: (valor) {
                if (valor != null) mascotaSeleccionada = valor;
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: servicioController,
              decoration: const InputDecoration(
                labelText: 'Servicio o Motivo',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: fechaController,
                    decoration: const InputDecoration(
                      labelText: 'Fecha',
                      prefixIcon: Icon(Icons.calendar_today),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                    controller: horaController,
                    decoration: const InputDecoration(
                      labelText: 'Hora',
                      prefixIcon: Icon(Icons.access_time),
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
                if (servicioController.text.isEmpty ||
                    fechaController.text.isEmpty ||
                    horaController.text.isEmpty) {
                  return;
                }

                setState(() {
                  _citas.insert(0, {
                    'mascota': mascotaSeleccionada,
                    'servicio': servicioController.text,
                    'veterinaria': 'Veterinaria Huellitas',
                    'fecha': fechaController.text,
                    'hora': horaController.text,
                    'estado': 'Solicitada',
                  });
                });

                Navigator.pop(context);
              },
              child: const Text('Confirmar Solicitud'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final citasFiltradas = _citas.where((cita) {
      if (_filtroSeleccionado == 'Próximas') {
        return cita['estado'] != 'Atendida';
      }
      return cita['estado'] == 'Atendida';
    }).toList();

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text('Mis Citas', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.teal.shade700,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _mostrarModalNuevaCita,
        backgroundColor: Colors.teal.shade700,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Nueva Cita'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: ['Próximas', 'Historial'].map((filtro) {
                final activo = _filtroSeleccionado == filtro;
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: ChoiceChip(
                    label: Text(filtro),
                    selected: activo,
                    selectedColor: Colors.teal.shade100,
                    labelStyle: TextStyle(
                      color: activo ? Colors.teal.shade900 : Colors.grey.shade700,
                      fontWeight: FontWeight.bold,
                    ),
                    onSelected: (_) => setState(() => _filtroSeleccionado = filtro),
                  ),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: citasFiltradas.length,
              itemBuilder: (context, index) {
                final cita = citasFiltradas[index];
                final esConfirmada = cita['estado'] == 'Confirmada';

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                '${cita['mascota']} • ${cita['servicio']}',
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: esConfirmada ? Colors.green.shade100 : Colors.amber.shade100,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                cita['estado']!,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: esConfirmada ? Colors.green.shade800 : Colors.amber.shade900,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          cita['veterinaria']!,
                          style: TextStyle(color: Colors.grey.shade700),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Icon(Icons.calendar_today, size: 16, color: Colors.teal.shade700),
                            const SizedBox(width: 6),
                            Text(cita['fecha']!),
                            const SizedBox(width: 16),
                            Icon(Icons.access_time, size: 16, color: Colors.teal.shade700),
                            const SizedBox(width: 6),
                            Text(cita['hora']!),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}