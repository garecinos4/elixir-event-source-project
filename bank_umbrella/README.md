# BankUmbrella - Elixir project with event source
Es una aplicación básica en Elixir que implementa Event Sourcing usando Commanded, una librería popular para manejar eventos en aplicaciones basadas en CQRS (Command Query Responsibility Segregation).

La aplicación es un sistema de gestión de cuentas bancarias donde puedes:
1. Crear una cuenta
2. Depositar dinero
3. Retirar dinero
Se almacenan los eventos en PostgreSQL usando eventstore como backend de eventos.

## Utilidades
1. PostgreSQL
    Create a docker compose docker-compose-local.yml and run it
    ```
    docker-compose -f docker-compose-local.yml build
    
    docker-compose -f docker-compose-local.yml up

    docker container start bank_umbrella-postgres-1
    ```
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

- bank/ → Contiene la lógica de negocios (eventos, comandos, agregados).
- bank_eventstore/ → Administra el almacenamiento de eventos con PostgreSQL.
- bank_web/ → Expone endpoints en Phoenix para interactuar con el sistema.

#### Diseño
- bank → Lógica del dominio (eventos, comandos, agregados, router).
- bank_eventstore → Configuración del almacenamiento de eventos con PostgreSQL.
- bank_web → API en Phoenix para interactuar con el sistema.

####  1. Iniciar PostgreSQL y configurar EventStore
1. Crear la base de datos para eventstore
```
mix do deps.get, event_store.create, event_store.init
```
2. Crear la base de datos para bank
```
mix ecto.create
```
 
 ** Los pasos anteriores se agregaran a un alias, ir a la seccion de [aliases](#aliases).

#### 2. Ejecutar la aplicación
Desde la raíz del umbrella (bank_umbrella/):

```
mix phx.server

```
Esto ejecutará todas las apps del umbrella (bank, bank_eventstore, bank_web)

Access BankWebWeb Endpoint at http://localhost:4000


# Next Steps: 

## BankWeb

1. Agrega {:bank, in_umbrella: true} en el archivo apps/bank_web/mix.exs dentro de la lista de dependencias.
2. Corre mix deps.get en la raíz del umbrella.
3. Ejecuta mix phx.server para levantar el servidor.


## Aliases

Mix aliases en mix.exs del umbrella project para facilitar la ejecución y configuración de las apps. Ahora puedes usar:

mix setup → Instala dependencias, crea y migra la base de datos.
mix reset → Elimina y vuelve a crear la base de datos.
mix server → Inicia el servidor Phoenix.
