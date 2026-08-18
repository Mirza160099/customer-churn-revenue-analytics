-- Customer Churn & Revenue Analytics

-- 1. Overall churn rate
SELECT
    COUNT(*) AS customers,
    ROUND(100.0 * AVG(churned),2) AS churn_rate_pct
FROM customer_churn;

-- 2. Churn by segment
SELECT segment,
       COUNT(*) AS customers,
       ROUND(100.0 * AVG(churned),2) AS churn_rate_pct,
       ROUND(SUM(annual_revenue_gbp),2) AS annual_revenue_gbp
FROM customer_churn
GROUP BY segment
ORDER BY churn_rate_pct DESC;

-- 3. Churn by contract
SELECT contract_type,
       COUNT(*) AS customers,
       ROUND(100.0 * AVG(churned),2) AS churn_rate_pct
FROM customer_churn
GROUP BY contract_type
ORDER BY churn_rate_pct DESC;

-- 4. Revenue at risk by segment
SELECT segment,
       ROUND(SUM(revenue_at_risk_gbp),2) AS revenue_at_risk_gbp
FROM customer_churn
GROUP BY segment
ORDER BY revenue_at_risk_gbp DESC;

-- 5. Retention priority queue
SELECT customer_id, segment, contract_type, product_tier,
       risk_score, risk_band, annual_revenue_gbp,
       revenue_at_risk_gbp, retention_priority
FROM customer_churn
WHERE churned = 0
ORDER BY retention_priority, revenue_at_risk_gbp DESC;

-- 6. Behavioural drivers
SELECT
    CASE WHEN days_since_last_login > 30 THEN 'Inactive 30+ days' ELSE 'Active' END AS activity_band,
    ROUND(100.0 * AVG(churned),2) AS churn_rate_pct
FROM customer_churn
GROUP BY activity_band;

-- 7. NPS and churn
SELECT
    CASE
      WHEN nps_score >= 50 THEN 'Promoter'
      WHEN nps_score >= 0 THEN 'Passive'
      ELSE 'Detractor'
    END AS nps_band,
    ROUND(100.0 * AVG(churned),2) AS churn_rate_pct
FROM customer_churn
GROUP BY nps_band;
