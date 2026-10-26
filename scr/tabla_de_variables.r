
# a continuación el código referente a la creación de la tabla de variables,
# creando un data frame con las filas de cada varible, utilizando la libreria
# tinytable para crear la tabla con la función tt()

library(tinytable)

tabla <- data.frame(
Nombre = c("Especies", "Conteo individual", "Latitud", "Longitud", "Años", "Tipo de suelo",
           "frecuencia relativa", "frecuencia"),
Tipo = c("Cualitativa nominal", "Cuantitativa discreta", "Cuantitativa discreta",
         "Cuantitativa discreta", "Cuantitativa continua", "Cualitativa nominal", 
         "cuantitativa discreta", "cuantitativa discreta"),
Unidad = c("NA", "NA", "grados decimales (°)", "grados decimales (°)", "año (t)", "NA",
           "NA", "NA"),
Etiqueta = c("species", "individualCount", "decimalLatitude", "decimalLongitude", "year",
             "floorType", "Rfrecuency", "frecuency")
)

tt(tabla)


