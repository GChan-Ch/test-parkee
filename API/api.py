import requests
import pandas as pd

# Mendapatkan data dari API
def get_university_data(country):
    url = f'http://universities.hipolabs.com/search?country={country.replace(" ", "%20")}'
    response = requests.get(url)
    
    # Memeriksa apakah permintaan berhasil
    if response.status_code == 200:
        data = response.json()
        return data
    else:
        print("Gagal mengambil data dari API.")
        return []

# Membuat DataFrame dari data API
def create_dataframe(data):
    # Membuat DataFrame dengan kolom yang diinginkan
    df = pd.DataFrame(data)
    df = df[['name', 'web_pages', 'country', 'domains', 'state-province']]
    df.columns = ["Name", "Web pages", "Country", "Domains", "State Province"]
    return df

# Fungsi untuk memfilter data yang memiliki "State Province" tidak kosong
def filter_non_empty_state_province(df):
    return df[df["State Province"].notna()]

# Mendapatkan data dari API untuk negara yang diinginkan
country = "United States"
data = get_university_data(country)

# Membuat DataFrame dari data API
df = create_dataframe(data)

# Menampilkan DataFrame asli
print("Data asli:")
print(df)

# Memfilter data untuk baris yang memiliki "State Province" tidak kosong
filtered_df = filter_non_empty_state_province(df)

# Menampilkan hasil setelah filter
print("\nData setelah menghilangkan baris tanpa State Province:")
print(filtered_df)
