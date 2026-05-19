# Proyecto de Evaluación: Arquitectura Políglota en «EcoDrive»
El presente documento se presenta en calidad de documentación del proyecto de bases de datos noSQL estipulado, en el cual se evidenciará todos los puntos solicitados para la base de datos de EcoDrive. Analizando tres servicios dentro de la misma y adjudicando una base de datos políglota (un servicio dentro del documento no se trabajará debido a que la base de datos más adecuada para este no fue explicada en clase). Creando la BBDD del servicio e insertando datos mediante la ayuda de una Inteligencia Artificial generativa; para posteriormente analizar y corregir errores comunes que comete la misma. Presentando los Scripts de carca con sus consultas debidas para demostrar el correcto funcionamiento de la BBDD.

## Servicio A: Catálogo
### Justificación Arquitectónica:
Considerando las necesidades del servicio A, se ha optado por el uso de mongodb debido a que {explicar las diferencias con respecto a las otras bases de datos para llegar a la conclusión y justificación el uso de mongodb para este ejemplo}

- Campos incrustados dentro de Mongo: {introducir los campos incrustados analizados a partir del anexo 1}

### Análisis de Auditoría: 
{generar un parafraseo, evitando sonar como una ia, basandose con la redaccion de la introducción con el texto del anexo 2}

### Scripts de Carga y Consultas:
{scripts del anexo 1}


## Anexo 1
```
// Seleccionar o crear la base de datos de EcoDrive
use ecodrive_db;

// Insertar 3 vehículos aprovechando la flexibilidad del esquema (esquema dinámico)
db.vehiculos.insertMany([
  {
    _id: "VEH-PAT-001",
    tipo: "patinete",
    marca: "Xiaomi",
    modelo: "Electric Scooter 4 Pro",
    estado: "disponible",
    // Atributo específico de patinete
    limite_peso_kg: 120, 
    // Historial de mantenimiento embebido como un array de objetos (Agregado)
    historial_mantenimiento: [
      {
        fecha: ISODate("2026-03-10T08:30:00Z"),
        tipo_reparacion: "Ajuste de frenos",
        mecanico: "Carlos Gómez",
        piezas_reemplazadas: ["Pastilla de freno trasera"],
        costo: 25.50
      },
      {
        fecha: ISODate("2026-05-01T14:20:00Z"),
        tipo_reparacion: "Cambio de neumático",
        mecanico: "Ana Martínez",
        piezas_reemplazadas: ["Cámara de aire 10''"],
        costo: 15.00
      }
    ]
  },
  {
    _id: "VEH-BIC-042",
    tipo: "bicicleta",
    marca: "Orbea",
    modelo: "Diem 20",
    estado: "en_mantenimiento",
    // Atributos específicos de bicicleta
    cantidad_marchas: 9,
    tiene_cesta: true,
    historial_mantenimiento: [
      {
        fecha: ISODate("2026-04-15T10:00:00Z"),
        tipo_reparacion: "Engrase de cadena y ajuste de cambios",
        mecanico: "Carlos Gómez",
        piezas_reemplazadas: [], // Estructura flexible: sin piezas aquí
        costo: 10.00
      }
    ]
  },
  {
    _id: "VEH-COCON-105",
    tipo: "coche",
    marca: "Tesla",
    modelo: "Model 3",
    estado: "disponible",
    // Atributos específicos de coche
    tipo_combustible: "Eléctrico",
    capacidad_pasajeros: 5,
    autonomia_km: 491,
    historial_mantenimiento: [
      {
        fecha: ISODate("2026-02-20T09:00:00Z"),
        tipo_reparacion: "Revisión general de software y sensores",
        mecanico: "Laura Peña",
        detalles_tecnicos: { version_firmware: "v12.3.4", calibracion: "OK" }, // Campos completamente dinámicos
        piezas_reemplazadas: [],
        costo: 0.00
      }
    ]
  }
]);
```
## Anexo 2
2. Auditoría Crítica: Errores Típicos de una IA (Fase 2)
Si le hubieras pedido este código a una IA genérica sin supervisión, muy probablemente habría caído en el "Sesgo Relacional". Estos son los dos errores de diseño más comunes que habría cometido y cómo los solucionamos para respetar los principios NoSQL:
Antipatrón 1: Normalización Encubierta (Colecciones Separadas)
El error de la IA: Una IA con mentalidad SQL habría creado dos colecciones: una colección vehiculos y otra colección independiente llamada mantenimientos o reparaciones, vinculadas mediante un vehiculo_id (haciendo un "join manual" mediante $lookup en las consultas).
Por qué es un error en MongoDB: En EcoDrive, cada vez que el equipo de taller abre la ficha de un vehículo para registrar o revisar un arreglo, se necesita ver su historial de forma inmediata. Separar los datos obliga a la base de datos a hacer lecturas en múltiples zonas del disco de forma innecesaria.
La corrección aplicada: Aplicamos Embedding (Incrustación). Al meter el historial_mantenimiento como un Array dentro del documento del vehículo, garantizamos una lectura atómica en un solo viaje al disco, optimizando drásticamente el rendimiento del sistema.
Antipatrón 2: Tabla de Atributos Clave-Valor o "Tabla Universal"
El error de la IA: Al notar que un patinete, una bici y un coche tienen campos radicalmente distintos, muchas IA entran en pánico con los esquemas y diseñan una estructura rígida con un array genérico de propiedades, por ejemplo: atributos: [{clave: "limite_peso", valor: 120}, {clave: "tipo_combustible", valor: "Electrico"}].
Por qué es un error en MongoDB: Esto anula por completo el poder de indexación de MongoDB y vuelve las consultas extremadamente engorrosas de escribir y penalizadas en rendimiento.
La corrección aplicada: Aprovechamos el Esquema Dinámico (Schemaless) nativo de MongoDB. Los documentos conviven en la misma colección compartiendo campos core (_id, marca, modelo) , pero cada uno declara sus propiedades específicas de forma directa (como datos de primer nivel). Esto nos permite indexar de forma nativa campos como tipo_combustible y ejecutar la consulta $exists de manera ultra veloz.

### Ejecución y visualización:


