import pandas as pd
import os
from sqlalchemy import create_engine
from dotenv import load_dotenv


# =========================
# 1. EXTRACT
# =========================
def extract():
    print("📥 Extracting data from CSV...")

    df = pd.read_csv("../data/sale_query.csv")

    print("✅ Data loaded successfully")
    print(df.head())

    return df


# =========================
# 2. TRANSFORM (hiện tại bạn chưa xử lý nhiều)
# =========================
def transform(df):
    print("🔄 Transforming data...")

    # Ví dụ basic (có thể thêm sau)
    df = df.dropna()

    print("✅ Data cleaned")
    return df


# =========================
# 3. LOAD
# =========================
def load(df):
    print("📤 Loading data to PostgreSQL...")

    # load biến môi trường
    load_dotenv("../password.env")

    username = os.getenv("DB_USER")
    password = os.getenv("DB_PASSWORD")
    host = os.getenv("DB_HOST")
    port = os.getenv("DB_PORT")
    database = os.getenv("DB_NAME")

    engine = create_engine(
        f"postgresql://{username}:{password}@{host}:{port}/{database}"
    )

    # test connection
    engine.connect()
    print("✅ Connected to PostgreSQL")

    # load data
    df.to_sql("sales_raw", engine, if_exists="replace", index=False)

    print("✅ Data loaded successfully")


# =========================
# MAIN PIPELINE
# =========================
def main():
    df = extract()
    df = transform(df)
    load(df)


if __name__ == "__main__":
    main()
