Reavaliação AB2 2021.1
================

**Observação:** o número de matrícula considerado para resolver as
questões abaixo foi **22021234**.

## Instalando e importando os pacotes necessários

``` r
if(!require(dplyr)) install.packages("dplyr")
```

    ## Loading required package: dplyr

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

``` r
library(dplyr)    
if(!require(car)) install.packages("car")   
```

    ## Loading required package: car

    ## Loading required package: carData

    ## 
    ## Attaching package: 'car'

    ## The following object is masked from 'package:dplyr':
    ## 
    ##     recode

``` r
library(car)                                
if(!require(psych)) install.packages("psych") 
```

    ## Loading required package: psych

    ## 
    ## Attaching package: 'psych'

    ## The following object is masked from 'package:car':
    ## 
    ##     logit

``` r
library(psych)                                
if(!require(rstatix)) install.packages("rstatix") 
```

    ## Loading required package: rstatix

    ## 
    ## Attaching package: 'rstatix'

    ## The following object is masked from 'package:stats':
    ## 
    ##     filter

``` r
library(rstatix)                                
if(!require(DescTools)) install.packages("DescTools") 
```

    ## Loading required package: DescTools

    ## 
    ## Attaching package: 'DescTools'

    ## The following objects are masked from 'package:psych':
    ## 
    ##     AUC, ICC, SD

    ## The following object is masked from 'package:car':
    ## 
    ##     Recode

``` r
library(DescTools)
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("mixOmics")
```

    ## 'getOption("repos")' replaces Bioconductor standard repositories, see
    ## '?repositories' for details
    ## 
    ## replacement repositories:
    ##     CRAN: https://cloud.r-project.org

    ## Bioconductor version 3.15 (BiocManager 1.30.18), R 4.2.0 (2022-04-22)

    ## Warning: package(s) not installed when version(s) same as current; use `force = TRUE` to
    ##   re-install: 'mixOmics'

    ## Installation paths not writeable, unable to update packages
    ##   path: /usr/lib/R/library
    ##   packages:
    ##     nlme, spatial, survival

    ## Old packages: 'lme4', 'processx', 'Rcpp', 'stringi'

``` r
if(!require(RVAideMemoire)) install.packages("RVAideMemoire") 
```

    ## Loading required package: RVAideMemoire

    ## *** Package RVAideMemoire v 0.9-81-2 ***

``` r
library(RVAideMemoire)    
if(!require(readxl)) install.packages("readxl") 
```

    ## Loading required package: readxl

``` r
library(readxl)    
```

## Questão 3

**Enunciado:**

Deseja-se testar se existem diferenças na quantidade de animais em três
locais distintos.

Calcular:

    a\) Verificar e interpretar a homogeneidade das variâncias dos locais;

    b\) Verificar e interpretar a normalidade dos dados dos locais;

    c\) Elaborar e interpretar o quadro de Análise de Variância (ANOVA);

    d\) Verificar as divergências entre as médias dos locais e interpretar os resultados a 5% e a 1% de significância.

``` r
# Importando os dados
dados_q3 <- read_excel("data/reav_q3.xlsx", col_types = c("numeric", "guess"))
summary(dados_q3)
```

    ##    Quantidade       Local          
    ##  Min.   : 5.00   Length:48         
    ##  1st Qu.:10.00   Class :character  
    ##  Median :12.00   Mode  :character  
    ##  Mean   :12.62                     
    ##  3rd Qu.:15.00                     
    ##  Max.   :23.00

``` r
# Análisando a normalidade de cada grupo 
byf.shapiro(Quantidade ~ Local, data=dados_q3)
```

    ## 
    ##  Shapiro-Wilk normality tests
    ## 
    ## data:  Quantidade by Local 
    ## 
    ##         W p-value  
    ## L1 0.8920 0.05987 .
    ## L2 0.9250 0.20300  
    ## L3 0.9519 0.51976  
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

``` r
# Médias por grupo
aggregate(dados_q3$Quantidade, list(dados_q3$Local), FUN=mean) 
```

    ##   Group.1       x
    ## 1      L1 11.7500
    ## 2      L2  8.5625
    ## 3      L3 17.5625

``` r
# Análisando a homogeneidade entre os grupos com o teste de Lavene
leveneTest(Quantidade ~ Local, data=dados_q3, center=mean)
```

    ## Warning in leveneTest.default(y = y, group = group, ...): group coerced to
    ## factor.

    ## Levene's Test for Homogeneity of Variance (center = mean)
    ##       Df F value  Pr(>F)  
    ## group  2  2.4281 0.09968 .
    ##       45                  
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

``` r
# Performando a ANOVA e exibindo a quadro de análise de variabilidade
anova = aov(Quantidade ~ Local, data=dados_q3)
summary(anova)
```

    ##             Df Sum Sq Mean Sq F value   Pr(>F)    
    ## Local        2  666.4   333.2   48.23 6.43e-12 ***
    ## Residuals   45  310.9     6.9                     
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
    ## $Local
    ##          diff   lwr.ci   upr.ci    pval    
    ## L2-L1 -3.1875 -5.43969 -0.93531  0.0037 ** 
    ## L3-L1  5.8125  3.56031  8.06469 3.9e-07 ***
    ## L3-L2  9.0000  6.74781 11.25219 4.5e-12 ***
    ## 
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Diferem significativamente entre si, tanto a 5% de significância quanto
à 1% de significância, dado que todos os p-valores são inferiores à
0.01. Quantidade L3 \> Quantidade L1 \> Quantidade L2.

## Questão 4

**Enunciado**: Considere os dados:

    • Altura de planta (X)   8, 4, 6, 5, 12, (xx/2)
    • Número de folhas (Y) 16, 9, 13, 9, 20, (xx+2)/2

Calcular:

a\) O coeficiente de Correlação e o coeficiente de determinação e
explicar os resultados.

b\) Calcular a equação da reta e calcular o valor predito para X = 10.

c\) Elaborar um teste de hipótese para validar o coeficiente de
determinação obtido acima e justifique sua resposta.

``` r
# Importando os dados
dados_q4 <- read_excel("data/reav_q4.xlsx", col_types = c("numeric", "numeric"))
summary(dados_q4) 
```

    ##        X                Y        
    ##  Min.   : 4.000   Min.   : 9.00  
    ##  1st Qu.: 5.250   1st Qu.:10.00  
    ##  Median : 7.000   Median :14.50  
    ##  Mean   : 8.833   Mean   :14.33  
    ##  3rd Qu.:11.000   3rd Qu.:18.25  
    ##  Max.   :18.000   Max.   :20.00

``` r
# Performando regressão
reg = lm(Y~X, data = dados_q4)
summary(reg) 
```

    ## 
    ## Call:
    ## lm(formula = Y ~ X, data = dados_q4)
    ## 
    ## Residuals:
    ##       1       2       3       4       5       6 
    ##  2.3136 -1.5811  0.8663 -2.3574  3.2083 -2.4497 
    ## 
    ## Coefficients:
    ##             Estimate Std. Error t value Pr(>|t|)  
    ## (Intercept)   7.4757     2.3425   3.191   0.0332 *
    ## X             0.7763     0.2325   3.339   0.0289 *
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 2.759 on 4 degrees of freedom
    ## Multiple R-squared:  0.7359, Adjusted R-squared:  0.6699 
    ## F-statistic: 11.15 on 1 and 4 DF,  p-value: 0.02887

a\) Coeficiente de determinação(R²) = 0.7359 ou 73,59%, isto é, o modelo
linear explica 73,59% da variância dos dados analisados.

``` r
# Coeficiente de correlação
sqrt(0.7359)
```

    ## [1] 0.8578461

O coeficiente de correlação de Pearson é aproximadamente 0.86, indicando
que existe uma correlação positiva forte entre a altura das plantas e a
quantidade de folhas. Isto é, quanto maior a altura da planta, maior a
quantidade de folhas.

b\) `y = 0.7763x + 7.4757`

``` r
  # resultado para x = 10

  0.7763 * 10 + 7.4757
```

    ## [1] 15.2387

c\)

``` r
cor.test(dados_q4$X, dados_q4$Y)
```

    ## 
    ##  Pearson's product-moment correlation
    ## 
    ## data:  dados_q4$X and dados_q4$Y
    ## t = 3.3389, df = 4, p-value = 0.02887
    ## alternative hypothesis: true correlation is not equal to 0
    ## 95 percent confidence interval:
    ##  0.1524457 0.9842105
    ## sample estimates:
    ##       cor 
    ## 0.8578719

Como o p-valor é menor que 0.05, o resultado indica que existe
correlação significativa entre as variáveis.
