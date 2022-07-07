ANOVA, correlação e regressão linear - 2021.2
================

## Instalando e importando os pacotes necessários

``` r
if(!require(dplyr)) install.packages("dplyr")
library(dplyr)    
if(!require(car)) install.packages("car")   
library(car)                                
if(!require(psych)) install.packages("psych") 
library(psych)                                
if(!require(rstatix)) install.packages("rstatix") 
library(rstatix)                                
if(!require(DescTools)) install.packages("DescTools") 
library(DescTools)
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("mixOmics")
if(!require(RVAideMemoire)) install.packages("RVAideMemoire") 
library(RVAideMemoire)    
if(!require(readxl)) install.packages("readxl") 
library(readxl)    
```

## Questão 1

**Enunciado:** Um fabricante de cerveja identificou que a qualidade das
cervejas depende do fornecedor da cevada e que essa qualidade é
percebida pelos clientes. Verificar se existe diferença entre os
fornecedores, em nível de 5% de significância, e em caso afirmativo
quais fornecedores são significativamente diferentes.

``` r
# Importando os dados
dados_q1 <- read_excel("data/lista2-q1xlsx.xlsx", col_types = c("guess", "numeric"))
summary(dados_q1)
```

    ##   Fornecedor          Qualidade    
    ##  Length:20          Min.   :67.20  
    ##  Class :character   1st Qu.:69.90  
    ##  Mode  :character   Median :71.90  
    ##                     Mean   :71.94  
    ##                     3rd Qu.:74.55  
    ##                     Max.   :76.30

``` r
# Análisando a normalidade de cada grupo 
byf.shapiro(Qualidade ~ Fornecedor, data=dados_q1)
```

    ## 
    ##  Shapiro-Wilk normality tests
    ## 
    ## data:  Qualidade by Fornecedor 
    ## 
    ##                   W p-value
    ## Fornecedor 1 0.8561  0.2145
    ## Fornecedor 2 0.9310  0.6032
    ## Fornecedor 3 0.8779  0.3001
    ## Fornecedor 4 0.9782  0.9250

``` r
# Médias por grupo
aggregate(dados_q1$Qualidade, list(dados_q1$Fornecedor), FUN=mean) 
```

    ##        Group.1     x
    ## 1 Fornecedor 1 69.52
    ## 2 Fornecedor 2 74.26
    ## 3 Fornecedor 3 72.84
    ## 4 Fornecedor 4 71.16

``` r
# Análisando a homogeneidade entre os grupos com o teste de Lavene
leveneTest(Qualidade ~ Fornecedor, data=dados_q1, center=mean)
```

    ## Levene's Test for Homogeneity of Variance (center = mean)
    ##       Df F value Pr(>F)
    ## group  3  0.4304 0.7341
    ##       16

``` r
# Performando a ANOVA e exibindo a quadro de análise de variabilidade
anova = aov(Qualidade ~ Fornecedor, data=dados_q1)
summary(anova)
```

    ##             Df Sum Sq Mean Sq F value Pr(>F)  
    ## Fornecedor   3  63.29  21.095   3.462 0.0414 *
    ## Residuals   16  97.50   6.094                 
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Como o p-valor é inferior ao nível de significância, H0 é rejeitada.

``` r
# Teste de Tukey para identificar entre quais grupos há diferença
PostHocTest(anova, method = "hsd")
```

    ## 
    ##   Posthoc multiple comparisons of means : Tukey HSD 
    ##     95% family-wise confidence level
    ## 
    ## $Fornecedor
    ##                            diff     lwr.ci   upr.ci   pval    
    ## Fornecedor 2-Fornecedor 1  4.74  0.2731426 9.206857 0.0356 *  
    ## Fornecedor 3-Fornecedor 1  3.32 -1.1468574 7.786857 0.1869    
    ## Fornecedor 4-Fornecedor 1  1.64 -2.8268574 6.106857 0.7232    
    ## Fornecedor 3-Fornecedor 2 -1.42 -5.8868574 3.046857 0.8001    
    ## Fornecedor 4-Fornecedor 2 -3.10 -7.5668574 1.366857 0.2341    
    ## Fornecedor 4-Fornecedor 3 -1.68 -6.1468574 2.786857 0.7085    
    ## 
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Em média, a qualidade da cerveja do Fornecedor 2 é significativamente
maior do que a qualidade do Fornecedor 1.

## Questão 2

**Enunciado:** Um fabricante de impressoras com três fábricas deseja
examinar se o conhecimento em gerenciamento de qualidade é igual nas
três fábricas. Verificar a homogeneidade das variâncias, a normalidade
da amostra e elaborar o quadro de Análise de Variação, interpretar o
resultado geral e os resultados entre as fábricas. Considere um nível de
significância de 5%.

``` r
# Importando os dados
dados_q2 <- read_excel("data/lista2-q2.xlsx", col_types = c("numeric", "guess"))
summary(dados_q2)
```

    ##    Qualidade       Fabrica         
    ##  Min.   :59.00   Length:18         
    ##  1st Qu.:69.00   Class :character  
    ##  Median :73.50   Mode  :character  
    ##  Mean   :73.06                     
    ##  3rd Qu.:76.00                     
    ##  Max.   :85.00

``` r
# Análisando a normalidade de cada grupo 
byf.shapiro(Qualidade ~ Fabrica, data=dados_q2)
```

    ## 
    ##  Shapiro-Wilk normality tests
    ## 
    ## data:  Qualidade by Fabrica 
    ## 
    ##              W p-value
    ## Atlanta 0.8955  0.3479
    ## Dallas  0.9158  0.4756
    ## Seatle  0.9685  0.8819

``` r
# Médias por grupo
aggregate(dados_q2$Qualidade, list(dados_q2$Fabrica), FUN=mean) 
```

    ##   Group.1        x
    ## 1 Atlanta 79.00000
    ## 2  Dallas 74.00000
    ## 3  Seatle 66.16667

``` r
# Análisando a homogeneidade entre os grupos com o teste de Lavene
leveneTest(Qualidade ~ Fabrica, data=dados_q2, center=mean)
```

    ## Levene's Test for Homogeneity of Variance (center = mean)
    ##       Df F value Pr(>F)
    ## group  2  0.7905 0.4716
    ##       15

``` r
# Performando a ANOVA e exibindo a quadro de análise de variabilidade
anova = aov(Qualidade ~ Fabrica, data=dados_q2)
summary(anova)
```

    ##             Df Sum Sq Mean Sq F value  Pr(>F)   
    ## Fabrica      2  502.1  251.06    8.39 0.00358 **
    ## Residuals   15  448.8   29.92                   
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Como o p-valor é menor que 0.05, rejeita-se H0.

``` r
# Teste de Tukey para identificar entre quais grupos há diferença
PostHocTest(anova, method = "hsd")
```

    ## 
    ##   Posthoc multiple comparisons of means : Tukey HSD 
    ##     95% family-wise confidence level
    ## 
    ## $Fabrica
    ##                      diff    lwr.ci     upr.ci   pval    
    ## Dallas-Atlanta  -5.000000 -13.20327  3.2032675 0.2829    
    ## Seatle-Atlanta -12.833333 -21.03660 -4.6300658 0.0028 ** 
    ## Seatle-Dallas   -7.833333 -16.03660  0.3699342 0.0623 .  
    ## 
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

A qualidade da fábrica de Atlanta é significativamente maior em relação
a fábrica de Seattle.

## Questão 3

**Enunciado:** Deseja-se testar se existem diferenças na quantidade de
jacarés em três locais do pantanal mato-grossense. Verificar a
homogeneidade das variâncias, a normalidade da amostra e elaborar o
quadro de Análise de Variação, interpretar os resultados. *Considere um
nível de significância de 1%.*

``` r
# Importando os dados
dados_q3 <- read_excel("./data/lista2-q3.xlsx", col_types = c("numeric", "text"))
summary(dados_q3)
```

    ##    Quantidade       Local          
    ##  Min.   : 6.00   Length:45         
    ##  1st Qu.:10.00   Class :character  
    ##  Median :12.00   Mode  :character  
    ##  Mean   :12.73                     
    ##  3rd Qu.:15.00                     
    ##  Max.   :21.00

``` r
# Análisando a normalidade de cada grupo 
byf.shapiro(Quantidade ~ Local, data=dados_q3)
```

    ## 
    ##  Shapiro-Wilk normality tests
    ## 
    ## data:  Quantidade by Local 
    ## 
    ##        W p-value
    ## 1 0.9102  0.1366
    ## 2 0.9023  0.1034
    ## 3 0.9188  0.1846

``` r
# Médias por grupo
aggregate(dados_q3$Quantidade, list(dados_q3$Local), FUN=mean) 
```

    ##   Group.1         x
    ## 1       1 11.866667
    ## 2       2  8.866667
    ## 3       3 17.466667

``` r
# Análisando a homogeneidade entre os grupos com o teste de Lavene
leveneTest(Quantidade ~ Local, data=dados_q3, center=mean)
```
    ## Levene's Test for Homogeneity of Variance (center = mean)
    ##       Df F value Pr(>F)
    ## group  2  0.2264 0.7983
    ##       42

``` r
# Performando a ANOVA e exibindo a quadro de análise de variabilidade
anova = aov(Quantidade ~ Local, data=dados_q3)
summary(anova)
```

    ##             Df Sum Sq Mean Sq F value   Pr(>F)    
    ## Local        2  571.6  285.80   91.49 4.93e-16 ***
    ## Residuals   42  131.2    3.12                     
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Como o p-valor é menor que 0.01, rejeita-se H0.

``` r
# Teste de Tukey para identificar entre quais grupos há diferença
PostHocTest(anova, method = "hsd")
```

    ## 
    ##   Posthoc multiple comparisons of means : Tukey HSD 
    ##     95% family-wise confidence level
    ## 
    ## $Local
    ##     diff    lwr.ci    upr.ci    pval    
    ## 2-1 -3.0 -4.567933 -1.432067 9.6e-05 ***
    ## 3-1  5.6  4.032067  7.167933 2.0e-10 ***
    ## 3-2  8.6  7.032067 10.167933 1.1e-12 ***
    ## 
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Quantidade do Local 3 \> Quantidade do Local 1 \> Quantidade do Local 2

## Questão 4

**Enunciado**: Um pesquisador deseja verificar se um instrumento para
medir a concentração de determinada substância no sangue está bem
calibrado. Para isto, ele tomou 15 amostras de concentrações conhecidas
(X) e determinou a respectiva concentração através do instrumento (Y).
Calcular:

a\) Coeficiente de Correlação e de determinação;

b\) Equação da reta;

c\) As estimativas dos valores de y para x= 5 e x=12.

``` r
# Importando os dados
dados_q4 <- read_excel("data/lista2-q4.xlsx", col_types = c("numeric", "numeric"))
summary(dados_q4) 
```

    ##     Previsto          Real   
    ##  Min.   : 1.80   Min.   : 2  
    ##  1st Qu.: 4.10   1st Qu.: 4  
    ##  Median : 6.20   Median : 6  
    ##  Mean   : 6.04   Mean   : 6  
    ##  3rd Qu.: 8.00   3rd Qu.: 8  
    ##  Max.   :10.10   Max.   :10

``` r
# Performando regressão
reg = lm(Previsto~Real, data = dados_q4)
summary(reg) 
```

    ## 
    ## Call:
    ## lm(formula = Previsto ~ Real, data = dados_q4)
    ## 
    ## Residuals:
    ##    Min     1Q Median     3Q    Max 
    ##  -0.36  -0.21  -0.02   0.15   0.46 
    ## 
    ## Coefficients:
    ##             Estimate Std. Error t value Pr(>|t|)    
    ## (Intercept)  0.16000    0.16003    1.00    0.336    
    ## Real         0.98000    0.02413   40.62 4.39e-15 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.2643 on 13 degrees of freedom
    ## Multiple R-squared:  0.9922, Adjusted R-squared:  0.9916 
    ## F-statistic:  1650 on 1 and 13 DF,  p-value: 4.394e-15

a\) Coeficiente de determinação (R²) = 0.9922 ou 99.22%

``` r
# Coeficiente de correlação
sqrt(0.9922)
```

    ## [1] 0.9960924

b\) `y = 0.98x + 0.16`

c\)

``` r
predizer_valor = function (x) {
return(0.98 * x + 0.16)
}

c(predizer_valor(5), predizer_valor(12))
```

    ## [1]  5.06 11.92

## Questão 5

**Enunciado**: Calcular:

d\) Coeficiente de Correlação e de determinação;

e\) Equação da reta;

f\) Elaborar o teste de hipótese e interpretar usando p-value.

``` r
# Importando os dados
dados_q5 <- read_excel("data/lista2-q5.xlsx", col_types = c("numeric", "numeric"))
summary(dados_q5) 
```

    ##        X               Y        
    ##  Min.   :14.00   Min.   :28.00  
    ##  1st Qu.:23.50   1st Qu.:33.75  
    ##  Median :40.50   Median :45.50  
    ##  Mean   :37.83   Mean   :44.17  
    ##  3rd Qu.:47.75   3rd Qu.:49.00  
    ##  Max.   :64.00   Max.   :66.00

``` r
# Performando regressão
reg = lm(Y~X, data = dados_q5)
summary(reg) 
```

    ## 
    ## Call:
    ## lm(formula = Y ~ X, data = dados_q5)
    ## 
    ## Residuals:
    ##       1       2       3       4       5       6 
    ##  0.7009 -0.1300 -0.7001  3.5922 -6.7774  3.3144 
    ## 
    ## Coefficients:
    ##             Estimate Std. Error t value Pr(>|t|)   
    ## (Intercept) 17.39086    4.11839   4.223  0.01345 * 
    ## X            0.70773    0.09893   7.153  0.00202 **
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 4.208 on 4 degrees of freedom
    ## Multiple R-squared:  0.9275, Adjusted R-squared:  0.9094 
    ## F-statistic: 51.17 on 1 and 4 DF,  p-value: 0.002021

d\) Coeficiente de determinação(R²) = 0.9275 ou 92,75%.

``` r
# Coeficiente de correlação
sqrt(0.9275)
```

    ## [1] 0.963068

e\) `y = 0.70773x + 17.39086`

f\)

``` r
cor.test(dados_q5$X, dados_q5$Y)
```

    ## 
    ##  Pearson's product-moment correlation
    ## 
    ## data:  dados_q5$X and dados_q5$Y
    ## t = 7.1535, df = 4, p-value = 0.002021
    ## alternative hypothesis: true correlation is not equal to 0
    ## 95 percent confidence interval:
    ##  0.6936770 0.9960937
    ## sample estimates:
    ##       cor 
    ## 0.9630681
