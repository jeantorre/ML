## 1. Descrição
*Machine Learning* (ML), o "Aprendizado de Máquina", é algo extremamente presente nos dias de hoje na vida de um analistas de dados. Dado o grande volume de informações que são geradas a cada minuto, é necessário o uso dessas ferramentas que podem de forma mais rápida, e quando bem estruturada com alta assertividade, trazer importantes *insights* e previsões para um negócio, por exemplo.  
Existem vários tipos ML que podem ser classificados em:

* Aprendizado supervisionado
* Aprendizado não supervisionado
* Aprendizado por reforço  

Hoje trago um ML básico que alguns já viram em alguma época da sua vida e não se deram conta... a Regressão Linear. Esta função gerará a popularmente conhecida nos ensinos médios do Brasil, e quem sabe até antes, equação da reta. Sim, aquela mesmo: y = ax + b.

## 2. Preparação dos dados
A fonte de dados utilizada neste projeto é do Kaggle, que pode ser encontrada [aqui](https://www.kaggle.com/datasets/andonians/random-linear-regression).

### Bibliotecas utilizadas
``` Python
import pandas as pd
import numpy as np

import matplotlib.pyplot as plt
import seaborn as sns
import mplcyberpunk
plt.style.use("cyberpunk")

import os

from sklearn.linear_model import LinearRegression
from sklearn.metrics import mean_squared_error, mean_absolute_error
```

### Disposição dos dados
Como de costume, primeiro é necessário entender o comportamento dos dados coletados, descobrindo seu tipo e se há valores faltantes.
```Python
df.info()
df.isnull().sum()
```

Foi encontrado um dado faltante na coluna 'Y' e esta linha foi apenas desconsiderada do DF, utilizando o seguinte código:
```Python
df = df.dropna()
```

Feito isto podemos seguir com o ML.

### Tratamento dos dados
Inicialmente pode ser interessantes ver como os valores se relacionam e para isso podemos fazer de duas maneiras diferentes:
* Criar um gráfico chamado "Mapa de Calor" que mostra a correlação entre os eixos X e Y.
```Python
fig, ax = plt.subplots()

ax = sns.heatmap(data = df.corr(), annot = True, linewidths = .3, cmap = "RdYlGn", fmt = '.2f')
plt.title('Correlação entre eixos', fontsize = 15)

plt.show()
```

* Utilizar um método da biblioteca NumPy que nos retorna uma matriz com esses resultados.
```Python
np.corrcoef(df.loc[:, 'x'].values, df.loc[:, 'y'].values)
```

Como esta é uma base de dados apenas para treinamento e aprendizado deste assunto vemos os incríveis 100% de correlação entre as colunas, o que certamente não é algo comum no dia a dia de um analista. Não é mesmo?  
Dando sequência ao código, precisamos atender as necessidades da biblioteca 'scikit-learn' que nos pede uma série bidimensional para treinamento do ML.  
Apenas para uma rápida - e supérflua - explicação... DataFrame, que é o formato da base de dados utilizada neste estudo, pode ser vista como um conjunto de séries. O que eu quero dizer com isso é que a coluna_1 com seus valores representa uma série, a coluna_2 com seus respectivos valores representa outra série e quando juntamos essas duas séries temos um DataFrame.  
Sendo assim é necessário pegar os valores de cada coluna.
```Python
x_atual = df.loc[:, 'x'].values
y_atual = df.loc[:, 'y'].values
```

Ao fazer isso teremos 2 séries com seus respectivos valores, que são séries unidimensionais. Como dito anteriormente, é necessário transformar em bidimensional e faremos isso na hora de treinar o modelo.
```Python
lin_reg = LinearRegression()
lr_model = lin_reg.fit(x_atual.reshape(-1, 1), y_atual)
```

Agora com o modelo treinado seguiremos para as análises.

## 3. Análise dos dados
```Python
score = lr_model.score(x_atual.reshape(-1, 1), y_previsto)
coeficiente_angular = lr_model.coef_
intercepto = lr_model.intercept_
mae = mean_absolute_error(y_previsto, y_atual)

print(f'O valor do score do modelo criado é {score}')
print(f'O coeficiente angular do modelo criado é {coeficiente_angular}')
print(f'O intercepto do modelo criado é {intercepto}')
print(f'O valor do MAE do modelo criado é {mae}')
```

Com o código acima é possível retirar algumas informações do ML de regressão linear criado, tais como:
* Score - que é uma função da biblioteca sklearn que indica o quão confiável é este modelo. Seus resultados variam de 0 a 1 e quanto maior, melhor  
* Coeficiente angular e intercepto da reta
* *Mean Absolute Error* (MAE) - sua tradução significa "erro médio absoluto", que é uma função estatística em que mostra a média dos erros previstos e reais do modelo. No exemplo criado o valor do erro foi de 2,22, ou seja, os valores previstos a partir de agora podem variar, em média, até 2,22 pontos positivos ou negativos.


## 4. Conclusões
O Python vem se mostrando uma ferramenta extremamente poderosa e, até certo ponto, simples de se utilizar. Cada dia consigo aprender algo novo e aprimorar minhas habilidades!  
Com poucas linhas de código podemos realizar com facilidade cálculos complexos que podem agregar, e muito, negócios em suas tomadas de decisões, por exemplo.
