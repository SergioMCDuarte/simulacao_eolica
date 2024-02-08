import xarray as xr
import logging
import argparse


def main(path, loglevel):

    logging.basicConfig(level=loglevel)

    logging.info("A ler ficheiro: " + path)

    ds = xr.open_dataset(path, engine='cfgrib')
    # fazer média espacial da grelha 4x4

    logging.info("A calcular média espacial...")

    media_espacial = ds.groupby('time').mean(...)
    # combinar componentes u e v para óbter o módulo da velocidade

    logging.info("A calcular módulo da velocidade a 10m...")

    velocidade_de_vento_10m = (media_espacial["u10"]**2 + media_espacial["v10"]**2)**(1/2)

    velocidade_de_vento_10m \
        .to_dataframe(name="velocidade_de_vento")["velocidade_de_vento"] \
        .to_csv(args.ficheiro.split("/", 1)[0] + "/velocidade_de_vento10m.csv")

    logging.info("A calcular módulo da velocidade a 100m...")

    velocidade_de_vento_100m = (media_espacial["u100"]**2 + media_espacial["v100"]**2)**(1/2)

    velocidade_de_vento_100m \
        .to_dataframe(name="velocidade_de_vento")["velocidade_de_vento"] \
        .to_csv(args.ficheiro.split("/", 1)[0] + "/velocidade_de_vento100m.csv")

if __name__ == '__main__':

    parser = argparse.ArgumentParser()
    parser.add_argument('-f', '--ficheiro', help="caminho relativo ou absoluto para o ficheiro")
    parser.add_argument('-l', '--loglevel', default='warning')

    args = parser.parse_args()

    main(args.ficheiro, args.loglevel.upper())
