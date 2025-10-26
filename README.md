Rick and Morty Tech Test

Rick and Morty Tech Test es una aplicación desarrollada en SwiftUI que consume la API oficial de Rick and Morty para mostrar una lista de personajes, sus detalles y episodios correspondientes. La aplicación está diseñada con arquitectura moderna, async/await, y un enfoque en la experiencia de usuario reactiva.

Funcionalidades actuales

Listado de personajes con soporte para búsqueda y filtrado por favoritos.

Detalle de cada personaje, incluyendo nombre, especie, género y episodios en los que aparece.

Interacción con la API usando un ServiceManager genérico que maneja solicitudes HTTP y decodificación de JSON.

Interfaz construida con SwiftUI y LazyVGrid para un diseño responsivo.

Manejo de conectividad de red con NetworkMonitor para mostrar vistas alternativas cuando no hay conexión.

Posibilidad de marcar personajes como favoritos en memoria.

Tecnologías utilizadas

Swift 5.9+

SwiftUI

Combine

Alamofire para las peticiones HTTP

JSONDecoder con keyDecodingStrategy para mapear los datos de la API

Arquitectura basada en ViewModel (ObservableObject) para separar lógica de negocio y vista

Funcionalidades pendientes

Integración con MapKit: se planea mostrar la ubicación de los personajes u otros elementos geográficos relacionados con la serie.

Persistencia con Core Data: actualmente los favoritos se manejan en memoria; se implementará Core Data para mantener el estado de favoritos de manera persistente entre sesiones.

Propósito

Esta aplicación sirve como demostración de:

Consumo de APIs REST modernas con SwiftUI.

Manejo de estados de UI reactivos y asincrónicos.

Buenas prácticas en el manejo de datos y separación de responsabilidades.
