import pandas as pd


def main():
    suicide_rates = pd.DataFrame.from_csv("../../Data/Manually-Cleaned/suicide_rates_pivot.csv", index_col=None)
    fertility_rates = pd.DataFrame.from_csv("../../Data/Manually-Cleaned/fertility_rate.csv", index_col=None)
    drinks = pd.DataFrame.from_csv("../../Data/Manually-Cleaned/alcohol_consumption.csv", index_col=None)
    life_expectancy = pd.DataFrame.from_csv("../../Data/Manually-Cleaned/life_expectancy.csv", index_col=None)
    country_population = pd.DataFrame.from_csv("../../Data/Manually-Cleaned/country_population.csv", index_col=None)
    youth_unemployment = pd.DataFrame.from_csv("../../Data/Manually-Cleaned/youth_unemployment.csv", index_col=None)

    suicide_rates = clean_dataframe(suicide_rates)
    fertility_rates = clean_dataframe(fertility_rates)
    drinks = clean_dataframe(drinks, country_column='country')
    life_expectancy = clean_dataframe(life_expectancy)
    country_population = clean_dataframe(country_population)
    youth_unemployment = clean_dataframe(youth_unemployment)


def clean_country_name(country_name):
    country_name = country_name.replace("[^A-Za-z]", "").lower()
    return country_name


def clean_dataframe(dataframe, country_column='Country'):
    dataframe[country_column] = dataframe[country_column].astype(str);
    dataframe[country_column] = dataframe[country_column].apply(clean_country_name)
    dataframe.sort_values(by=[country_column])
    return dataframe;


if __name__ == "__main__":
    main()
