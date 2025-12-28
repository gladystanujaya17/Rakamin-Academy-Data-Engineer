USE DWH
-- SP BalancePerCustomer

CREATE PROCEDURE BalancePerCustomer
	@name VARCHAR(255)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT
		ft.TransactionID,
		c.CustomerName,
		ft.TransactionDate,
		ac.AccountType,
		ac.Balance,
		(ac.Balance + 
			ISNULL(
				SUM(
					CASE	
						WHEN ft.TransactionType = 'Deposit' THEN ft.Amount
						ELSE -ft.Amount
					END 
				), 0
			)
		) AS Amount,
		ft.TransactionType
	FROM DimCustomer c
	INNER JOIN DimAccount ac ON c.CustomerID = ac.CustomerID
	LEFT JOIN FactTransaction ft ON ac.AccountID = ft.AccountID
	WHERE c.CustomerName LIKE '%' + @name + '%'
	AND ac.status = 'Active'
	GROUP BY
	c.CustomerName,
	ac.AccountType,
	ac.Balance,
	ft.TransactionDate,
	ac.AccountType,
	ft.TransactionID,
	ft.TransactionType
	ORDER BY
	ft.TransactionDate ASC,
	c.CustomerName,
	ac.AccountType;
END;
GO

EXEC BalancePerCustomer @name = 'Shelly';