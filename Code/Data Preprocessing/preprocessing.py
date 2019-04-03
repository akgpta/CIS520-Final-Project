import pandas as pd


def main():
    suicide_rates = pd.DataFrame.from_csv("../../Data/Manually-Cleaned/suicide_rates_pivot.csv", index_col=None)
    fertility_rates = pd.DataFrame.from_csv("../../Data/Manually-Cleaned/fertility_rate.csv", index_col=None)
    drinks = pd.DataFrame.from_csv("../../Data/Manually-Cleaned/alcohol_consumption.csv", index_col=None)
    life_expectancy = pd.DataFrame.from_csv("../../Data/Manually-Cleaned/life_expectancy.csv", index_col=None)
    country_population = pd.DataFrame.from_csv("../../Data/Manually-Cleaned/country_population.csv", index_col=None)
    youth_unemployment = pd.DataFrame.from_csv("../../Data/Manually-Cleaned/youth_unemployment.csv", index_col=None)

    countries = suicide_rates['Country'];
    suicide_rates = clean_dataframe(suicide_rates, countries=countries)
    fertility_rates = clean_dataframe(fertility_rates, countries=countries)
    drinks = clean_dataframe(drinks,  countries=countries)
    life_expectancy = clean_dataframe(life_expectancy, countries=countries)
    country_population = clean_dataframe(country_population, countries=countries)
    youth_unemployment = clean_dataframe(youth_unemployment, countries=countries)


    merge1 = pd.merge(fertility_rates, drinks, on="Country");
    merge2 = pd.merge(merge1, life_expectancy, on="Country");
    merge3 = pd.merge(merge2, country_population, on="Country");
    merge4 = pd.merge(merge3, youth_unemployment, on="Country");

    merge4.to_csv("../../Data/Cleaned/X.csv")


    create_Y(suicide_rates)


def clean_country_name(country_name):
    country_name = country_name.replace("[^A-Za-z]", "").lower()
    return country_name


def clean_dataframe(dataframe, countries, country_column='Country'):
    dataframe[country_column] = dataframe[country_column].astype(str);
    dataframe[country_column] = dataframe[country_column].apply(clean_country_name)
    dataframe.sort_values(by=[country_column])
    dataframe = merge_countries(dataframe, country_column_name=country_column, countries=countries)
    return dataframe;


def merge_countries(dataframe, country_column_name='Country', countries=[]):
    dataframe_countries = dataframe[country_column_name]
    dropped_countries = []
    for country in dataframe_countries:
        if country not in countries.tolist():
            dropped_countries.append(country)

    dataframe = dataframe[~dataframe[country_column_name].isin(dropped_countries)]
    return dataframe


def create_Y(dataframe):
    df = dataframe['2010']
    df.to_csv("../../Data/Cleaned/Y_2010.csv")
    df = dataframe['2011']
    df.to_csv("../../Data/Cleaned/Y_2011.csv")
    df = dataframe['2012']
    df.to_csv("../../Data/Cleaned/Y_2012.csv")
    df = dataframe['2013']
    df.to_csv("../../Data/Cleaned/Y_2013.csv")
    df = dataframe['2014']
    df.to_csv("../../Data/Cleaned/Y_2014.csv")

if __name__ == "__main__":
    main()
