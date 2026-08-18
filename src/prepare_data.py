import pandas as pd

df = pd.read_csv("data/raw/customer_churn_synthetic.csv")

df["revenue_at_risk_gbp"] = (
    df["annual_revenue_gbp"] * (df["risk_score"] / 9).clip(0,1)
).where(df["churned"] == 0, 0).round(2)

def priority(row):
    if row["risk_score"] >= 6 and row["annual_revenue_gbp"] >= 1500:
        return "P1"
    if row["risk_score"] >= 4 and row["annual_revenue_gbp"] >= 900:
        return "P2"
    if row["risk_score"] >= 3:
        return "P3"
    return "P4"

df["retention_priority"] = df.apply(priority, axis=1)
df.to_csv("data/processed/customer_churn_tableau_ready.csv", index=False)

print(df.groupby("risk_band")["customer_id"].count())
print("Revenue at risk:", round(df["revenue_at_risk_gbp"].sum(),2))
