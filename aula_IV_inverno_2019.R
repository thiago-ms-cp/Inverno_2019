##===================================
##
##       Aula 4 - Gráficos
##
##===================================

library(gapminder)
library(tidyverse)
library(janitor)
library(hrbrthemes)

## abrir base ======================================

gapminder <- data.frame(gapminder)


## nomes das variaveis =============================

names(gapminder)


## tipos das variaveis =============================

glimpse(gapminder)

## tabular variaveis ===============================

gapminder %>% 
  tabyl(continent)

gapminder %>% 
  tabyl(continent) %>% 
  arrange(-n)


## grafico de barras

gapminder %>% 
  tabyl(continent) %>% 
  ggplot(aes(x = (continent), y = percent)) + 
  geom_col()


gapminder %>% 
  tabyl(continent) %>% 
  ggplot(aes(x = continent, y = percent)) + 
  geom_col() + 
  theme_bw()

gapminder %>% 
  tabyl(continent) %>% 
  ggplot(aes(x = reorder(continent, -percent), y = percent)) + 
  geom_bar(stat = "identity") + 
  theme_bw() 


gapminder %>% 
  tabyl(continent) %>% 
  ggplot(aes(x = reorder(continent, -percent), y = percent)) + 
  geom_bar(stat = "identity") + 
  theme_bw() + scale_y_percent()


gapminder %>% 
  tabyl(continent) %>% 
  ggplot(aes(x = reorder(continent, -percent), y = percent)) + 
  geom_bar(stat = "identity") + 
  theme_bw() + scale_y_percent() + 
  labs(x = "", y = "",
       title = "Qualquer coisa",
       subtitle = "Subtitulo",
       caption = "Fonte: google.com")

gapminder %>% 
  tabyl(continent) %>% 
  ggplot(aes(x = reorder(continent, -percent), y = percent)) + 
  geom_bar(stat = "identity", fill = "chartreuse3", color = "black") + 
  theme_bw() + scale_y_percent() + 
  labs(x = "", y = "")


## Gráficos interativos ================================

library(plotly)

graf_barra <- gapminder %>% 
  tabyl(continent) %>% 
  ggplot(aes(x = reorder(continent, -percent), y = percent)) + 
  geom_bar(stat = "identity") + 
  theme_bw() +
  labs(x = "", y = "")

ggplotly(graf_barra)

## Como saber mais? Highcharter e Plotly.

names(gapminder)

## boxplot ============================================

gapminder %>% 
  ggplot(aes(x = "", y = lifeExp)) + 
  geom_boxplot()


## histograma =========================================

gapminder %>% 
  ggplot(aes(x = lifeExp)) + 
  geom_histogram()


## densidade ==========================================

gapminder %>% 
  ggplot(aes(x = lifeExp)) + 
  geom_density()+
  geom_histogram()


## scatterplot ========================================

gapminder %>% 
  ggplot(aes(x = log(gdpPercap), y = lifeExp)) + 
  geom_point()


## grafico de pirulito  ===============================

library(ggalt)

gapminder %>% 
  filter(continent == "Americas" & year == 2007) %>% 
  ggplot(aes(x = country, y = lifeExp)) + 
  geom_lollipop()


gapminder %>% 
  filter(continent == "Americas" & year == 2007) %>% 
  ggplot(aes(x = country, y = lifeExp)) + 
  geom_lollipop() + coord_flip()


gapminder %>% 
  filter(continent == "Americas" & year == 2007) %>% 
  ggplot(aes(x = reorder(country, lifeExp), y = lifeExp)) + 
  geom_lollipop() + coord_flip()



## graficos de linhas ===========================

braarg <- gapminder %>% 
  filter(country %in% c("Brazil", "Argentina")) %>% 
  ggplot(aes(x = year, y = lifeExp)) +
  geom_line(aes(color = country)) +
  scale_y_continuous(limits =c(30,90))+
  geom_point()

ggplotly(braarg)

## Onde saber mais? 

## http://r-statistics.co/Top50-Ggplot2-Visualizations-MasterList-R-Code.html

## https://www.ggplot2-exts.org/



# Exercício =========
# 
# 1) Abrir a base gapminder
# 2) Filtrar o Brasil, Cuba, Estados Unidos e Cambodia
# 3) Criar um gráfico de linhas observando a expectativa de vida
# através do tempo entre esses países 
# 4) O gráfico deve conter título, subtítulo, e 
# o nome dos eixos em português
# 5) O nome da legenda "country" deve estar em português 

