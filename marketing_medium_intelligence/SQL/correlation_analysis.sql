WITH stats AS (
  SELECT 
    AVG(affiliate_marketing) AS avg_affiliate_marketing,
    AVG(product_sold) AS avg_product_sold,
    STDDEV(affiliate_marketing) AS std_affiliate_marketing,
    STDDEV(product_sold) AS std_product_sold
  FROM advertising_data
),
deviations AS (
  SELECT 
    a.affiliate_marketing,
    a.product_sold,
    s.avg_affiliate_marketing,
    s.avg_product_sold,
    s.std_affiliate_marketing,
    s.std_product_sold,
    (a.affiliate_marketing - s.avg_affiliate_marketing) * (a.product_sold - s.avg_product_sold) AS dev_product
  FROM advertising_data a
  CROSS JOIN stats s
)

SELECT 
  AVG(dev_product) AS covariance,
  AVG(dev_product) / (MAX(std_affiliate_marketing) * MAX(std_product_sold)) AS correlation
FROM deviations;

