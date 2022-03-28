Introdução ao R
================

## Criação de objetos

Em R, existem dois comandos de atribuição disponíveis: `<-` e `=`. Desse
modo, escrever:

``` r
raio <- 10
raio
```

    ## [1] 10

é equivalente a

``` r
raio = 10
raio
```

    ## [1] 10

## Operadores

``` r
a = 5
b = 10
```

Os operadores lógicos e aritméticos do R estão exemplificados nas seções
abaixo.

### Operadores Aritméticos

``` r
# Soma

a + b
```

    ## [1] 15

``` r
# Diferença

a - b
```

    ## [1] -5

``` r
# Multiplicação

a * b
```

    ## [1] 50

``` r
# Divisão 

a / b
```

    ## [1] 0.5

``` r
# Exponenciação

a**b
```

    ## [1] 9765625

### Operadores Lógicos

``` r
# Maior que
a > b
```

    ## [1] FALSE

``` r
# Menor que

a < b
```

    ## [1] TRUE

``` r
# Menor ou igual que
a <= b
```

    ## [1] TRUE

``` r
# Maior ou igual que
a >= b
```

    ## [1] FALSE

``` r
# E
a > 4 & b < 7
```

    ## [1] FALSE

``` r
# Ou
a > 4 | b < 7
```

    ## [1] TRUE

``` r
# Igualdade
a == b
```

    ## [1] FALSE

``` r
# Diferença
a != b
```

    ## [1] TRUE

``` r
# Negação
!(a>b)
```

    ## [1] TRUE

## Estruturas de dados

**Vetores:** são estruturas unidimensionais, criadas com a função `c()`

``` r
x = c(1,2,3)
x
```

    ## [1] 1 2 3

**Matrizes:** são estruturas bidimensionais, criadas com a função
`matrix()`.

``` r
x =  matrix(c(1,2,3,4), nrow=2, ncol=2)
x
```

    ##      [,1] [,2]
    ## [1,]    1    3
    ## [2,]    2    4

**Arrays:** são a generalizaçao de uma matriz.

``` r
v1 <- c(5,9,3)
v2 <- c(10,11,12,13,14,15)
x <- array(c(v1,v2), # dados
           dim = c(3,3,2)) # dimensões do array
x
```

    ## , , 1
    ## 
    ##      [,1] [,2] [,3]
    ## [1,]    5   10   13
    ## [2,]    9   11   14
    ## [3,]    3   12   15
    ## 
    ## , , 2
    ## 
    ##      [,1] [,2] [,3]
    ## [1,]    5   10   13
    ## [2,]    9   11   14
    ## [3,]    3   12   15

**Lista:** é uma estrutura de dados mais genérica do R, que pode conter
diferentes tipos de dados.

``` r
vet <- c(1,0,1,0)
char_vet <- c("Um", "Zero", "Um", "Zero")
logic_vet <- c(TRUE, FALSE, TRUE, FALSE)

x <- list(vet, char_vet, logic_vet)
x
```

    ## [[1]]
    ## [1] 1 0 1 0
    ## 
    ## [[2]]
    ## [1] "Um"   "Zero" "Um"   "Zero"
    ## 
    ## [[3]]
    ## [1]  TRUE FALSE  TRUE FALSE

**Dataframes:** `data.frame()` é um caso especial de uma lista. Nele,
podemos atribuir nomes às linhas/colunas.

``` r
x <- data.frame(
  id = c (1:5), 
  renda_fixa = c(623.3,515.2,611.0,729.0,843.25))

x
```

    ##   id renda_fixa
    ## 1  1     623.30
    ## 2  2     515.20
    ## 3  3     611.00
    ## 4  4     729.00
    ## 5  5     843.25

## Lendo arquivos externos

Para ler arquivos csv podemos usar a funcão `read.table`:

``` r
dados <- read.table(file = "caminho/do/arquivo",
                    sep = ",", #separador
                    dec = ".", #decimal
                    header = TRUE) # O arquivo contém um cabeçalho com o nome das variáveis
```

O pacote `readxl` é necessário para leitura de arquivos xlsx.

``` r
#install.package(readxl) (necessário se o pacote readxl ainda não estiver instalado)

library(readxl)
dados_excel <- read_excel(path = 'caminho/do/arquivo', sheet = 1)
```

## Funções

### Criando funções

``` r
NomeDaFuncao <- function(arg1, arg2, ...){
  
  procedimentos
  
  return(resultado)
}
```

Exemplo:

``` r
quadrado <- function(n){
  quadr = n**2
  return(quadr)
}

quadrado(2)
```

    ## [1] 4

### Disponíveis na linguagem

Algumas funções built-in e bastante úteis podem ser consultadas
[aqui](https://www.javatpoint.com/r-built-in-functions)

## Referências

[Introdução ao R,
UFMG](http://www.est.ufmg.br/~marcosop/est008/aulas/Intro_R.pdf)
