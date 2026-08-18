# Suggested Tableau Calculated Fields

## Churn Rate
```tableau
SUM([Churned]) / COUNT([Customer ID])
```

## Revenue at Risk
```tableau
SUM([Revenue at Risk GBP])
```

## High Value Customer
```tableau
IF [Annual Revenue GBP] >= 1500 THEN "High Value"
ELSE "Standard Value"
END
```

## NPS Band
```tableau
IF [NPS Score] >= 50 THEN "Promoter"
ELSEIF [NPS Score] >= 0 THEN "Passive"
ELSE "Detractor"
END
```

## Retention Focus
```tableau
IF [Retention Priority] = "P1" OR [Retention Priority] = "P2"
THEN "Priority Retention"
ELSE "Standard Monitoring"
END
```
