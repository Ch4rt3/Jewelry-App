import 'package:flutter/material.dart';
import 'package:jewelry_app/models/producto.dart'; // Asegúrate de importar la clase Producto si está en un archivo separado

class ProductCard extends StatelessWidget {
  final Producto producto;

  const ProductCard({
    super.key,
    required this.producto,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
        bottom: 10,
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9), // Fondo blanco casi gris
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3), // Sombra ligera debajo
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Imagen del producto
            Container(
              height: 250,
              width: double.infinity, // Asegura que la imagen ocupe todo el ancho
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
                image: DecorationImage(
                  image: AssetImage(producto.imagenUrl), // Cambia a NetworkImage si es una URL
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(height: 10),

            // Título del producto
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  Text(
                    producto.nombre,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 5), // Espacio entre nombre y descripción
                  Text(
                    producto.descripcion,
                    style: const TextStyle(
                      fontSize: 14, // Ajusta el tamaño de fuente
                      color: Colors.grey, // Color gris para la descripción
                    ),
                  ),
                  const SizedBox(height: 10), // Espacio antes del precio
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.lightGreen.withOpacity(0.5), // Color celeste desvanecido
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '\$${producto.precio}', // Agregar símbolo de dólar al precio
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}
