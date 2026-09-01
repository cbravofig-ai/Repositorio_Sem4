# =============================================================================
# GUION DE CLASE — Semana 4 · Sesión 1: Data Frames
# Fundamentos de Programación para Análisis Económico · UdeC-EAN
#
# Nombre: Camila Bravo Figueroa      Fecha: 01-09-2026
#
# CÓMO USAR: corre cada línea con Cmd/Ctrl+Enter.
#   🔵 CORRE Y OBSERVA · ✏️ COMPLETA (____) · 🔮 PREDICE · 🟢 TU TURNO · ✅ Deberías ver
# =============================================================================


# -----------------------------------------------------------------------------
# BLOQUE A — ¿Qué es un data frame?
# -----------------------------------------------------------------------------
# Una TABLA rectangular: filas = observaciones, columnas = variables.
# Dos reglas: (1) todas las columnas del mismo largo; (2) cada columna un solo
# tipo, pero columnas distintas pueden ser de tipos distintos.


# -----------------------------------------------------------------------------
# BLOQUE B — Crear data frames
# -----------------------------------------------------------------------------
# Construimos el mini-dataset de trabajadores, columna por columna.
# 🔵 CORRE Y OBSERVA
trabajadores <- data.frame(
  region  = c("Ñuble", "Biobío", "Ñuble", "Maule"),
  sector  = c("Agricultura", "Servicios", "Comercio", "Agricultura"),
  educ    = c(12, 16, 8, 12),          # años de escolaridad
  edad    = c(34, 45, 52, 29),
  ingreso = c(450000, 920000, 380000, 510000),
  genero  = c("M", "F", "M", "F")
)
trabajadores

# 💡 Cada argumento de data.frame() es una COLUMNA (un vector), todos del mismo largo.

## Las dimensiones de la tabla ------------------------------------------------
# 🔵 CORRE Y OBSERVA
nrow(trabajadores)   # observaciones (filas)
ncol(trabajadores)   # variables (columnas)
dim(trabajadores)    # filas, columnas
names(trabajadores)  # nombres de columnas

# ✅ Deberías ver: 4 ... 6 ... "4 6" ... los 6 nombres de columna

mis_gastos <- data.frame(
  concepto = c("uber", "cafe", "cigarros", "almuerzos"),
  monto    = c(4000, 2700, 5000, 3000),
  esencial = c(FALSE, TRUE, TRUE, TRUE)
)

nrow(mis_gastos)   
ncol(mis_gastos)   
dim(mis_gastos)    
names(mis_gastos)

sum(mis_gastos$monto)
mean(mis_gastos$monto)

# -----------------------------------------------------------------------------
# BLOQUE C — Acceso: las tres formas
# -----------------------------------------------------------------------------

## $ — extraer una columna por nombre (la más usada) --------------------------
# 🔵 CORRE Y OBSERVA
trabajadores$ingreso          # el vector completo de ingresos
mean(trabajadores$ingreso)    # y se opera como cualquier vector (Semana 3)

# 💡 $ devuelve un VECTOR -> se le aplica todo lo de la Semana 3.

## [fila, col] — el sistema de coordenadas ------------------------------------
# Dejar un lado vacío = "todos".
# 🔵 CORRE Y OBSERVA
trabajadores[1, ]            # toda la fila 1 (un trabajador)
trabajadores[1, "ingreso"]   # una celda: ingreso del trabajador 1

# 🔮 PREDICE: ¿qué filas devuelve esta línea?
trabajadores[trabajadores$edad > 40, ]   # FILTRO: filas con edad > 40

# ✏️ COMPLETA: muestra solo las filas del sector "Servicios".
trabajadores[trabajadores$sector == "Servicios", ]

# Para invocar coordenadas dentro del data.frame [fila, columna]

mis_gastos[3, ]               # Si después de la coma está vacío, se invoca la 
# fila completa, o bien poniendo su nombre.

mis_gastos[1, 3]     # Se pide el elemento 3, de la columna " " (nombre o n°).

mis_gastos[mis_gastos$monto > 3500, ]

mis_gastos[mis_gastos$concepto == "uber", ]

## [[ ]] — equivalente a $ -----------------------------------------------------
# 🔵 CORRE Y OBSERVA
trabajadores[["ingreso"]]    # equivalente a trabajadores$ingreso

# Equivalente a trabajadores[, "ingreso"]

# 🟢 TU TURNO: muestra la fila 3 completa Y, por separado, la edad del trabajador 3.

trabajadores [[3]]
# Equivalente a trabajadores[3, ]

# -----------------------------------------------------------------------------
# BLOQUE D — Ejemplo económico aplicado
# -----------------------------------------------------------------------------
# 🔵 CORRE Y OBSERVA
trabajadores

mean(trabajadores$ingreso)                            # ingreso promedio
mean(trabajadores$ingreso[trabajadores$educ >= 12])   # solo educ >= 12 años

mean(mis_gastos$monto)
mean(mis_gastos$monto[mis_gastos$monto > 3000])

# Crear una COLUMNA DERIVADA (la base de todo análisis):
# 🔵 CORRE Y OBSERVA
trabajadores$ingreso_miles <- trabajadores$ingreso / 1000
trabajadores$estado_civil <- c("casado", "soltero", "casado", "divorciado")
trabajadores

# 💡 df$nueva <- ... crea una columna nueva. En S5 esto será mutate() de dplyr.

## Brecha de ingreso por sector -----------------------------------------------
# 🔵 CORRE Y OBSERVA
mean(trabajadores$ingreso[trabajadores$sector == "Agricultura"])
mean(trabajadores$ingreso[trabajadores$sector == "Servicios"])

# 🟢 TU TURNO: crea la columna `ingreso_anual` (ingreso * 12) y muestra la tabla.

trabajadores$ingreso_anual <- trabajadores$ingreso * 12

# -----------------------------------------------------------------------------
# BLOQUE E — Inspección: lo que se corre SIEMPRE primero
# -----------------------------------------------------------------------------
# 🔵 CORRE Y OBSERVA
str(trabajadores)      # estructura y tipo de cada columna  <- la más importante
summary(trabajadores)  # resumen estadístico por columna
head(trabajadores, 2)  # primeras filas

# 💡 HÁBITO PROFESIONAL: al abrir cualquier dataset, correr str() y summary()
#    ANTES de nada, para auditar tipos y detectar problemas.

str(mis_gastos)
summary(mis_gastos)
head(mis_gastos)
head(mis_gastos, 2)
tail(mis_gastos)
tail(mis_gastos, 2)

# Eliminar filas
trabajadores[-1, ]        # Saca la columna 1 de la vista, no cambia la tabla

trabajadores <- trabajadores[-1, ] # Asigna la nueva forma sin la fila 1 al 
                                   # data.frame

trabajadores [c(1, 4), ]      # Muestra la fila 1 y 2
trabajadores [-c(1,3), ]      # Muestra todas las filas menos la 1 y la 3

# LLamar más de una columna
trabajadores [ , c("ingreso", "genero")]

# Eliminar columnas
trabajadores [ , -c("ingreso", "genero")]   # No
trabajadores [ , -c(5,6)]                   

trabajadores
# -----------------------------------------------------------------------------
# CIERRE — crear data.frame() · dimensionar · acceder ($, [f,c], [[ ]]) ·
#          derivar (df$nueva <-) · inspeccionar (str/summary).
# Puente Sesión 2: el data frame es un caso particular de una LISTA.
# =============================================================================
