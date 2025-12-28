USE DWH

-- SP DailyTransaction

CREATE PROCEDURE DailyTransaction
	@start_date DATE,
	@end_date DATE
AS
BEGIN
	SET NOCOUNT ON;

	SELECT
		CAST(TransactionDate AS DATE) AS [Date],
		COUNT(*) AS TotalTransactions,
		SUM(Amount) AS TotalAmount
	FROM FactTransaction
	WHERE TransactionDate BETWEEN @start_date AND @end_date
	GROUP BY CAST(TransactionDate AS DATE)
	ORDER BY [Date] ASC;
END
GO

EXEC DailyTransaction @start_date = '2024-01-18', @end_date = '2024-01-21';