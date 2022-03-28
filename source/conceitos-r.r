# Criação de objetos
# Em R, existem dois comandos de atribuição disponíveis: '<-' e '='. Desse modo, 
# escrever:

raio <- 10
raio

# é equivalente à

raio = 10
raio

# Operadores Lógicos

a = 5
b = 10

# Maior que
a > b

# Menor que
a < b

# Menor ou igual que
a <= b

# Maior ou igual que
a >= b

# E
a > 4 & b < 7

# Ou
a > 4 | b < 7

# Igual
a == b

# Diferente
a != b

# Negação
!(a>b)

# Estruturas de dados

# Vetores: são estruturas unidimensionais, criadas com a função c()
x = c(1,2,3)
x
# Matrizes: são estruturas unidimensionais, criadas com a função matrix()
x =  matrix(c(1,2,3,4),nrow=2,ncol=2)
x
# Arrays são a generalizaçao de uma matriz 
v1 <- c(5,9,3)
v2 <- c(10,11,12,13,14,15)
x <- array(c(v1,v2),dim = c(3,3,2))
x
# Lista é uma estrutura de dados mais genérica do R
x = list(list(1,2), 9)
x
# Data frames: data.frame() é um caso especial de uma lista
x <- data.frame(
  id = c (1:5), 
  renda_fixa = c(623.3,515.2,611.0,729.0,843.25))


# Lendo arquivos externos

# Para ler arquivos csv podemos usar a funcão 'read.table'
#dados <- read.table(file = "caminho/do/arquivo",
 #                   + sep = ",", #separador
  #                  + dec = ".", #decimal
   #                 + header = TRUE) # O arquivo contém um cabeçalho com o nome das variáveis

# O pacote readxl é necessário para leitura de arquivos xlsx.
#install.package(readxl) (necessário se o pacote readxl ainda não estiver instalado)

#library(readxl)
#dados_excel <- read_excel(path = 'caminho/do/arquivo', sheet = 1)

# Funções


## Criando funções
#
#NomeDaFuncao <- function(arg1, arg2, ...){
  
 # procedimentos
  
  #return(resultado)
#}

quadrado <- function(n){
  return(n**2)
}

quadrado(2)

## Disponíveis na linguagem
#Algumas funções built-in e bastante úteis podem ser consultadas [aqui][https://www.javatpoint.com/r-built-in-functions]

# Referências

