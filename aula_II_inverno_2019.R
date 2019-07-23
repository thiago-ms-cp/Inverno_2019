## ===============================================
##
##          Aula 2 - Ambiente Tidyverse 
##
## ===============================================

## Na aula passada entendemos por alto como funciona
## o R, o Rstudio e o ambiente tidyverse. 

## As lições podem ser listadas como:

# 1) Aprendemos a comentar os scripts;
# 2) Objetos x funcoes; 
# 3) O R funciona com base em pacotes;
# 4) Montamos dataframes;
# 5) Aprendemos funcoes basicas como ....


## Ambiente Tidyverse ============================

# O Tidyverse é um super pacote que guarda pacotes
# menores, importantes para a manipulacao dos 
# dados.

# Dentre os mais famosos, temos o "dplyr", o "ggplot2",
# o "tidyr" e o "stringr".

# Hoje aprenderemos com detalhes como funciona o 
# tidyverse e algumas funcoes novas.

# Como faco para instalar o tidyverse?
install.packages("tidyverse")

# Como faco para rodar o tidyverse?
library(tidyverse)

# Como faco o update do tidyverse?
update.packages()

# Aqui, vamos precisar de uma base de dados 
# para a manipulacao. Seguiremos com a base
# do lapop. Como faco para abrir?

library(rio)
library(tidyverse)
library(janitor)

dir()

lapop14 <- import("lapop_2014.sav")

# como faco para saber os nomes das variaveis?
names(lapop14)

# como faco para saber os tipos das variaveis?
glimpse(lapop14)


## ======================================
## Exercicio 1:
## 1) Abrir o LAPOP,
## 2) Renomear a variavel "brawrs1" 
## para "pbf" e "sexi" para "sexo"
## 3) Selecionar as duas variaveis e
## criar uma nova base
## 4) Tabular a variavel pbf
## 5) Ver a diferenca percentual de pbf 
## dado o sexo dos respondentes
## 6) Salvar a analise em ".csv"
## =====================================

# seguindo com o exercicio da aula passada, 
# como faco para renomear as variaveis?

outrabase <- lapop14 %>% 
  rename(pbf = brawrs1, sexo = sexi)
  
names(outrabase)

# como faco para selecionar as variaveis e 
# criar uma nova base?

outrabase <- outrabase %>% 
  select(pbf, sexo)

# como faco para tabular a variavel pbf?

outrabase %>% 
  tabyl(pbf)

# como faco para tabular pbf x sexo?

objetox <-outrabase %>% 
  tabyl(pbf, sexo) %>% 
  adorn_crosstab()

outrabase %>% 
  tabyl(sexo, pbf) %>% 
  adorn_crosstab()

# como faco para salvar a analise em ".csv"?

write.csv(objetox, "analise_pbf.csv")

## Legal, diante disso, aprendemos a abrir uma base, 
## selecionar as variaveis, tabular as frequencias 
## e salvar a nossa analise em outros formatos.

# Agora, vamos aprender mais duas coisas: a modificar
# e filtrar as variaveis. 

# Para filtrar uma variavel, usamos a funcao filter, 
# acompanhada do operador logico "==". Todas as vezes
# que operamos com colunas usamos somente um "=". 
# Para lidarmos com linhas, usamos o duplo "==". 

# Exemplo: na base, sabemos que nossa variavel "sexo"
# tem dois valores (1 e 2). 1 para homens e 2 para 
# mulheres. Se eu quiser filtrar uma base diferente
# somente com mulheres, eu devo fazer o seguinte:

base_mulheres <- outrabase %>% 
  filter(sexo == 2)



# Se eu quiser filtrar somente os 3 menores valores
# da variavel "pbf", eu devo fazer:

base_pbf_menores <- outrabase %>% 
  filter(pbf < 4)

# ou 

base_pbf_menores <- outrabase %>% 
  filter(pbf <= 3)

# Na base, tambem podemos filtrar os NA de pbf.
# Logo:

lapop <- outrabase %>% 
  filter(!is.na(pbf))

# No caso, a exclamacao representa a expressao
# "tudo que nao for algo"


# ok, agora aprendemos a filtrar valores das 
# variaveis. Mas e seu eu quisesse modifica-las?
# Exemplo: transformar os valores da variavel sexo
# em 1 para homens e 2 para mulheres. 

# No caso, devemos usar a funcao "mutate". O 
# "mutate" é uma funcao que funciona sempre com 
# duas funcoes auxiliares: o "ifelse" e o "case_when". 
# Usamos o "ifelse" quando queremos fazer um transformacao
# binaria e o "case_when" para transformacoes que nao 
# sao binarias. Exemplo de homens e mulheres abaixo:

lapop_trans <- outrabase %>% 
  mutate(sexo = ifelse(sexo == 1, "Homens", "Mulheres"))


# agora, com o "case_when". Pergunta sobre Bolsa Familia:
# "Beneficiarios do pbf ficam acomodados ao receber seu
# beneficio. Ate que ponto vc concorda com isso?" 
# Na escala, temos: 1- discorda muito a 7 - concorda muito. 
# Logo, reduziremos a escala de 7, para 3 valores. Na nossa
# analise, de 1 a 3 temos os favoraveis, 4 os neutros e 
# 5 a 7 os contrarios.

lapop_trans <- lapop_trans %>% 
  mutate(pbf = case_when(pbf <= 3 ~ "concordam",
                         pbf == 4 ~ "neutros",
                         pbf >= 5 ~ "discordam"))

# como faco para tabular essas porcentagens?

lapop_trans %>% 
  tabyl(pbf, sexo) %>% 
  adorn_crosstab()


# como faco para ver a diferenca de apoio 
# de homens e mulheres em relacao ao pbf?
lapop_trans %>% 
  tabyl(sexo, pbf) %>% 
  adorn_crosstab()


# como faco para salvar a minha analise em .csv?


## =================================================
## Exercicio do dia:
## A pergunda d6 tem o seguinte enunciado:
## O quanto o sr/sra aprova ou desaprova que 
## casais homossexuais tenham o direito de se 
## casar? No caso, a variavel tem 10 pontos. 
## Logo:
## 1) Abra os pacotes instalados, 
## 2) abra o lapop, 
## 3) selecione as variaveis d6 e sexi. 
## 4) renomeie ambas para "homo" e "sexo", 
## respectivamente.
## 5) modifique sexo para 1 = homens e 2 = mulheres,
## e reduza a variavel "homo" para 3 categorias (
## 1 a 4 = "desaprova", 5 e 6 "neutro", 7 a 10 =
## "aprova")
## 6) Tabule as frequencias da variavel "homo"
## 7) Veja as diferencas entre os sexos. 
## 8) Salve a analise em .csv
## =================================================











































