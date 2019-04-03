import pandas as pd


def main():
    suicide_rates = pd.DataFrame.from_csv("../../Data/Manually-Cleaned/suicide_rates_pivot.csv", index_col=None)
    suicide_rates = clean_suicide_rates(suicide_rates)
    fertility_rates = pd.DataFrame.from_csv("../../Data/Manually-Cleaned/fertility_rate.csv", index_col=None)
    fertility_rates = clean_fertility_rates(fertility_rates, countries=suicide_rates['Country'])
    drinks = pd.DataFrame.from_csv("../../Data/Manually-Cleaned/drinks.csv", index_col=None)
    print(drinks);


def clean_country_name(country_name):
    country_name = country_name.replace("[^A-Za-z]", "").lower()
    return country_name


def clean_fertility_rates(fertility_rate_dataframe, countries=[]):
    fertility_rate_dataframe['Country'] = fertility_rate_dataframe['Country'].astype(str);
    fertility_rate_dataframe.sort_values(by=['Country'])
    fertility_rate_dataframe['Country'] = fertility_rate_dataframe['Country'].apply(clean_country_name);
    fertility_rate_countries = fertility_rate_dataframe['Country'];
    dropped_countries = []
    for country in fertility_rate_countries:
        if (country not in countries):
            dropped_countries.append(country);

    #fertility_rate_dataframe = fertility_rate_dataframe[~fertility_rate_dataframe['Country'].isin(dropped_countries)]

    return fertility_rate_dataframe



def clean_suicide_rates(suicide_rate_dataframe):
    suicide_rate_dataframe.sort_values(by=['Country'])
    suicide_rate_dataframe['Country'] = suicide_rate_dataframe['Country'].apply(clean_country_name);
    return suicide_rate_dataframe


if __name__ == "__main__":
    main()
