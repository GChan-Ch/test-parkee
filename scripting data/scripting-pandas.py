import pandas as pd

# Langkah 1: Membaca Semua CSV dan Menggabungkannya
files = ['branch_a.csv', 'branch_b.csv', 'branch_c.csv']
df_list = []

# Membaca dan menggabungkan file CSV
for file in files:
    df = pd.read_csv(file)
    df_list.append(df)

# Menggabungkan semua DataFrame menjadi satu
df = pd.concat(df_list, ignore_index=True)

# Langkah 2: Membersihkan Data
# Hapus baris yang memiliki NaN pada kolom transaction_id, date, dan customer_id
df.dropna(subset=['transaction_id', 'date', 'customer_id'], inplace=True)

# Ubah format kolom 'date' menjadi tipe datetime
df['date'] = pd.to_datetime(df['date'], errors='coerce')

# Langkah 3: Menghilangkan Duplikat dan Memilih Data dengan Tanggal Terbaru
# Urutkan berdasarkan transaction_id dan date, kemudian ambil yang terbaru untuk setiap transaction_id
df.sort_values(by=['transaction_id', 'date'], ascending=[True, False], inplace=True)
df = df.drop_duplicates(subset=['transaction_id'], keep='first')

# Langkah 4: Hitung Total Penjualan per Cabang
# Tambahkan kolom total_sales yang merupakan hasil dari quantity * price
df['total_sales'] = df['quantity'] * df['price']

# Hitung total penjualan per cabang
total_sales_per_branch = df.groupby('branch')['total_sales'].sum().reset_index()

# Simpan hasilnya ke dalam file CSV
total_sales_per_branch.to_csv('total_sales_per_branch.csv', index=False)

# Tampilkan hasilnya untuk konfirmasi
print(total_sales_per_branch)
