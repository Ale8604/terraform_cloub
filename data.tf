// Maneja la informacion de la key pier creada en la consola de amazon 
data "aws_key_pair" "key" {
  key_name = "mykey"
}