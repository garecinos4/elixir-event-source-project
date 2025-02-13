# BankUmbrella - Elixir project with event source
Es una aplicación básica en Elixir que implementa Event Sourcing usando Commanded, una librería popular para manejar eventos en aplicaciones basadas en CQRS (Command Query Responsibility Segregation).

La aplicación es un sistema de gestión de cuentas bancarias donde puedes:

Crear una cuenta
Depositar dinero
Retirar dinero
Se almacenan los eventos en PostgreSQL usando eventstore como backend de eventos.

## Utilidades
1. PostgreSQL
2. EventStore
3. Event Sourcing con Commanded.

## Estructura del Umbrella Project
Umbrella Project en Elixir ayuda a organizar mejor la arquitectura, especialmente para un sistema basado en Event Sourcing con Commanded.

```
bank_umbrella/
├── apps/
│   ├── bank/            # Core de la lógica (eventos, comandos, agregados, router)
│   ├── bank_eventstore/ # Configuración del EventStore (almacenamiento de eventos)
│   ├── bank_web/        # API Phoenix para manejar comandos
```

## Pasos para crear el proyecto

### 1. Crear el Umbrella Project

```
mix new bank_umbrella --umbrella
cd bank_umbrella

```
### 2. Crear las apps dentro del umbrella
```
mix new apps/bank --module Bank
mix new apps/bank_eventstore --module Bank.EventStore
mix phx.new apps/bank_web --module BankWeb --no-ecto
```

### 3. Configurar cada app

bank/ → Contiene la lógica de negocios (eventos, comandos, agregados).
bank_eventstore/ → Administra el almacenamiento de eventos con PostgreSQL.
bank_web/ → Expone endpoints en Phoenix para interactuar con el sistema.

#### Diseño
bank → Lógica del dominio (eventos, comandos, agregados, router).
bank_eventstore → Configuración del almacenamiento de eventos con PostgreSQL.
bank_web → API en Phoenix para interactuar con el sistema.