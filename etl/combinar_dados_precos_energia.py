import os
import pandas as pd
from datetime import datetime as dt
# dados obtidos de https://www.omie.es/en/file-access-list?parents%5B0%5D=/&parents%5B1%5D=Day-ahead%20Market&parents%5B2%5D=1.%20Prices&dir=%20Day-ahead%20market%20hourly%20price%20in%20Portugal&realdir=marginalpdbcpt
def listar_ficheiros(path: str ='../dados/precos_energia/') -> list:

    return [os.path.abspath(path + f) for f in sorted(os.listdir(path))]


def ler_ficheiro(path: str):
    dados = []
    with open(path, 'r') as f:
        for line in f:
            try:
                # a primeira e a última linha de cada ficheiro têm lixo...
                a, m, d, h, p, _, _ = line.split(';')
            except:
                continue

            dados.append([a, m, d, h, p])

    return dados


def ler_multiplos_ficheiros(lista_ficheiros: list) -> pd.DataFrame:
    dados = []

    for ficheiro in lista_ficheiros:
        dados.extend(ler_ficheiro(ficheiro))

    dados_df = pd.DataFrame(dados,
                            columns=["ano", "mes", "dia", "hora", "preco"])

    return dados_df


if __name__ == '__main__':

    lista = listar_ficheiros()

    ler_multiplos_ficheiros(lista).to_csv('../dados/precos_energia.csv', index=False)