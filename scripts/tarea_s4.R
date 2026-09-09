# =============================================================================
# 
# Autor: Camila Bravo Figueroa
# Fecha: 08-09-2026
# Descripción:Analiza un subconjunto de la encuesta CASEN mediante exploración 
# de datos, filtrado por condiciones y comparación de estadísticas descriptivas.
# 
# =============================================================================

# -----------------------------------------------------------------------------
# CARGA DE DATOS CASEN
# -----------------------------------------------------------------------------

# Carga los datos con una ruta relativa.
casen <- read.csv("data/raw/casen_reducido.csv")

# -----------------------------------------------------------------------------
# EXPLORACIÓN INICIAL DE LOS DATOS
# -----------------------------------------------------------------------------

# Inspecciona la estructura para identificar tipos de datos, cantidad de 
# observaciones y posibles valores faltantes.
str(casen)            

# Visualiza las primeras observaciones para comprobar que los datos se cargaron 
# correctamente.
head(casen)

# Verifica la dimensión del conjunto de datos
dim(casen)           

# Resume estadísticamente cada variable.
summary(casen)        

# OBSERVACIONES

## El dataframe contiene 60 observaciones y 6 variables.
## Las variables region, sector y genero son de tipo character.
## Las variables educ, edad e ingresos son de tipo numerico (integer).
## Se detectan 5 valores faltantes (NA) en la variable ingreso.

# -----------------------------------------------------------------------------
# CREACIÓN DE UN SUBSET
# -----------------------------------------------------------------------------

# Identifico mujeres con más de 10 años de educación para analizar sus 
# características e ingresos.
sub_casen <- casen[casen$genero == "F" & casen$educ > 10, ]

# Obtengo la cantidad de mujeres con más de 10 años de educación.
n_sub <- nrow(sub_casen)

# Calculo la edad promedio del grupo seleccionado.
edad_prom_sub <- mean(sub_casen$edad)

# Calculo el ingreso promedio del grupo seleccionado.
ingreso_prom_sub <- mean(sub_casen$ingreso, na.rm = TRUE)

# Calculo el ingreso promedio de toda la muestra para comparar.
ingreso_prom_total <- mean(casen$ingreso, na.rm = TRUE)

# Revisión de resultados del subset.
n_sub
edad_prom_sub
ingreso_prom_sub
ingreso_prom_total

# RESPUESTA

# Se identificaron 22 mujeres con más de 10 años de educación.
# Este grupo presenta una edad promedio de 40,32 años y un ingreso promedio de 
# $718.143 aproximadamente.
#
# Al comparar este resultado con el ingreso promedio general ($655.291), se 
# observa que las mujeres con un mayor nivel educativo obtienen ingresos 
# superiores al promedio de la muestra.
#
# Esto podría explicarse porque una mayor educación suele facilitar el acceso 
# a empleos más calificados y mejor remunerados.

# -----------------------------------------------------------------------------
# ANÁLISIS PROPIO
# -----------------------------------------------------------------------------

# ¿Existe una brecha de ingreso entre las mujeres que trabajan en el sector de
# la Educación y las que trabajan en Agricultura?

# Calcula el ingreso promedio de las mujeres que trabajan en Educación.
ingreso_feduc <- mean(casen$ingreso[casen$genero == "F" & 
                                      casen$sector == "Educación"], 
                                        na.rm = TRUE)

# Calcula el ingreso promedio de las mujeres que trabajan en Agricultura.
ingreso_fagri <- mean(casen$ingreso[casen$genero == "F" & 
                                      casen$sector == "Agricultura"], 
                                        na.rm = TRUE)

# Calcula la brecha de ingreso entre mujeres que trabajan en Educación y 
# mujeres que trabajan en Agricultura.
brecha_ingreso <- ingreso_feduc - ingreso_fagri


# Revisión de resultados para cada grupo y su brecha
ingreso_feduc
ingreso_fagri
brecha_ingreso

# RESPUESTA:

# Las mujeres que trabajan en el sector Educación presentan un ingreso promedio 
# de $913.750, mientras que las mujeres del sector Agricultura tienen un 
# ingreso promedio de aproximadamente $405.714.
#
# Por ende, su brecha estimada es de $508.036 a favor del sector Educación.Esta 
# diferencia podría explicarse por diferencias en requisitos de formación, nivel 
# educativo, especialización laboral o características propias de cada sector 
# económico.

