
url <- "TabelaLivro.csv"

# A util read.csv importa arquivos em fomato csv.
# header especifica se a primeira linha do arquivo expressa o nome das variáveis
# e sep é usado para definir qual caractere separa os valores no dataset.
# No caso do dataset milsa, os valores são separados pelo símbolo de ponto e vírgula.
milsa <- read.csv(url, header = TRUE, sep = ";")

# Podemos observar um resumo da estrutura de qualquer objeto com a util str()
str(milsa)

# Podemos selecionar colunas aplicando DataFrame$nome_da_coluna
# Abaixo selecionamos a coluna Est.civil e aplicamos a função table para construir
# uma tabela de frequências absolutas com seus valores.
civil.tb <- table(milsa$Est.civil)


# GRÁFICO DE BARRAS

# col: vetor com as cores das barras
# main, xlab, ylab: título do gŕafico e os rótulos dos eixos x e y, respectivamente
# ylim: vetor com os limites do eixo y
# cex.names, cex.axis, cex.labels: tamanhos do texto nos nomes das categorias, eixos e rótulos,
# respectivamente
# bty: define se/como será desenhado contorno do gráfico

barplot(civil.tb, cex.names=1.5, col=c("green", 
        "blue"), ylab="Número de Funcionários", 
        xlab="Estado civil", cex.axis=1.25,
        main="Proporção entre casados e solteiros",
        cex.lab=1.25,bty="n", ylim=c(0,25))

# GRAFICO DE PIZZA

# Aqui, calculamos a porcentagem, com duas casas decimais, de cada uma
# das classes da variável Est.civil, usando a função round.
# A função paste é usada para concatenar o nome de cada classe com suas respectivas
# proporções.

labs<-paste(c("Casados = ", "Solteiros = "),
       round(civil.tb/length(milsa$Est.civil) * 100, 
       digits=2), "%")

# As strings salvas em labs serão os rótulos do nosso gráfico de pizza

pie(civil.tb,labels=labs,col=c("green", "blue"),
       main="Proporção entre casados e solteiros",
       cex=1.1)

#Plotando legenda no canto superior direito (topright)

legend("topright", pch=15, col=c("green","blue"), 
       legend=c("Casados", "Solteiros"),
       cex=1.1, bty="n")

## Variavel Qualitativa Ordinal 

## Frequência absoluta

inst.tb <- table(milsa$Inst)

## Frequência relativa
prop.table(inst.tb)

## Gráfico de Barras com barras ordenadas

# A função sort ordena os dados

# Ordem crescente
barplot(sort(inst.tb,decreasing = FALSE),
        cex.names=1.15, 
        col=c("green", "blue", "red"),
        ylab="Instrução de Funcionários", 
        xlab="Escolaridade", cex.axis=1.25,
        main="Escolaridade dos Funcionários",
        cex.lab=1.25,bty="n", ylim=c(0,20))

# Ordem decrescente
barplot(sort(inst.tb,decreasing = TRUE),
        cex.names=1.15, 
        col=c("green", "blue", "red"),
        ylab="Instrução de Funcionários", 
        xlab="Escolaridade", cex.axis=1.25,
        main="Escolaridade dos Funcionários",
        cex.lab=1.25,bty="n", ylim=c(0,20))

## Variável quantitativa discreta

## Frequência absoluta

filhos.tb <- table(milsa$Filhos)

plot(filhos.tb, col =  "green", type = "h",
     lwd = 5, cex.lab=1.2,
     main = " Frequência Absoluta",
     xlab= "Número de filhos",
     ylab= "Quantidade de Filhos ") 

## Frequência relativa
filhos.tbr <- prop.table(filhos.tb)

## Frequencia relativa acumulada
filhos.tbra <- cumsum(filhos.tbr)

plot(filhos.tbra, type = "S",col = "red",
     main = "Frequência relativa acumulada",
     lwd = 5 )

## Frequência absoluta e relativa acumulada
filhos.tbra <- cumsum(filhos.tbr)
filhos.tba <- cumsum(filhos.tb)

# A função cbind combina vetores

filhosTabResul = cbind(filhos.tb,filhos.tba,
                 filhos.tbr = round(filhos.tbr*100,digits = 2),
                 filhos.tbra= round(filhos.tbra*100,digits = 2))
filhosTabResul

## Moda

# Which.max retorna o rótulo mais frequente numa variável
names(filhos.tb)[which.max(filhos.tb)]
 
## Mediana
median(milsa$Filhos, na.rm = TRUE)
 
## Média
mean(milsa$Filhos, na.rm = TRUE)

## Quartis
quantile(milsa$Filhos, na.rm = TRUE)

## Máximo e mínimo
max(milsa$Filhos, na.rm = TRUE)

min(milsa$Filhos, na.rm = TRUE)

## As duas infomações juntas
range(milsa$Filhos, na.rm = TRUE)

## Amplitude é a diferença entre Máximo e mínimo
diff(range(milsa$Filhos, na.rm = TRUE))

## Variância
var(milsa$Filhos, na.rm = TRUE)

## Desvio-padrão
sd(milsa$Filhos, na.rm = TRUE)

## Coeficiente de variação
sd(milsa$Filhos, na.rm = TRUE)/mean(milsa$Filhos, na.rm = TRUE)
 
## Quartis
(filhos.qt <- quantile(milsa$Filhos, na.rm = TRUE))

## Summary() para resumir os dados de uma só vez
summary(milsa$Filhos)

## Variável quantitativa contínua

Salario.tb <- (milsa$Salario)
sort (Salario.tb)

Amplitude <- max (Salario.tb) - min(Salario.tb) 
NK <-  round( 1 + 3.222 * log10(length(Salario.tb)))
AmpClasse <- Amplitude / NK

limitesclas <- c(4 ,7.25 ,10.50 ,13.75 ,17.00 ,20.25, 23.50)

classes<-c("04.00-07.25","07.25-10.50","10.50-13.75",
           "13.75-17.00","17.00-20.25", "20.25-23.50")

# A função cut divide os valores de um vetor em intervalos delimitados no parâmetro breaks
Freq = table(cut(Salario.tb, breaks = limitesclas, right=FALSE, labels=classes))

FreqAc <- cumsum(Freq)
FreqRel <- prop.table(Freq)
FreqRelAc <- cumsum(FreqRel)

TabResul = cbind(Freq,FreqAc, FreqRel = round(FreqRel*100,digits = 2),
                              FreqRelAc= round(FreqRelAc*100,digits = 2))
TabResul

# Histograma
h = hist(Salario.tb, breaks=limitesclas,
    ylab="Frequencias absolutas",  xlab="Salário", labels=classes,main="Histograma", 
    xlim=c(4,25), ylim = c (0,12), col="orange")

# Desenhando o polígono de frequências
lines(c(min(h$breaks), h$mids, max(h$breaks)), 
       c(0,h$counts, 0), type = "l")
       
## Mediana
median(milsa$Salario)

## Média
 mean(milsa$Salario)
       
## Quartis
quantile(milsa$Salario)
       
## As duas infomações juntas
range(milsa$Salario)
       
## Amplitude é a diferença entre Máximo e mínimo
diff(range(milsa$Salario))
       
## Variância
var(milsa$Salario)
## Desvio-padrão
sd(milsa$Salario)
       
## Coeficiente de variação
sd(milsa$Salario)/mean(milsa$Salario)
       
## Quartis
(Salario.qt <- quantile(milsa$Salario))
       
## Summary() para resumir os dados de uma s? vez
summary(milsa$Salario)

# Box plot

boxplot(milsa$Salario)

boxplot(milsa$Salario,  col = "orange", main="Boxplot - Salário")

## Qualitativa vs qualitativa (variáveis Estado Civil Instrução)

civ.ins.tb <- with(milsa, table(Est.civil, Instrucao))

## Comando equivalente
table(milsa$Est.civil, milsa$Instrucao)

## Mudar a ordem de apuração
table( milsa$Instrucao, milsa$Est.civil)

# Adicionando os títulos de cada eixo
addmargins(civ.ins.tb)

# Frequência relativa
prop.table(civ.ins.tb)

## Frequencia Relativa por linha 

prop.table(civ.ins.tb, margin = 1)
prop.table(civ.ins.tb, margin = 2)


## Gráficos de Barra

# Usamos a função par para plotar mais de um gráfico de uma vez
par (mfrow = c (1,4))  

barplot(civ.ins.tb, legend= TRUE)
barplot(t(civ.ins.tb), legend= TRUE)

barplot(civ.ins.tb, beside= TRUE, legend= TRUE)
barplot(t(prop.table(civ.ins.tb)), beside= TRUE, legend= TRUE)

## Qualitativa vs quantitativa (variáveis Instrução e Salário)
## Quartis de salario

quantile(milsa$Salario)

## Classificação de acordo com os quartis
salario.cut <- cut(milsa$Salario, breaks =  quantile(milsa$Salario),
                   include.lowest = TRUE)

## Tabela de Frequências absolutas
inst.sal.tb <- table(milsa$Inst, salario.cut)
inst.sal.tb

# Gráfico de barras
barplot(inst.sal.tb, col=c("yellow","red","orange"), main= "Sal?rio x Instrução",
        xlab = "Quantiles", ylab = "Frequência  Instrução",
        beside = TRUE, legend = TRUE)

# Boxplot
boxplot(Salario ~ Instrucao, data = milsa, col=c("yellow", "red", "orange"))  

## Quantitativa vs Quantitativa (considerar as variáveis Salario e Idade)

Anos.cut <- cut(milsa$Anos, breaks = quantile(milsa$Anos),include.lowest = TRUE)

salario.cut <- cut(milsa$Salario, breaks = quantile(milsa$Salario),
                   include.lowest = TRUE)
## Tabela cruzada

Anos.sal.tb <- table(Anos.cut, salario.cut)
Anos.sal.tb

plot(x = milsa$Anos, y = milsa$Salario)

plot(Salario ~ Anos, data = milsa)

## Correlação - verificar associação entre variaveis quantitativas

cor(milsa$Anos, milsa$Salario)
cor(milsa$Anos, milsa$Salario, method = "kendall") # Usa coeficiente de kendall
cor(milsa$Anos, milsa$Salario, method = "spearman") # Usa coeficiente de kendall
       